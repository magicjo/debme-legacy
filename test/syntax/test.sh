#!/usr/bin/env bash

set -o nounset
set -o errexit

# IMPORT
source "test/conf.inc.sh"
source "test/syntax/resource/conf.inc.sh"

# CONTEXT
cd "${TEST__CONF_DIR}"

function syntax_check(){
    local cmd="${1}"
    # Generate the playbooks
    local output_dir=$(${cmd} --debug-playbooks)
    # Test playbook
    ${TEST__ANSIBLE_BIN} --inventory ${output_dir}/hosts ${output_dir}/playbook.yml --list-tasks
    ${TEST__ANSIBLE_BIN} --inventory ${output_dir}/hosts ${output_dir}/playbook.yml --syntax-check
    # Clean
    rm -Rf ${output_dir}
}

# CHECK SETUP
syntax_check "${TEST__DEBME_BIN} setup --envs ${TEST__DEBME_ENVS_SETUP}"
syntax_check "${TEST__DEBME_BIN} tasks --envs ${TEST__DEBME_ENVS_TASKS}"
