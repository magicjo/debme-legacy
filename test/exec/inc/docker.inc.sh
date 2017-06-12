#!/usr/bin/env bash

set -o nounset
set -o errexit

function docker_build(){
  local oldPwd=$(pwd)
  cd "${TEST__CONF_DOCKER_IMAGE_PATH}"
  docker build --tag "${TEST__CONF_DOCKER_IMAGE}" .
  cd "${oldPwd}"
}

function docker_run() {
  local dockerContainer=$(docker run --detach -p "${TEST__CONF_DOCKER_SSH_PORT}":22 --name \
      "${TEST__CONF_DOCKER_CONTAINER_NAME}" "${TEST__CONF_DOCKER_IMAGE}")
  echo "${dockerContainer}"
}

function docker_clean(){
  docker stop "${TEST__CONF_DOCKER_CONTAINER_NAME}"
  docker rm "${TEST__CONF_DOCKER_CONTAINER_NAME}"
  docker rmi "${TEST__CONF_DOCKER_IMAGE}"
}

function docker_print_container(){
  cat <<-EOF
================================
container: ${TEST__CONF_DOCKER_CONTAINER_NAME}
ip: ${TEST__CONF_DOCKER_SSH_IP}
port: ${TEST__CONF_DOCKER_SSH_PORT}
================================
EOF
}
