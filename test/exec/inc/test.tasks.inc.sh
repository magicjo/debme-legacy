#!/usr/bin/env bash

set -o nounset
set -o errexit

function tasks_test(){
    print_test "TASKS" "${TEST__CONF_TASKS_SSH_USER}" "${TEST__CONF_TASKS_SSH_PASSWORD}" "${TEST__CLI_ARGS_TASKS_NAMES}"
    ssh_known_hosts

    local tasks="${TEST__CLI_ARGS_TASKS_NAMES}"
    local envs_file=$(template_tasks_connection)
    local tmpfile=$(mktemp "${TEST__CONF_TASKS_TMP}.XXXXXX")
    echo "tasks_host_file: ${envs_file}"
    tail --follow ${tmpfile} &

    ${TEST__DEBME_BIN} tasks --names "${tasks}" --envs "${envs_file}" "${TEST__CLI_ARGS_VERBOSE}" >> ${tmpfile}

    check_test "${tmpfile}"
}
