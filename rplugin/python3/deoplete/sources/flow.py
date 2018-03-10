#!/usr/bin/env python
# coding: utf-8

# Forked from autocomplete-flow by Wojtek Czekalski:
# https://github.com/wokalski/autocomplete-flow

import os
from .base import Base

CONFIG_FILE = '.flowconfig'


def find_project_root(dir):
    if CONFIG_FILE in os.listdir(dir):
        return dir
    elif dir == '/':
        return None
    else:
        return find_project_root(os.path.dirname(dir))


def find_flow_bin(dir):
    local_flow = dir + '/node_modules/.bin/flow'

    if os.access(local_flow, os.X_OK):
        return local_flow
    else:
        return 'flow'


class Source(Base):
    def __init__(self, vim):
        Base.__init__(self, vim)
        self.name = 'flow'
        self.mark = '[flow]'
        self.filetypes = ['javascript']
        self.min_pattern_length = 2
        self.rank = 10000
        self.input_pattern = '((?:\.|(?:,|:|->)\s+)\w*|\()'
        self._projects = {}
        self._completer = Completer(vim)

    def get_complete_position(self, context):
        return self._completer.determine_completion_position(context)

    def gather_candidates(self, context):
        filename = self.vim.eval("expand('%:p')")
        project_root, flow_bin = self.get_flow_context(filename)

        if project_root is None:
            return None

        relative_path = os.path.relpath(filename, project_root)

        return self._completer.find_candidates(
            context,
            project_root,
            flow_bin,
            relative_path
        )

    def get_flow_context(self, filename):
        for project_root in self._projects:
            if filename.startswith(project_root):
                return (project_root, self._projects[project_root])

        project_root = find_project_root(os.path.dirname(filename))
        if not project_root:
            return (None, None)

        flow_bin = find_flow_bin(project_root)
        self._projects[project_root] = flow_bin
        return (project_root, flow_bin)


class Completer(object):
    def __init__(self, vim):
        import re
        self.__vim = vim
        self.__completion_pattern = re.compile('\w*$')

    def determine_completion_position(self, context):
        result = self.__completion_pattern.search(context['input'])

        if result is None:
            return self.__vim.current.window.cursor.col

        return result.start()

    def abbreviate_if_needed(self, text):
        return (text[:47] + '...') if len(text) > 50 else text

    def build_completion_word(self, json):
        if json['func_details']:
            return json['name'] + '('
        else:
            return json['name']

    def find_candidates(self, context, project_root, flow_bin, relative_path):
        from subprocess import Popen, PIPE
        import json

        line = str(self.__vim.current.window.cursor[0])
        column = str(self.__vim.current.window.cursor[1] + 1)

        if relative_path:
            command = [
                flow_bin,
                'autocomplete',
                '--json',
                relative_path,
                line,
                column]
        else:
            command = [flow_bin, 'autocomplete', '--json', line, column]

        buf = '\n'.join(self.__vim.current.buffer[:])

        try:
            process = Popen(command, stdout=PIPE, stdin=PIPE, cwd=project_root)
            stdout, stderr = process.communicate(str.encode(buf))

            if process.returncode != 0:
                return []

            results = json.loads(stdout.decode('utf-8'))

            return [{
                'word': self.build_completion_word(x),
                'abbr': self.abbreviate_if_needed(x['name']),
                'info': x['type'],
                'kind': self.abbreviate_if_needed(x['type'])} for x in results['result']]
        except FileNotFoundError:
            pass
