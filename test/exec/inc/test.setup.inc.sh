#!/usr/bin/env bash

set -o nounset
set -o errexit

function setup_test(){
    print_test "SETUP" "${TEST__CONF_SETUP_SSH_USER}" "${TEST__CONF_SETUP_SSH_PASSWORD}" "setup"
    ssh_known_hosts

    local envs_file=$(template_setup_connection)
    local tmpfile=$(mktemp "${TEST__CONF_SETUP_TMP}.XXXXXX")
    echo "setup_host_file: ${envs_file}"
    tail --follow ${tmpfile} &

    ${TEST__DEBME_BIN} setup --envs "${envs_file}" "${TEST__CLI_ARGS_VERBOSE}" >> ${tmpfile}

    check_test "${tmpfile}"
}
