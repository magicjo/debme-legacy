#!/usr/bin/env bash

set -o nounset
set -o errexit

function _docker_build(){
  local oldPwd=$(pwd)
  cd "${TEST__CONF_DOCKER_IMAGE_PATH}"
  docker build --tag "${TEST__CONF_DOCKER_IMAGE}" .
  cd "${oldPwd}"
}

function _docker_run(){
  local dockerContainer=$(docker run --detach -p "${TEST__CONF_DOCKER_SSH_PORT}":22 --name \
      "${TEST__CONF_DOCKER_CONTAINER_NAME}" "${TEST__CONF_DOCKER_IMAGE}")
  echo "${dockerContainer}"
}

function docker_start(){
    _docker_build
    _docker_run
}

function docker_end(){
  docker stop "${TEST__CONF_DOCKER_CONTAINER_NAME}"
  docker rm "${TEST__CONF_DOCKER_CONTAINER_NAME}"
  docker rmi "${TEST__CONF_DOCKER_IMAGE}"
}

function docker_set_env(){
    TEST__CONF_SSH_IP=${TEST__CONF_DOCKER_SSH_IP}
    TEST__CONF_SSH_PORT=${TEST__CONF_DOCKER_SSH_PORT}
}
