# My Resume

In this repository, you will find my resume as a static website.

## Locally run

```bash
export HUGO_SERVER_PORT=1314

hugo server -b http://localhost:${HUGO_SERVER_PORT}/whoami-web/ -p ${HUGO_SERVER_PORT}

# hugo server -D -b http://localhost:${HUGO_SERVER_PORT}/whoami-web/ -p ${HUGO_SERVER_PORT}

# Then go to http://localhost:1314/whoami-web/
```

## Release


```bash
export WHERE_I_WAS=$(pwd)
export WHERE_I_WORK=$(mktemp -d -t "POKUS_WHERE_I_WORK_XXXXXXXX")
git clone git@github.com:jean-baptiste-lasselle/whoami-web.git ${WHERE_I_WORK}
cd ${WHERE_I_WORK}
git checkout master
git flow init --defaults

# you  must be on develp : your feature branch must be suashed and merged

export RELEASE_VERSION="0.0.4"

git flow release start ${RELEASE_VERSION}

export DEPLOYMENT_HUGO_BASE_URL="https://jean-baptiste-lasselle.github.io/whoami-web/"
export NO_CNAME="true"
# export NO_CNAME="false"
# export CNAME_VALUE="example.com"
npm run build:prod:gh

git add -A && git commit -m "release [${RELEASE_VERSION}] - release and deployment" && git push -u origin HEAD

# git flow release finish ${RELEASE_VERSION} && git push -u origin --all  && git push -u origin --tags
git flow release finish -s ${RELEASE_VERSION} && git push -u origin --all  && git push -u origin --tags
```


<!--
## Spawn


```bash
# ---
# re-generate the hugo project
npm run spawn:project:clean
export HUGO_THEME_GIT_SSH="git@github.com:gurusabarish/hugo-profile.git"
export HUGO_THEME_GIT_SSH="git@github.com:gurusabarish/hugo-profile.git"
npm run spawn:project:gen

```
-->
