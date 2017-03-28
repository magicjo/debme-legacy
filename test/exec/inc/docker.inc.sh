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
  local dockerContainer=$(docker run --detach --publish-all --name \
      "${TEST__CONF_DOCKER_CONTAINER_NAME}" "${TEST__CONF_DOCKER_IMAGE}")
  local dockerAddress=$(docker port "${TEST__CONF_DOCKER_CONTAINER_NAME}" 22)
  echo "${dockerContainer}:${dockerAddress}"
}

function docker_clean(){
  docker stop "${TEST__CONF_DOCKER_CONTAINER_NAME}"
  docker rm "${TEST__CONF_DOCKER_CONTAINER_NAME}"
  docker rmi "${TEST__CONF_DOCKER_IMAGE}"
}

function docker_print_container(){
  local dockerInfo="${1}"
  local dockerContainer=$(echo "${dockerInfo}" | cut --delimiter=":" --field="1")
  local dockerIp=$(echo "${dockerInfo}" | cut --delimiter=":" --field="2")
  local dockerPort=$(echo "${dockerInfo}" | cut --delimiter=":" --field="3")
  cat <<-EOF
================================
container: ${dockerContainer}
ip: ${dockerIp}
port: ${dockerPort}
================================
EOF
}
