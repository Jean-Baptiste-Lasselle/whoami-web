---
title: "Cloud Init - episode 1"
# date -u +'%Y-%m-%dT%H:%M:%S%:z'
# date: 2022-06-09T08:53:58+05:30
date: 2022-06-17T20:53:11+00:00
draft: false
github_link: "https://github.com/pokusio/cloud-init-first.git"
author: "Jean-B. Lasselle"
tags:
  - TypeScript
  - npx
  - hugo
  - tsconfig.json
image: /images/posts/cloud-init/cloud_init_logo.png
description: ""
toc:
---

```bash
cd ~/whoami-web/static/images/posts/cloud-init
# /images/posts/cloud-init/cloud_init_logo.png
curl -L https://cloudinit.readthedocs.io/en/latest/_static/logo.png -o ./cloud_init_logo.png
```
This article is a first step playing **_the_ `cloud-init`**

In this article we will :
* Install and configure **`cloud-init`**
* Create our first images using **`cloud-init`** on `GNU/Linux Debian - Bullseye`

<!-- more -->

<!--
{{< sketchfigure
    unique_name="ts_project_envs"
    src="/images/posts/typescript/episode1/definitive-typescript-configuration.drawio.png"
    link="/images/posts/typescript/episode1/achille-ecmascript.drawio.png"
    target="_blank"
    caption="TypeScript Project and target JavaScript Runtimes"
    alt_msg="architecture diagram - TypeScript Project and target JavaScript Runtimes" >}}


{{< sketchfigure
  unique_name="js_runtime"
  src="/images/posts/typescript/episode1/achille-ecmascript.drawio.png"
  link="/images/posts/typescript/episode1/achille-ecmascript.drawio.png"
  target="_blank"
  caption="Architecture of A JavaScript Runtime"
  alt_msg="architecture diagram - ecmascript runtime" >}}
-->



<!--

{{< sketchdraw path="/images/posts/typescript/episode1/definitive-typescript-configuration.drawio.png" alt_msg="architecture diagram - typescript environments" >}}


{{< sketchdraw path="/images/posts/typescript/episode1/definitive-typescript-configuration.drawio.png" alt_msg="architecture diagram - typescript environments" >}}


-->


## Install `cloud-init`

```
export DESIRED_VERSION=master
git clone git@github.com:pokusio/cloud-init-first.git
cd ./cloud-init-first
# git flow AVH Edition [git flow version]=[1.12.3 (AVH Edition)]
git flow init --defaults
git checkout ${DESIRED_VERSION}
sudo apt-get remove -y --purge cloud-init
sudo apt-get install -y cloud-init

cd /etc/cloud
ls -alh
ls -alh cloud.cfg.d/

sudo cp cloud.cfg cloud.cfg.bak




# ---
# Config :
# remove all that is about tools  
# --
# Configure Default User
#
# on debian default system user is named debian
# on ubuntu default system user is named ubuntu
#
#
# ---
# We edit the [/etc/cloud/cloud.cfg] configuration file
# ---
ls -alh /etc/cloud/cloud.cfg
ls -alh /etc/cloud/cloud.cfg

sudo apt-get install -y whois

export DEFAULT_SYS_USER_LX_PWD=pokus

# echo -e "${DEFAULT_SYS_USER_LX_PWD}" | sudo mkpasswd --password-fd=0 -m SHA-512


# ---
# The output of the mkpasswd command is actually both a salt (random) and
# the hash of the password+salt. Since the salt is random, the output
# will always be different, on every execution of [mkpasswd].
#
export GENERATED_HASHED_PASSWD=$(sudo mkpasswd --password-fd=0 -m SHA-512 "${DEFAULT_SYS_USER_LX_PWD}")

echo "# --"
echo "# Configure Default User"
echo "# >> - >> - >> GENERATED_HASHED_PASSWD=[${GENERATED_HASHED_PASSWD}]"

```

## Configure `cloud-init`

```
export DESIRED_VERSION=master
git clone git@github.com:pokusio/cloud-init-first.git
cd ./cloud-init-first
# git flow AVH Edition [git flow version]=[1.12.3 (AVH Edition)]
git flow init --defaults
git checkout ${DESIRED_VERSION}
sudo apt-get remove -y --purge cloud-init
sudo apt-get install -y cloud-init tree

ls -alh /etc/cloud/cloud.cfg
ls -alh /etc/cloud/cloud.cfg.d/


#   #    #    #    #    #    #    #    #    #    #
#   #    #    #    #    #    #    #    #    #    #
#   #    Folder / Files Tree structure
#   #    #    #    #    #    #    #    #    #    #
#   #    #    #    #    #    #    #    #    #    #
#   
#   /etc/cloud/
#   ├── [2.6K]  cloud.cfg
#   ├── [4.0K]  cloud.cfg.d
#   │   ├── [  93]  00_debian.cfg
#   │   ├── [2.0K]  05_logging.cfg
#   │   └── [ 167]  README
#   └── [4.0K]  templates
#       ├── [1.6K]  chef_client.rb.tmpl
#       ├── [1.1K]  chrony.conf.alpine.tmpl
#       ├── [1.1K]  chrony.conf.debian.tmpl
#       ├── [1.2K]  chrony.conf.fedora.tmpl
#       ├── [ 991]  chrony.conf.opensuse.tmpl
#       ├── [1.2K]  chrony.conf.rhel.tmpl
#       ├── [ 991]  chrony.conf.sles.tmpl
#       ├── [1.2K]  chrony.conf.ubuntu.tmpl
#       ├── [ 985]  hosts.alpine.tmpl
#       ├── [ 901]  hosts.debian.tmpl
#       ├── [ 911]  hosts.freebsd.tmpl
#       ├── [ 912]  hosts.redhat.tmpl
#       ├── [1.0K]  hosts.suse.tmpl
#       ├── [ 203]  ntp.conf.alpine.tmpl
#       ├── [2.1K]  ntp.conf.debian.tmpl
#       ├── [2.0K]  ntp.conf.fedora.tmpl
#       ├── [2.7K]  ntp.conf.opensuse.tmpl
#       ├── [1.8K]  ntp.conf.rhel.tmpl
#       ├── [2.7K]  ntp.conf.sles.tmpl
#       ├── [2.5K]  ntp.conf.ubuntu.tmpl
#       ├── [ 922]  resolv.conf.tmpl
#       ├── [1.3K]  sources.list.debian.tmpl
#       ├── [2.8K]  sources.list.ubuntu.tmpl
#       └── [ 203]  timesyncd.conf.tmpl
#   
#   2 directories, 28 files
#   


cd /etc/cloud
ls -alh
ls -alh cloud.cfg.d/

# backup default config
sudo cp cloud.cfg cloud.cfg.bak




# ---
# Config :
# remove all that is about tools  
# --
# Configure Default User
#
# on debian default system user is named debian
# on ubuntu default system user is named ubuntu
#
#
# ---
# We edit the [/etc/cloud/cloud.cfg] configuration file
# ---
ls -alh /etc/cloud/cloud.cfg
ls -alh /etc/cloud/cloud.cfg

sudo apt-get install -y whois

export DEFAULT_SYS_USER_LX_PWD=pokus

# echo -e "${DEFAULT_SYS_USER_LX_PWD}" | sudo mkpasswd --password-fd=0 -m SHA-512


# ---
# The output of the mkpasswd command is actually both a salt (random) and
# the hash of the password+salt. Since the salt is random, the output
# will always be different, on every execution of [mkpasswd].
#
export GENERATED_HASHED_PASSWD=$(sudo mkpasswd --password-fd=0 -m SHA-512 "${DEFAULT_SYS_USER_LX_PWD}")

echo "# --"
echo "# Configure Default User"
echo "# >> - >> - >> GENERATED_HASHED_PASSWD=[${GENERATED_HASHED_PASSWD}]"

```


## References


* a video tuorial I fully experimented : https://www.youtube.com/watch?v=exeuvgPxd-E
