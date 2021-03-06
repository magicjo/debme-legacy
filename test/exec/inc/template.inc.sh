#!/usr/bin/env bash

set -o nounset
set -o errexit

function template_setup_connection(){
    local tmpfile=$(mktemp "${TEST__CONF_SETUP_TMP}.XXXXXX")
    sed "s#\$CONNECTION_HOST#${TEST__CONF_SSH_IP}#g ; \
        s#\$CONNECTION_USER#${TEST__CONF_SETUP_SSH_USER}#g ; \
        s#\$CONNECTION_SSH_PORT#${TEST__CONF_SSH_PORT}#g ; \
        s#\$CONNECTION_SSH_PASSWORD#${TEST__CONF_SETUP_SSH_PASSWORD}#g ; \
        s#\$SUPPORT_UI#${TEST__CLI_ARGS_UI}#g" ${TEST__DEBME_ENVS_SETUP} > ${tmpfile}
    echo ${tmpfile}
}

function template_tasks_connection(){
    local tmpfile=$(mktemp "${TEST__CONF_TASKS_TMP}.XXXXXX")
    sed "s#\$CONNECTION_HOST#${TEST__CONF_SSH_IP}#g ; \
        s#\$CONNECTION_USER#${TEST__CONF_TASKS_SSH_USER}#g ; \
        s#\$CONNECTION_SSH_PORT#${TEST__CONF_SSH_PORT}#g ; \
        s#\$CONNECTION_SSH_PASSWORD#${TEST__CONF_TASKS_SSH_PASSWORD}#g; \
        s#\$SUPPORT_UI#${TEST__CLI_ARGS_UI}#g" ${TEST__DEBME_ENVS_TASKS} > ${tmpfile}
    echo ${tmpfile}
}
