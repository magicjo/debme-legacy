#!/usr/bin/env bash

set -o nounset
set -o errexit

function _usage(){
    cat <<-EOF
Test exec for debme:

    From the debme root path:
    $> ./test/exec/test.sh {docker,vm} OPTIONS

---------------------------------------------------------------------
    Common options:

    ===========
    setup:

    --test-setup (-r): Run the setup test.
        By default without the option "--ui"
        "debme setup ..."

    --setup-enable-ui (-U): Add option "--ui" for the setup test.
        "debme setup --ui ..."

    ===========
    tasks:

    --test-tasks (-t): Run the tasks test.
        By default with all no "ui" tasks.
        "debme tasks ..."

    --tasks-enable-ui (-A): Add all "ui" tasks for the tasks test.

    --tasks-names (-N) TASKS: Set the tasks for the tasks test.
        Join tasks names (TASKS) by semicolon: "system,dev,..."

---------------------------------------------------------------------
    docker options:

    --docker-start (-S): Start docker container.

    --docker-end (-E): Delete docker container.

---------------------------------------------------------------------
    vm options:

    --vm-ip (-I): Set the ip of the vm.

EOF
}

function _usage_and_exit(){
    local status=$1
    _usage
    exit ${status}
}

function _only_for_env(){
    local env=$1
    if [[ "${TEST__CLI_CMD}" != "${env}" ]]
    then
        _usage_and_exit 1
    fi
}

function cli(){
    if [[ $# -eq 0 ]]
    then
        _usage_and_exit 0
    fi

    TEST__CLI_CMD="$1"
    if [[ "${TEST__CLI_CMD}" != "docker" && "${TEST__CLI_CMD}" != "vm" ]]
    then
        _usage_and_exit 1
    fi
    shift

    while [[ $# -gt 0 ]]
    do
        case "$1" in

            ## ------------------------------------------
            ## Common options:

            --test-setup|-r)
                TEST__CLI_ARGS_SETUP=true
                shift
                ;;
            --setup-enable-ui|-U)
                TEST__CLI_ARGS_SETUP_UI=true
                shift
                ;;
            --test-tasks|-t)
                TEST__CLI_ARGS_TASKS=true
                shift
                ;;
            --tasks-enable-ui|-A)
                TEST__CLI_ARGS_TASKS_NAMES=${TEST__CLI_ARGS_TASKS_UI_NAMES}
                shift
                ;;
            --tasks-names|-N)
                TEST__CLI_ARGS_TASKS_NAMES=$(echo $2 | tr "," " ")
                shift
                shift
                ;;

            ## ------------------------------------------
            ## Docker options:

            --docker-start|-S)
                _only_for_env "docker"
                TEST__CLI_ARGS_DOCKER_START=true
                shift
                ;;
            --docker-end|-E)
                _only_for_env "docker"
                TEST__CLI_ARGS_DOCKER_END=true
                shift
                ;;

            ## ------------------------------------------
            ## VM options:

            --vm-ip|-I)
                _only_for_env "vm"
                TEST__CLI_ARGS_VM_IP="$2"
                shift
                shift
                ;;

            ## ------------------------------------------
            *)
                # unknown option
                _usage_and_exit 2
            ;;
        esac
    done
}
