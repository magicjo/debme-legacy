#!/usr/bin/env python

# IMPORT
import debme

# MAIN
if __name__ == '__main__':
    # Get args
    args = debme.cli()
    # Case foo bar
    if args['which'] == debme.PARSERS_ENUM['FOO_BAR']:
        debme.foo_bar(args['foo_bar'])
    # Case setup
    if args['which'] == debme.PARSERS_ENUM['SETUP']:
        debme.ansible_run(['setup'], args)
