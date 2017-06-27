#!/usr/bin/env bash

set -o nounset
set -o errexit

# IMPORT
source "test/conf.inc.sh"
source "test/exec/resource/conf.inc.sh"
source "test/exec/inc/template.inc.sh"
source "test/exec/inc/docker.inc.sh"
source "test/exec/inc/test.setup.inc.sh"

# ARGS
HAVE_START=false
HAVE_TEST=false
HAVE_END=false
if [[ $# -eq 0 ]]
then
    HAVE_START=true
    HAVE_TEST=true
    HAVE_END=true
fi
while [[ $# -gt 0 ]]
do
    case "$1" in
        -s|--start)
            HAVE_START=true
            shift
        ;;
        -t|--test)
            HAVE_TEST=true
            shift
        ;;
            -e|--end)
            HAVE_END=true
            shift
        ;;
        *)
            # unknown option
            shift
        ;;
    esac
done

# CONTEXT
export ANSIBLE_HOST_KEY_CHECKING=false
cd "${TEST__CONF_DIR}"

# CREATE DOCKER CONTAINER
if [[ "${HAVE_START}" = "true" ]]
then
    docker_build
    docker_run
fi


# RUN TEST SETUP
if [[ "${HAVE_TEST}" = "true" ]]
then
    docker_print_container
    sleep "${TEST__CONF_TIMEOUT_TEST}"
    setup_hosts=$(template_setup_connection)
    echo "setup_host_file: ${setup_hosts}"
    run_setup_test "${setup_hosts}"
fi

# CLEAN UP TEST
if [[ "${HAVE_END}" = "true" ]]
then
    docker_clean
    rm -Rf "${TEST__CONF_SETUP_TMP}"*
fi
