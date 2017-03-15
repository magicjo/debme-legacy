###
### Makefile for debme
### /!\ You must be root to execute this script
###
### USAGE:
###
### // Install debme as an application
### make install
###
### // Uninstall the application debme
### make uninstall
###
### // Install the debme dependencies
### make install-dependencies
###

## BINARY APP CONF
PIP_BIN=pip install
EASY_INSTALL_BIN=easy_install
APT_GET_BIN=apt-get install --yes
MKDIR_BIN=mkdir --parents
RMDIR_BIN=rm --recursive --force
RM_BIN=rm --force
CP_BIN=cp --recursive
LN_BIN=ln --symbolic --force
UNLINK_BIN=unlink

## FILES CONF
BIN_PRIVATE_NAME=debme.sh
BIN_PUBLIC_NAME=debme
INSTALL_DIR=/opt/debme
BIN_DIR=/usr/local/bin
SRC_DIR=src/*

## Install
.PHONY: install
install: uninstall install-dependencies
	${MKDIR_BIN} ${INSTALL_DIR}
	${CP_BIN} ${SRC_DIR} ${INSTALL_DIR}
	${MKDIR_BIN} ${BIN_DIR}
	${LN_BIN} ${INSTALL_DIR}/${BIN_PRIVATE_NAME} ${BIN_DIR}/${BIN_PUBLIC_NAME}

## Uninstall
.PHONY: uninstall
uninstall:
	${RM_BIN} ${BIN_DIR}/${BIN_PUBLIC_NAME}
	${RMDIR_BIN} ${INSTALL_DIR}

## Install dependencies
PHONY: install-dependencies
install-dependencies:
	${APT_GET_BIN} build-essential
	${APT_GET_BIN} python-setuptools python-dev libssl-dev
	${EASY_INSTALL_BIN} pip
	${PIP_BIN} ansible
