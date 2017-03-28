#!/usr/bin/env bash

set -o nounset
set -o errexit

# IMPORT
source "test/conf.inc.sh"
source "test/exec/resource/conf.inc.sh"
source "test/exec/inc/template.inc.sh"
source "test/exec/inc/docker.inc.sh"
source "test/exec/inc/test.setup.inc.sh"

# CONTEXT
export ANSIBLE_HOST_KEY_CHECKING=false
cd "${TEST__CONF_DIR}"

# CREATE DOCKER CONTAINER
docker_build
dockerInfo=$(docker_run)
docker_print_container "${dockerInfo}"
sleep "${TEST__CONF_TIMEOUT_TEST}"

# RUN TEST SETUP
setup_hosts=$(template_setup_connection "${dockerInfo}")
run_setup_test "${setup_hosts}"

# CLEAN UP TEST
rm ${setup_hosts}
docker_clean
