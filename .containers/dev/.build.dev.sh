#!/bin/bash


# first load all env vars

source ./.env.sh



# second interpolete all env vars in ./.dev.env
chmod +x ./.interpolate.dev.env.sh
./.interpolate.dev.env.sh

source ./.dev.env

# run the build from docker-copmpose yaml [.containers/dev/docker-compose.build.yml]
docker-compose -f ./docker-compose.build.yml build pokus_dev
