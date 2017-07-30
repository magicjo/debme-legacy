#!/usr/bin/env bash

set -o nounset
set -o errexit

function vm_set_env(){
    TEST__CONF_SSH_IP=${TEST__CLI_ARGS_VM_IP}
}
