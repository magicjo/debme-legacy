#!/usr/bin/env bash

set -o nounset
set -o errexit

# IMPORT
source "test/conf.inc.sh"
source "test/exec/resource/conf.inc.sh"
source "test/exec/inc/cli.inc.sh"

source "test/exec/inc/docker.inc.sh"
source "test/exec/inc/vm.inc.sh"

source "test/exec/inc/template.inc.sh"
source "test/exec/inc/test.inc.sh"
source "test/exec/inc/test.setup.inc.sh"
source "test/exec/inc/test.tasks.inc.sh"

# PARSE CLI
cli "$@"

# EXEC

## CONTEXT
export ANSIBLE_HOST_KEY_CHECKING=false
cd "${TEST__CONF_DIR}"

## docker-start
if [[ "${TEST__CLI_ARGS_DOCKER_START}" = "true" ]]
then
    docker_start
fi

## DOCKER
if [[ "${TEST__CLI_CMD}" = "docker" ]]
then
    docker_set_env
fi

## VM
if [[ "${TEST__CLI_CMD}" = "vm" ]]
then
    vm_set_env
fi

## RUN TEST SETUP
if [[ "${TEST__CLI_ARGS_SETUP}" = "true" ]]
then
    setup_test
fi

## RUN TEST TASKS
if [[ "${TEST__CLI_ARGS_TASKS}" = "true" ]]
then
    tasks_test
fi

## docker-end
if [[ "${TEST__CLI_ARGS_DOCKER_END}" = "true" ]]
then
    docker_end
fi