#!/usr/bin/env bash

set -o nounset
set -o errexit

TEST__DEBME_ENVS_SETUP='../test/exec/resource/exec-hosts-setup.json'
TEST__CONF_DOCKER_IMAGE_PATH='../test/exec/resource/'
TEST__CONF_DOCKER_IMAGE='debme_exec_test'
TEST__CONF_DOCKER_CONTAINER_NAME='debme_exec_test_ctn'
TEST__CONF_DOCKER_SSH_IP='0.0.0.0'
TEST__CONF_DOCKER_SSH_PORT=32986
TEST__CONF_TIMEOUT_TEST="5"
TEST__CONF_SETUP_SSH_USER="root"
TEST__CONF_SETUP_SSH_PASSWORD="screencast"
TEST__CONF_SETUP_TMP="/tmp/debme-exec-test"
