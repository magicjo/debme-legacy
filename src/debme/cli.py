#!/usr/bin/env python

# IMPORT
import argparse
import os

# PARSERS ENUM
PARSERS_ENUM = {
    'SETUP': 'setup',
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

# DEBME SETUP PARSER
setup_parser = sub_parsers.add_parser(
    'setup',
    help='''command used to setup the remote environment for debme,
you must run this command once before install other tasks,
documentation available on "https://github.com/magicjo/debme/blob/master/doc/cli/setup.md"'''
)
setup_parser.set_defaults(which=PARSERS_ENUM['SETUP'])

# SETUP envs arg cli
setup_parser.add_argument(
    '--envs', '-e',
    help='''environments hosts described by a json file''',
    nargs=1,
    required=True,
    dest='hosts_file',
    action='store'
)

# SETUP verbose arg cli
setup_parser.add_argument(
    '--verbose', '-v',
    help='''verbosely list files processed''',
    dest='verbose',
    action='count',
    default=0
)

# SETUP hosts arg cli
setup_parser.add_argument(
    '--hosts', '-H',
    help='''filtering defined hosts in environments by name for execution''',
    nargs='+',
    dest='host_name',
    action='store',
    default=[]
)

# SETUP debug-playbooks
setup_parser.add_argument(
    '--debug-playbooks',
    help=argparse.SUPPRESS,
    dest='debug_playbooks',
    action='store_true',
    default=False
)


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
