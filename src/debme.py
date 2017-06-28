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
    # Case setup
    if args['which'] == debme.PARSERS_ENUM['TASKS']:
        if args['list']:
            debme.list_tasks()
        else:
            tasks = debme.verify_tasks(args['tasks_name'])
            tasks = debme.sort_tasks(tasks)
            debme.ansible_run(tasks, args)
