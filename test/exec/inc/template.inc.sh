#!/usr/bin/env bash

set -o nounset
set -o errexit

function template_setup_connection(){
    local dockerInfo="${1}"
    local dockerIp=$(echo "${dockerInfo}" | cut --delimiter=":" --field="2")
    local dockerPort=$(echo "${dockerInfo}" | cut --delimiter=":" --field="3")
    local tmpfile=$(mktemp /tmp/debme-exec-test.XXXXXX)
    sed "s#\$CONNECTION_HOST#${dockerIp}#g ; \
        s#\$CONNECTION_USER#${TEST__CONF_SETUP_SSH_USER}#g ; \
        s#\$CONNECTION_SSH_PORT#${dockerPort}#g ; \
        s#\$CONNECTION_SSH_PASSWORD#${TEST__CONF_SETUP_SSH_PASSWORD}#g" ${TEST__DEBME_ENVS_SETUP} > ${tmpfile}
    echo ${tmpfile}
}
