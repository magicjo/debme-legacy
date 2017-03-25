#!/usr/bin/env python

# IMPORT
import debme

# MAIN
if __name__ == '__main__':
    # Get args
    args = debme.cli()
    # Case setup
    if args['which'] == debme.PARSERS_ENUM['SETUP']:
        debme.ansible_run(['setup'], args)
