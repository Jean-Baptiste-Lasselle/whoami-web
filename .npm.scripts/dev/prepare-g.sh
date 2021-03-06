#!/bin/bash
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ -- [$0]"
echo "# ------ --  (All npm) global installations"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
ls -alh ./.npm.scripts/dev/env.sh
source ./.npm.scripts/dev/env.sh
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ -  PATH=[${PATH}]"
# ----
#
export SOME_ENV_VAR_YOU_WWANT=${SOME_ENV_VAR_YOU_WWANT:-"its default value if not set"}

echo "# --- # ---   SOME_ENV_VAR_YOU_WWANT=[${SOME_ENV_VAR_YOU_WWANT}]"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"

# ------ ------ ------ ------ ------ ------ ------ #
# ------ ------ ------ ------ ------ ------ ------ #
# ------ ------ ------ ------ ------ ------ ------ #
# ------ ------ ------ ------ ------ ------ ------ #
# ------ --  (All npm) global installations
# ------ ------ ------ ------ ------ ------ ------ #
# ------ ------ ------ ------ ------ ------ ------ #
# ------ ------ ------ ------ ------ ------ ------ #
# ------ ------ ------ ------ ------ ------ ------ #

export GULP_CLI_VERSION=${GULP_CLI_VERSION:-"2.3.0"}
export SASS_VERSION=${SASS_VERSION:-"latest"}
export SERVE_VERSION=${SERVE_VERSION:-"13.0.2"}
# surge --version on my machine gives : v0.23.0
export SURGE_VERSION=${SURGE_VERSION:-"0.23.0"}

# npm install -g sass@${SASS_VERSION}
sudo npm uninstall --global gulp-cli
sudo npm uninstall --global serve
sudo npm uninstall --global surge

sudo npm install --global gulp-cli@${GULP_CLI_VERSION}
sudo npm install --global serve@${SURGE_VERSION}
