#!/bin/bash

export POKUS_USER_NAME=pokus
export POKUS_USER_GRP_NAME=pokusio
export POKUS_USER_UID=$(id -u)
export POKUS_USER_GID=$(id -g)
# for image "golang:1.18.3-alpine3.16" see https://hub.docker.com/_/golang
export ALPINE_OCI_IMAGE_TAG=${ALPINE_OCI_IMAGE_TAG:-"3.16"}
export GOLANG_VERSION=${GOLANG_VERSION:-"1.18.3"}
export HUGO_VERSION=${HUGO_VERSION:-"0.100.2"}
export GIT_COMMIT_ID=$(git rev-parse --short=40 HEAD)
export CICD_BUILD_ID=${CICD_BUILD_ID:-"${GIT_COMMIT_ID}"}
# export CICD_BUILD_TIMESTAMP=$(date --utc '+%FT%T%Z')
export CICD_BUILD_TIMESTAMP=$(date -u +'%Y-%m-%dT%H:%M:%S%Z')
# will be pokusio/jb-lasselle-whoami-web
export QUAY_OCI_IMAGE_TAG=${QUAY_OCI_IMAGE_TAG:-"0.0.1"}
# export HUGO_BASE_URL="https://jean-baptiste-lasselle.github.io/whoami/"
export HUGO_BASE_URL="http://127.0.0.1:3112"
export HUGO_SERVER_BIND_ADDR="0.0.0.0"
export HUGO_SERVER_PORT_NUMBER="1313"
