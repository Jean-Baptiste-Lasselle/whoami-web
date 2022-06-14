# Containers Specs and Inventory

## Dev

For the `dev` environment docker image, we ahve the following specs :
* the `hugo` project source code root folder must be bound inside the container
* the user inisde the container :
  * must have `GID` and `UID` that can be configured at build time. `UID` and `GID` of user inside and ouside container must be equal to allow `rw`
  * will be named `pokus`, but the user name can be configured at build time

```bash

```

## About docker volumes

### Mapping a non empty folder from host into a docker container

* https://docs.docker.com/storage/bind-mounts/#mount-into-a-non-empty-directory-on-the-container
