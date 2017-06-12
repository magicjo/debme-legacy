#!/usr/bin/env bash

set -o nounset
set -o errexit

function run_setup_test(){
    local envs_file="$1"
    local tmpfile=$(mktemp "${TEST__CONF_SETUP_TMP}.XXXXXX")
    ssh-keygen -f ~/.ssh/known_hosts -R "[${TEST__CONF_DOCKER_SSH_IP}]:${TEST__CONF_DOCKER_SSH_PORT}"
    tail --follow ${tmpfile} &
    ${TEST__DEBME_BIN} setup --envs "${envs_file}" -vvvv >> ${tmpfile}
    echo "CHECK failed";
    tail -n 2 ${tmpfile} | grep "failed=0"
    echo "CHECK unreachable"
    tail -n 2 ${tmpfile} | grep "unreachable=0"
}
