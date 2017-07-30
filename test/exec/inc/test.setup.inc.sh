#!/usr/bin/env bash

set -o nounset
set -o errexit

function setup_test(){
    print_test "SETUP" "${TEST__CONF_SETUP_SSH_USER}" "${TEST__CONF_SETUP_SSH_PASSWORD}" "ui: ${TEST__CLI_ARGS_SETUP_UI}"
    ssh_known_hosts

    local envs_file=$(template_setup_connection)
    local tmpfile=$(mktemp "${TEST__CONF_SETUP_TMP}.XXXXXX")
    echo "setup_host_file: ${envs_file}"
    tail --follow ${tmpfile} &

    local other_options=""
    if [[ "${TEST__CLI_ARGS_SETUP_UI}" = "true" ]]
    then
        other_options="${other_options} --ui"
    fi
    ${TEST__DEBME_BIN} setup --envs "${envs_file}" ${other_options} -vvvv >> ${tmpfile}

    check_test "${tmpfile}"
}
