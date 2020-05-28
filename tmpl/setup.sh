#!/bin/bash
set -eu
RUN_ON_WEB_CMD="docker-compose exec web"
#RUN_ON_WEB_CMD="docker-compose run --rm web"
function docker_run {
  cmd=$1
  echo $cmd
  $RUN_ON_WEB_CMD $cmd
}
docker-compose up -d
docker_run "bundle install "
docker_run "yarn install --check-files"
docker_run "yarn upgrade"
docker_run "rails webpacker:install"
docker_run "rails db:setup"
