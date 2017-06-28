#!/usr/bin/env python

# IMPORT
import sys

AVAILABLE_TASKS = [
    'toto',
    'tata'
]


# List task
def list_tasks():
    print '''
tata: DO NO THING    
toto: DO NO THING    
'''


# Verify tasks names and print errors
def verify_tasks(tasks):
    for task in tasks:
        if task not in AVAILABLE_TASKS:
            print 'Task (' + task + ') not supported. Please see `debme tasks --list`'
            sys.exit(1)
    if len(tasks) == 0:
        return AVAILABLE_TASKS
    else:
        return tasks


# Sort tasks by priority
def sort_tasks(tasks):
    tasks_sorted = []
    for task in AVAILABLE_TASKS:
        if task in tasks:
            tasks_sorted.append(task)
    return tasks_sorted
