#!/usr/bin/env bash

set -o nounset
set -o errexit

TEST__CONF_DOCKER_IMAGE_PATH='../test/exec/resource/'
TEST__CONF_DOCKER_IMAGE='debme_exec_test'
TEST__CONF_DOCKER_CONTAINER_NAME='debme_exec_test_ctn'
TEST__CONF_DOCKER_SSH_IP='0.0.0.0'
TEST__CONF_DOCKER_SSH_PORT=32986

TEST__CONF_SSH_IP='0.0.0.0'
TEST__CONF_SSH_PORT=22
TEST__CONF_TIMEOUT_TEST=5

TEST__DEBME_ENVS_SETUP='../test/exec/resource/exec-hosts-setup.json'
TEST__CONF_SETUP_SSH_USER='root'
TEST__CONF_SETUP_SSH_PASSWORD='screencast'
TEST__CONF_SETUP_TMP='/tmp/debme-exec-test-setup'

TEST__DEBME_ENVS_TASKS='../test/exec/resource/exec-hosts-tasks.json'
TEST__CONF_TASKS_SSH_USER='user'
TEST__CONF_TASKS_SSH_PASSWORD='password'
TEST__CONF_TASKS_TMP='/tmp/debme-exec-test-tasks'

TEST__CLI_CMD=''
TEST__CLI_ARGS_UI='no'
TEST__CLI_ARGS_VERBOSE=''
TEST__CLI_ARGS_SETUP=false
TEST__CLI_ARGS_TASKS=false
TEST__CLI_ARGS_TASKS_NAMES="system dev gnome"
TEST__CLI_ARGS_DOCKER_START=false
TEST__CLI_ARGS_DOCKER_END=false
TEST__CLI_ARGS_VM_IP='0.0.0.0'
