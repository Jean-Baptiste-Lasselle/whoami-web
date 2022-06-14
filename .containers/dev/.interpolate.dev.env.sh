#!/bin/bash


# first load all env vars

source ./.env.sh

# second interpolete all env vars in ./.dev.env
cp ./.env.template ./.dev.env

# sed -i "s#CCCCC_PLACEHOLDER#${CCCCCC_PLACEHOLDER}#g" ./.dev.env

# POKUS_USER_NAME=POKUS_USER_NAME_PLACEHOLDER
sed -i "s#POKUS_USER_NAME_PLACEHOLDER#${POKUS_USER_NAME}#g" ./.dev.env
# POKUS_USER_GRPNAME=POKUS_USER_GRPNAME_PLACEHOLDER
sed -i "s#POKUS_USER_GRPNAME_PLACEHOLDER#${POKUS_USER_GRPNAME}#g" ./.dev.env
# POKUS_USER_UID=POKUS_USER_UID_PLACEHOLDER
sed -i "s#POKUS_USER_UID_PLACEHOLDER#${POKUS_USER_UID}#g" ./.dev.env
# POKUS_USER_GID=POKUS_USER_GID_PLACEHOLDER
sed -i "s#POKUS_USER_GID_PLACEHOLDER#${POKUS_USER_GID}#g" ./.dev.env
# ALPINE_OCI_IMAGE_TAG=ALPINE_OCI_IMAGE_TAG_PLACEHOLDER
sed -i "s#ALPINE_OCI_IMAGE_TAG_PLACEHOLDER#${ALPINE_OCI_IMAGE_TAG}#g" ./.dev.env
# GOLANG_VERSION=GOLANG_VERSION_PLACEHOLDER
sed -i "s#GOLANG_VERSION_PLACEHOLDER#${GOLANG_VERSION}#g" ./.dev.env
# HUGO_VERSION=HUGO_VERSION_PLACEHOLDER
sed -i "s#HUGO_VERSION_PLACEHOLDER#${HUGO_VERSION}#g" ./.dev.env
# GIT_COMMIT_ID=GIT_COMMIT_ID_PLACEHOLDER
sed -i "s#GIT_COMMIT_ID_PLACEHOLDER#${GIT_COMMIT_ID}#g" ./.dev.env
# CICD_BUILD_ID=CICD_BUILD_ID_PLACEHOLDER
sed -i "s#CICD_BUILD_ID_PLACEHOLDER#${CICD_BUILD_ID}#g" ./.dev.env
# CICD_BUILD_TIMESTAMP=CICD_BUILD_TIMESTAMP_PLACEHOLDER
sed -i "s#CICD_BUILD_TIMESTAMP_PLACEHOLDER#${CICD_BUILD_TIMESTAMP}#g" ./.dev.env
# QUAY_OCI_IMAGE_TAG=QUAY_OCI_IMAGE_TAG_PLACEHOLDER
sed -i "s#QUAY_OCI_IMAGE_TAG_PLACEHOLDER#${QUAY_OCI_IMAGE_TAG}#g" ./.dev.env
