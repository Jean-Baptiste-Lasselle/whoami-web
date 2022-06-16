#!/bin/bash


# first load all env vars

# should never be executed because [./.build.env.sh] generates the [./.env.dev] file, by executing [./.interpolate.dev.env.sh]
source ./.env.sh
if [ -f ./.dev.env ]; then
  echo "# --- --- --- --- --- --- --- --- #"
  echo "[./.dev.env] file does not exist"
  echo "# --- --- --- --- --- --- --- --- #"
  # second interpolete all env vars in ./.dev.env
  chmod +x ./.interpolate.dev.env.sh
  ./.interpolate.dev.env.sh
fi;

source ./.dev.env

# run the build from docker-copmpose yaml [.containers/dev/docker-compose.build.yml]
docker-compose -f ./docker-compose.yml up -d pokus_dev
