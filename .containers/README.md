# Containers Specs and Inventory

## Dev

For the `dev` environment docker image, we have the following specs :
* the `hugo` project source code root folder must be bound inside the container
* the user inisde the container :
  * must have `GID` and `UID` that can be configured at build time. `UID` and `GID` of user inside and ouside container must be equal to allow `rw`
  * will be named `pokus`, but the user name can be configured at build time



```bash
export WHOAMI_WEB_DESIRED_VERSION="0.0.1"
export WHOAMI_WEB_DESIRED_VERSION="feature/framework"
# git rev-parse --short=40 HEAD
export WHOAMI_WEB_DESIRED_VERSION="4c9709d80c177efc729d5a10123f5fd91113a57b"

export WHERE_I_AM=$(pwd)
export WHERE_I_WORK=$(mktemp -d -t "POKUS_HUGO_XXXXXX")

git clone git@github.com:Jean-Baptiste-Lasselle/whoami-web.git ${WHERE_I_WORK}

cd ${WHERE_I_WORK}
git checkout ${WHOAMI_WEB_DESIRED_VERSION}

cd ./.containers/dev/

# ---
# YOU MUST BUILD ONCE THE IMAGE TO ADAPT TO YOUR LINUX USER UID / GID
./.build.dev.sh

# ---
# Then you can run an teardown the stack as many times as you wish
./.run.dev.sh
# ./.teardown.dev.sh













export WHERE_I_AM=$(pwd)
export WHERE_I_WORK=$(mktemp -d -t "POKUS_HUGO_XXXXXX")

echo "WHERE_I_WORK=[${WHERE_I_WORK}]"
ls -alh ${WHERE_I_WORK}


```

## About docker volumes

### Mapping a non empty folder from host into a docker container

* https://docs.docker.com/storage/bind-mounts/#mount-into-a-non-empty-directory-on-the-container


## SecOps


```bash
Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```
