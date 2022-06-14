# +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# ---               HUGO BASE CONTAINER IMAGE             --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ #

ARG ALPINE_OCI_IMAGE_TAG=${ALPINE_OCI_IMAGE_TAG}
ARG GOLANG_VERSION=${GOLANG_VERSION:-1.15.6}
FROM golang:$GOLANG_VERSION-alpine$ALPINE_OCI_IMAGE_TAG AS hugo_build_base

ARG ALPINE_OCI_IMAGE_TAG=${ALPINE_OCI_IMAGE_TAG:-'latest'}

ARG GOLANG_VERSION=${GOLANG_VERSION}
ARG HUGO_VERSION=${HUGO_VERSION}
ARG HUGO_BASE_URL=https://pokus-io.github.io/conference/

RUN echo "GOLANG_VERSION=[${GOLANG_VERSION}] and HUGO_VERSION=[${HUGO_VERSION}] and HUGO_BASE_URL=[${HUGO_BASE_URL}]"
USER root
# [build-base] because the hugo installation requires gcc and [build-base] package contains the proper gcc
RUN apk update && apk add curl git tree tar bash build-base
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# ---              CHECKING GOLANG VERSION                --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #

RUN export PATH=$PATH:/usr/local/go/bin && go version

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# ---                   INSTALLING HUGO                   --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #

COPY alpine.hugo-extended.setup.sh .
RUN chmod +x ./alpine.hugo-extended.setup.sh && ./alpine.hugo-extended.setup.sh
RUN echo "Is Hugo properly installed ?"
RUN export PATH=$PATH:/usr/local/go/bin && hugo version && hugo env

# +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# ---               CREATE CONTAINER USER            --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ #

ARG POKUS_USER_NAME=pokus
ENV POKUS_USER_NAME=$POKUS_USER_NAME

# group name defaults to user name
ARG POKUS_USER_GRPNAME=$POKUS_USER_NAME
ENV POKUS_USER_GRPNAME=$POKUS_USER_GRPNAME


ARG POKUS_USER_UID=1000
ENV POKUS_USER_UID=$POKUS_USER_UID

ARG POKUS_USER_GID=1000
ENV POKUS_USER_GID=$POKUS_USER_GID


FROM hugo_build_base AS hugo_build
# FROM alpine:${ALPINE_OCI_IMAGE_TAG} AS hugo_build

ARG GIT_COMMIT_ID=${GIT_COMMIT_ID}
ARG CICD_BUILD_ID=${CICD_BUILD_ID}
# export CICD_BUILD_TIMESTAMP=$(date --rfc-3339 seconds)
ARG CICD_BUILD_TIMESTAMP=${CICD_BUILD_TIMESTAMP}

ARG QUAY_OCI_IMAGE_TAG=${QUAY_OCI_IMAGE_TAG}

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# ---                  HUGO BUILD                         --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# What informations do i want in the label metadata ?
#    build-date
#    name
#    description
#    url
#    vcs-ref
#    docker.cmd
#
# ---
# https://medium.com/@chamilad/lets-make-your-docker-image-better-than-90-of-existing-ones-8b1e5de950d
#
# ---
#

LABEL io.pokus.oci.image.gun="pokusio/jb-lasselle-whoami-web:${QUAY_OCI_IMAGE_TAG}-dev"
LABEL io.pokus.oci.base.image="golang:${GOLANG_VERSION}-alpine${ALPINE_OCI_IMAGE_TAG}"
LABEL io.pokus.golang.version="${GOLANG_VERSION}"
LABEL io.pokus.hugo.version="${HUGO_VERSION}"
LABEL io.pokus.git.commit.id="${GIT_COMMIT_ID}"
LABEL io.pokus.cicd.build.id="${CICD_BUILD_ID}"
LABEL io.pokus.cicd.build.timestamp="${CICD_BUILD_TIMESTAMP}"
LABEL io.pokus.website="https://jean-baptiste-lasselle.github.io/whoami-web"
# LABEL io.pokus.scm.type="gitlab.com"
# LABEL io.pokus.scm.type="gitea.com"
LABEL io.pokus.scm.type="github.com"
LABEL io.pokus.scm.repo="https://github.com/Jean-Baptiste-Lasselle/whoami-web"
LABEL io.pokus.github.org="https://github.com/Jean-Baptiste-Lasselle"
LABEL io.pokus.author="Jean-Baptiste Lasselle <jean.baptiste.lasselle.pokus@gmail.com>"
LABEL io.pokus.maintainer="Jean-Baptiste Lasselle <jean.baptiste.lasselle.pokus@gmail.com>"

RUN mkdir -p /pokus.io/hugo/src/
# COPY . /pokus.io/hugo/src/
# COPY .git /pokus.io/hugo/src/
RUN ls -allh /pokus.io/hugo/src/

COPY . /pokus.io/hugo/src/
RUN export PATH=$PATH:/usr/local/go/bin && cd /pokus.io/hugo/src/ && hugo -b "${HUGO_BASE_URL}"


FROM hugo_build AS hugo_release

ARG HUGO_BASE_URL=https://pokus-io.github.io/conference/
ENV HUGO_BASE_URL=${HUGO_BASE_URL}
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# ---                  HUGO SERVER RUNTIME                --- #
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
# Of course you would not ever distribute the hugo dev server in
# production, this is just an example... (And I do what I want to
# do, with my production env., because it mine: the pint is how do
#  you choose that)
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #
COPY serve.sh /pokus.io/hugo/
EXPOSE 1313
WORKDIR /pokus.io/hugo/src/
# RUN echo 'export PATH=$PATH:/usr/local/go/bin' > /pokus.io/entrypoint.sh
# RUN chmod +x /pokus.io/entrypoint.sh
# ENTRYPOINT [ "/pokus.io/entrypoint.sh" ]
CMD ["/pokus.io/hugo/serve.sh"]
