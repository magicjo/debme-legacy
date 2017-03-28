#!/usr/bin/env bash

set -o nounset
set -o errexit

function run_setup_test(){
    local envs_file="$1"
    local tmpfile=$(mktemp /tmp/debme-exec-test.XXXXXX)
    tail --follow ${tmpfile} &
    ${TEST__DEBME_BIN} setup --envs "${envs_file}" -vvvv >> ${tmpfile}
    echo "CHECK failed";
    tail -n 2 ${tmpfile} | grep "failed=0"
    echo "CHECK unreachable"
    tail -n 2 ${tmpfile} | grep "unreachable=0"
}
