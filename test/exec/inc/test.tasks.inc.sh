#!/usr/bin/env bash

set -o nounset
set -o errexit

function run_tasks_test(){
    local envs_file="$1"
    local tasks="$2"
    local tmpfile=$(mktemp "${TEST__CONF_TASKS_TMP}.XXXXXX")
    ssh-keygen -f ~/.ssh/known_hosts -R "[${TEST__CONF_DOCKER_SSH_IP}]:${TEST__CONF_DOCKER_SSH_PORT}" > /dev/null 2>&1
    tail --follow ${tmpfile} &
    ${TEST__DEBME_BIN} tasks --names "${tasks}"  --envs "${envs_file}" -vvvv >> ${tmpfile}
    echo "CHECK failed";
    tail -n 2 ${tmpfile} | grep "failed=0"
    echo "CHECK unreachable"
    tail -n 2 ${tmpfile} | grep "unreachable=0"
}
