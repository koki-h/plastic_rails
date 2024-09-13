#!/bin/bash
set -eu
ESC="\e["
ESCEND=m
COLOR_OFF=$(printf ${ESC}${ESCEND})
COLOR_CMD=$(printf "${ESC}36;1;${ESCEND}") # front: cyan;bold 
RUN_ON_WEB_CMD="docker compose exec web"
#RUN_ON_WEB_CMD="docker compose run --rm web"
function docker_run {
  cmd=$1
  echo ${COLOR_CMD}${cmd}${COLOR_OFF}
  $RUN_ON_WEB_CMD $cmd
}
docker compose up -d
docker_run "bundle install "
docker_run "yarn install --check-files"
docker_run "yarn upgrade"
docker_run "rails webpacker:install"
docker_run "rails db:setup"
