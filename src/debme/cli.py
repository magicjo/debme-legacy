#!/usr/bin/env python

# IMPORT
import argparse
import os

# PARSERS ENUM
PARSERS_ENUM = {
    'SETUP': 'setup',
    'TASKS': 'tasks',
    'FOO_BAR': 'foo_bar',
}

# DEBME PARSER
parser = argparse.ArgumentParser(
    prog='debme',
    description='''debme is an app used to deploy a fully configured debian environment

Example:
    $> debme setup --envs envs.json ...

More information on "https://github.com/magicjo/debme"''',
    epilog='''
author: @magicjo
license: MIT
project: "https://github.com/magicjo/debme"''',
    formatter_class=argparse.RawTextHelpFormatter
)
sub_parsers = parser.add_subparsers()


def envs_args(parser, required):
    # envs arg cli
    parser.add_argument(
        '--envs', '-e',
        help='''environments hosts described by a json file''',
        nargs=1,
        required=required,
        dest='hosts_file',
        action='store'
    )


def verbose_args(parser):
    # verbose arg cli
    parser.add_argument(
        '--verbose', '-v',
        help='''verbosely list files processed''',
        dest='verbose',
        action='count',
        default=0
    )


def hosts_args(parser):
    # hosts arg cli
    parser.add_argument(
        '--hosts', '-H',
        help='''filtering defined hosts in environments by name for execution''',
        nargs='+',
        dest='host_name',
        action='store',
        default=[]
    )


def debug_args(parser):
    # debug-playbooks
    parser.add_argument(
        '--debug-playbooks',
        help=argparse.SUPPRESS,
        dest='debug_playbooks',
        action='store_true',
        default=False
    )


# DEBME SETUP PARSER
setup_parser = sub_parsers.add_parser(
    'setup',
    help='''command used to setup the remote environment for debme,
you must run this command once before install other tasks,
documentation available on "https://github.com/magicjo/debme/blob/master/doc/cli/setup.md"'''
)
setup_parser.set_defaults(which=PARSERS_ENUM['SETUP'])
envs_args(setup_parser, True)
verbose_args(setup_parser)
hosts_args(setup_parser)
debug_args(setup_parser)

# DEBME TASKS PARSER
tasks_parser = sub_parsers.add_parser(
    'tasks',
    help='''command used to execute tasks on the remote environment for debme,
you must run 'setup' once before install other tasks,
documentation available on "https://github.com/magicjo/debme/blob/master/doc/cli/tasks.md"'''
)
tasks_parser.set_defaults(which=PARSERS_ENUM['TASKS'])
tasks_parser_exclusive = tasks_parser.add_mutually_exclusive_group(required=True)
# names arg cli
tasks_parser_exclusive.add_argument(
    '--list', '-l',
    help='''list the defined tasks''',
    dest='list',
    action='store_true',
    default=False
)
# names arg cli
tasks_parser.add_argument(
    '--names', '-T',
    help='''filtering defined tasks by name for execution''',
    nargs='+',
    dest='tasks_name',
    action='store',
    default=[]
)
envs_args(tasks_parser_exclusive, False)
verbose_args(tasks_parser)
hosts_args(tasks_parser)
debug_args(tasks_parser)

# FOO BAR PARSER
class ThrowingArgumentParser(argparse.ArgumentParser):
    def error(self, message):
        raise Exception()


foo_bar_parser = ThrowingArgumentParser(add_help=False)
foo_bar_parser.set_defaults(which=PARSERS_ENUM['FOO_BAR'])
foo_bar_parser.add_argument(
    '--foo', '--bar', '--wtf',
    dest='foo_bar',
    action='count'
)


# EXPORT
def cli():
    try:
        args = vars(foo_bar_parser.parse_args())
        if args['foo_bar'] is None:
            raise Exception()
        return args
    except Exception:
        args = vars(parser.parse_args())
        args['playbooks_path'] = os.environ['DEBME_PLAYBOOKS_PATH']
        return args
