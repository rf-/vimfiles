#!/usr/bin/env python
# coding: utf-8

# Forked from autocomplete-flow by Wojtek Czekalski:
# https://github.com/wokalski/autocomplete-flow

import os
from .base import Base
from flow_utils import FlowUtils


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
        self._flow_utils = FlowUtils(vim)

    def get_complete_position(self, context):
        return self._completer.determine_completion_position(context)

    def gather_candidates(self, context):
        project_root, flow_bin, relative_path = self._flow_utils.get_flow_context()

        return self._completer.find_candidates(
            context,
            project_root,
            flow_bin,
            relative_path
        )


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
                'word': x['x'],
                'abbr': self.abbreviate_if_needed(x['name']),
                'info': x['type'],
                'kind': self.abbreviate_if_needed(x['type'])} for x in results['result']]
        except FileNotFoundError:
            pass
