#!/bin/bash
export APPNAME=$1
set -eu
#RUN_ON_WEB_CMD="docker-compose run --rm web"
RUN_ON_WEB_CMD="docker-compose exec web"
docker-compose up -d
$RUN_ON_WEB_CMD bundle install 
$RUN_ON_WEB_CMD rails webpacker:install
$RUN_ON_WEB_CMD rails db:setup
