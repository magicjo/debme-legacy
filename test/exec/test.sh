#!/usr/bin/env bash

set -o nounset
set -o errexit

# IMPORT
source "test/conf.inc.sh"
source "test/exec/resource/conf.inc.sh"
source "test/exec/inc/template.inc.sh"
source "test/exec/inc/docker.inc.sh"
source "test/exec/inc/test.setup.inc.sh"
source "test/exec/inc/test.tasks.inc.sh"

# ARGS
HAVE_START=false
HAVE_TEST_SETUP=false
HAVE_TEST_TASKS=false
TEST_TASKS_LIST="system dev"
HAVE_END=false
if [[ $# -eq 0 ]]
then
    HAVE_START=true
    HAVE_TEST_SETUP=true
    HAVE_TEST_TASKS=true
    HAVE_END=true
fi
while [[ $# -gt 0 ]]
do
    case "$1" in
        -s|--start)
            HAVE_START=true
            shift
        ;;
        -t|--test-setup)
            HAVE_TEST_SETUP=true
            shift
        ;;
        -T|--test-tasks-all)
            HAVE_TEST_TASKS=true
            shift
        ;;
        -N|--test-tasks)
            HAVE_TEST_TASKS=true
            TEST_TASKS_LIST=$(echo $2 | tr "," " ")
            shift
            shift
        ;;
            -e|--end)
            HAVE_END=true
            shift
        ;;
        *)
            # unknown option
            shift
        ;;
    esac
done

# CONTEXT
export ANSIBLE_HOST_KEY_CHECKING=false
cd "${TEST__CONF_DIR}"

# CREATE DOCKER CONTAINER
if [[ "${HAVE_START}" = "true" ]]
then
    docker_build
    docker_run
fi


# RUN TEST SETUP
if [[ "${HAVE_TEST_SETUP}" = "true" ]]
then
    docker_print_container
    echo "Run test SETUP"
    sleep "${TEST__CONF_TIMEOUT_TEST}"
    setup_hosts=$(template_setup_connection)
    echo "setup_host_file: ${setup_hosts}"
    run_setup_test "${setup_hosts}"
fi

# RUN TEST TASKS
if [[ "${HAVE_TEST_TASKS}" = "true" ]]
then
    docker_print_container
    echo "Run test TASKS (${TEST_TASKS_LIST})"
    sleep "${TEST__CONF_TIMEOUT_TEST}"
    tasks_hosts=$(template_tasks_connection)
    echo "tasks_host_file: ${tasks_hosts}"
    run_tasks_test "${tasks_hosts}" "${TEST_TASKS_LIST}"
fi

# CLEAN UP TEST
if [[ "${HAVE_END}" = "true" ]]
then
    docker_clean
    rm -Rf "${TEST__CONF_SETUP_TMP}"*
    rm -Rf "${TEST__CONF_TASKS_TMP}"*
fi
