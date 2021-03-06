#!/usr/bin/env bash

set -o nounset
set -o errexit

function print_test(){
    local name="$1"
    local user="$2"
    local password="$3"
    local tasks="$4"
    cat <<-EOF
================================
TEST ${name}
----------
ui: ${TEST__CLI_ARGS_UI}
ip: ${TEST__CONF_SSH_IP}
port: ${TEST__CONF_SSH_PORT}
user: ${user}
password: ${password}
tasks: ${tasks}
================================
EOF
    sleep "${TEST__CONF_TIMEOUT_TEST}"
}

function ssh_known_hosts(){
    ssh-keygen -f ~/.ssh/known_hosts -R "[${TEST__CONF_SSH_IP}]:${TEST__CONF_SSH_PORT}" > /dev/null 2>&1
    if [[ "${TEST__CLI_CMD}" = 'vm' ]]
    then
        ssh-keyscan "${TEST__CONF_SSH_IP}" -p "${TEST__CONF_SSH_PORT}" >> ~/.ssh/known_hosts
    fi
}

function check_test(){
    local tmpfile="$1"
    echo "CHECK failed";
    tail -n 2 ${tmpfile} | grep "failed=0"
    echo "CHECK unreachable"
    tail -n 2 ${tmpfile} | grep "unreachable=0"
}
