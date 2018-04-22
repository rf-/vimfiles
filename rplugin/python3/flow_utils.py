#!/usr/bin/env python
# coding: utf-8

import os
import neovim

CONFIG_FILE = '.flowconfig'


def _find_project_root(dir):
    try:
        if CONFIG_FILE in os.listdir(dir):
            return dir
        elif dir == '/':
            return None
        else:
            return _find_project_root(os.path.dirname(dir))
    except:
        return None


def _find_flow_bin(dir):
    local_flow = dir + '/node_modules/.bin/flow'

    if os.access(local_flow, os.X_OK):
        return local_flow
    else:
        return 'flow'


@neovim.plugin
class FlowUtils(object):
    def __init__(self, vim):
        self.vim = vim
        self._projects = {}

    @neovim.function('FlowType', sync=True)
    def flow_type(self, args):
        project_root, flow_bin, relative_path = self.get_flow_context()

        from subprocess import Popen, PIPE
        import json

        line = str(self.vim.current.window.cursor[0])
        column = str(self.vim.current.window.cursor[1] + 1)

        command = [flow_bin, 'type-at-pos', '--json', line, column]

        if relative_path:
            command.extend(['--path', relative_path])

        buf = '\n'.join(self.vim.current.buffer[:])

        try:
            process = Popen(command, stdout=PIPE, stdin=PIPE, cwd=project_root)
            stdout, stderr = process.communicate(str.encode(buf))

            if process.returncode == 0:
                results = json.loads(stdout.decode('utf-8'))
                self.vim.command(
                    "echo '%s'" % results['type'].replace("'", "''")
                )

        except FileNotFoundError:
            pass

    def get_flow_context(self):
        filename = self.vim.eval("expand('%:p')")

        if len(filename) > 0:
            project_root, flow_bin = self._get_flow_project(filename)
        else:
            project_root, flow_bin = self._get_flow_project(os.getcwd() + '/')

        if project_root is None:
            return (project_root, flow_bin, None)

        if len(filename) > 0 and os.access(filename, os.F_OK):
            relative_path = os.path.relpath(filename, project_root)
        else:
            relative_path = None

        return (project_root, flow_bin, relative_path)

    def _get_flow_project(self, filename):
        for project_root in self._projects:
            if filename.startswith(project_root):
                return (project_root, self._projects[project_root])

        project_root = _find_project_root(os.path.dirname(filename))
        if not project_root:
            return (None, None)

        flow_bin = _find_flow_bin(project_root)
        self._projects[project_root] = flow_bin
        return (project_root, flow_bin)
