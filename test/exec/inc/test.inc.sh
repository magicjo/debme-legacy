#!/usr/bin/env bash

set -o nounset
set -o errexit

function print_test(){
    local name="$1"
    local user="$2"
    local password="$3"
    local first_line="$4"
    cat <<-EOF
================================
TEST ${name}
----------
${first_line}
ip: ${TEST__CONF_SSH_IP}
port: ${TEST__CONF_SSH_PORT}
user: ${user}
password: ${password}
================================
EOF
    sleep "${TEST__CONF_TIMEOUT_TEST}"
}

function ssh_known_hosts(){
    ssh-keygen -f ~/.ssh/known_hosts -R "[${TEST__CONF_SSH_IP}]:${TEST__CONF_SSH_PORT}" > /dev/null 2>&1
    ssh-keyscan "${TEST__CONF_SSH_IP}" -p "${TEST__CONF_SSH_PORT}" >> ~/.ssh/known_hosts
}

function check_test(){
    local tmpfile="$1"
    echo "CHECK failed";
    tail -n 2 ${tmpfile} | grep "failed=0"
    echo "CHECK unreachable"
    tail -n 2 ${tmpfile} | grep "unreachable=0"
}
