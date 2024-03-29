---
title: "Cloud Init - episode 1"
# date -u +'%Y-%m-%dT%H:%M:%S%:z'
# date: 2022-06-09T08:53:58+05:30
date: 2022-06-17T20:53:11+00:00
draft: true
github_link: "https://github.com/pokusio/cloud-init-first"
get_the_code: "https://github.com/pokusio/cloud-init-first"
get_the_code_youtube: "https://www.youtube.com/watch?v=exeuvgPxd-E"
author: "Jean-B. Lasselle"
tags:
  - cloud-init
  - packer
  - terraform
  - virtualbox
  - qemu-kvm
  - hashicorp
  - pxeless
image: /images/posts/cloud-init/cloud_init_logo.png
description: ""
toc:
---

## Get the Code!

{{< get_the_code get_the_code="https://github.com/pokusio/cloud-init-first" get_the_code_youtube="https://www.youtube.com/watch?v=n6RoVyZEsv4" >}}

## What you will find here

In this new article, we will use:
* Cloud Init
* HashiCorp Packer
* Terraform
* `Bitnami's Kubeseal` secret manager

To automate virtual machines creation from templates.



## `Packer` / `VirtualBox`

Our goal here is to provision a VirtualBox VM with :
* Debian Bullseye
* `git` , `git-flow`, `Docker`, `Docker Compose`, a few other utility linux packages
* two net interfaces, one used to connect :
  * to internet through USB Key Wifi Network Adpater network cidr `192.168.195.0/24`
  * to another network isolated from the Internet, network cidr `192.168.1.0/24`

<!--
* this machine can become a router and a firewall to connect the two networks, and :
  * `192.168.195.0/24` acts as a its like a DMZ for `192.168.1.0/24`
  * ...
-->

### Install `Chocolatey` (Windows only)

See :

* https://chocolatey.org/install


---


* Open A PowerShell as administrator, and run :

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
* wait  a few seconds that execution has completed, If you don't see any errors, you are ready to use Chocolatey! Type `choco` or `choco -?` now, or see Getting Started for usage instructions.
* From now now, to upgrade `Chocolatey`, you will execute :

```PowerShell
choco upgrade chocolatey
```



### Install Packer

{{< os_support_tabs role="user" symbol="$" >}}

+++
PowerShell
xxx
```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

packer --version
```


+++
Linux Shell Bash
xxx
```Bash
#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y packer

packer --version

```

{{< / os_support_tabs >}}



```PowerShell
choco install packer
```


```bash

# 1. Add HashiCorp GPG Key

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# 2. Add HashiCorp Linux repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# 3. Update
sudo apt-get update -y

# 4. Install Packer
sudo apt-get install -y packer

# --------------------
# # I got :
# ~$ packer --version
# 1.8.1
#


```


<!--
This article is a first step playing **_the_ `cloud-init`**

In this article we will :
* Install and configure **`cloud-init`**
* Create our first images using **`cloud-init`** on `GNU/Linux Debian - Bullseye`
-->

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


<!--

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
# remove all that is about tools that you don't use
# ---
#   Configuration BOM :
#    - The 'default_user' must be configured with :


# default_user:
#   name: pokus
#   lock_passwd: False
#   passwd:  $6$w0EKvYCt6WCC089b$rTO42dWCX6VIJhcAh5azQlgUll9TgKzs0BCA9upjRHpR70cZ07Cc52lzvHORZsApqGajH3YqKVQluyhmMwNy30
#   # cat ~/.ssh/id_rsa.pub
#   ssh_authorized_keys:
#     - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAC etc...== pokus@pokusio.k3d
#   gecos: Pokus
#   groups: [adm, audio, cdrom, dialout, dip, floppy, netdev, plugdev, sudo, video]
#   sudo: ["ALL=(ALL) NOPASSWD:ALL"]
#   shell: /bin/bash



#    - 'passwd' value must be set generated with 'mkpasswd' from 'whois' debian package
#    - ''
# ---
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


To generate your configuration file :

* generate all secrets ( `sudo mkpasswd -m SHA-512 pokus` `ssh-keygen -t rsa -b 2048 ...`)

* secure secrets in secret manager in `Bitnami's Kubeseal`
```bash

mkdir -p ~/.ssh.io.pokus.kube/.cluster_node1/

ssh-keygen -t rsa -b 2048 -P '' -C 'pokus@pokusio.kube.node-1' -N '' -f ~/.ssh.io.pokus.kube/.cluster_node1/id_rsa


chmod 700 -R ~/.ssh.io.pokus.kube/.cluster_node1/
chmod 644 -R ~/.ssh.io.pokus.kube/.cluster_node1/id_rsa.pub
chmod 600 -R ~/.ssh.io.pokus.kube/.cluster_node1/id_rsa

export DEFAULT_USER_NAME="pokus"
export DEFAULT_USER_CLEAR_PWD="pokus"
export DEFAULT_USER_PWD_HASH="pokus"

export DEFAULT_USER_PUBLIC_SSH_KEY=$(cat ~/.ssh.io.pokus.kube/.cluster_node1/id_rsa.pub)
echo "   >>>>> DEFAULT_USER_PUBLIC_SSH_KEY = [${DEFAULT_USER_PUBLIC_SSH_KEY}]"

# --- NExt steps at 15minutes in the video

# curl -LO http://jean-baptiste-lasselle.github.io/whoami-web/blog/code/cloud-init/.etc.cloud.cloud.cfg.reference
curl -LO http://127.0.0.1:1313/blog/code/cloud-init/.etc.cloud.cloud.cfg.reference
cp ./.etc.cloud.cloud.cfg.reference ./.etc.cloud.cloud.applied.cfg

# -- changing timezone
sed -i "s# - timezone .*# - timezone \"Europe/Paris\"#" ./.etc.cloud.cloud.applied.cfg
# -- set ssh_authorized_keys
sed -i "s# - ssh-.*# - ${DEFAULT_USER_PUBLIC_SSH_KEY}#" ./.etc.cloud.cloud.applied.cfg
# -- remove uncessary config like those related to puppet
# edit interactive with vi ?
# -- set hostname
export POKUS_K8S_NODE1_HOSTNAME=node1.pokkus.io
sed -i "s#^hostname:.*#hostname: ${POKUS_K8S_NODE1_HOSTNAME}#" ./.etc.cloud.cloud.applied.cfg










curl -LO http://127.0.0.1:1313/blog/code/cloud-init/.cloud.cfg.d.99-fake_cloud.cfg.reference
cp ./.cloud.cfg.d.99-fake_cloud.cfg.reference ./.cloud.cfg.d.99-fake_cloud.applied.cfg

# sed -i "s###g" ./.cloud.cfg.d.99-fake_cloud.applied.cfg
#
# >>> no interpolation to perform

if [ -f /etc/cloud/cloud.cfg.d/99-fake_cloud.cfg ]; then
  sudo rm /etc/cloud/cloud.cfg.d/99-fake_cloud.cfg
fi;
sudo touch /etc/cloud/cloud.cfg.d/99-fake_cloud.cfg
cat ./.cloud.cfg.d.99-fake_cloud.applied.cfg | sudo tee -a /etc/cloud/cloud.cfg.d/99-fake_cloud.cfg

# ---
# Apparently, we also have to delete a
# System Symbolic Link in the networking part...
if [ -f /etc/systemd/network/99-default.link ];then
  sudo rm /etc/systemd/network/99-default.link
  # if it exists it is symbolic link to /dev/null
  # if it exists it prevents cloud-init from running
fi;


# I don't know why, but the author of video says
# it's good to execute that 'clean' command, so let's do it...
cloud-init clean

```

-->

## References


* a video tuorial I fully experimented : https://www.youtube.com/watch?v=exeuvgPxd-E
