#!/bin/bash

export POKUS_USER_NAME=pokus
export POKUS_USER_GRPNAME=pokusio
export POKUS_USER_UID=$(id -u)
export POKUS_USER_GID=$(id -g)
# for image "golang:1.18.3-alpine3.16" see https://hub.docker.com/_/golang
export ALPINE_OCI_IMAGE_TAG=${ALPINE_OCI_IMAGE_TAG:-"3.16"}
export GOLANG_VERSION=${GOLANG_VERSION:-"1.18.3"}
export HUGO_VERSION=${HUGO_VERSION:-"0.100.2"}
export GIT_COMMIT_ID=$(git rev-parse --short=40 HEAD)
export CICD_BUILD_ID=${CICD_BUILD_ID:-"${GIT_COMMIT_ID}"}
export CICD_BUILD_TIMESTAMP=$(date --utc '+%FT%T%Z')
# will be pokusio/jb-lasselle-whoami-web
export QUAY_OCI_IMAGE_TAG=${QUAY_OCI_IMAGE_TAG:-"0.0.1"}
