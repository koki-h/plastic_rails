#!/bin/bash
set -eu
APPNAME=$1
BUILD_CMD="docker compose build --no-cache"
RUN_ON_WEB_CMD="docker compose run --rm web"
OSTYPE=$(uname)

case "$OSTYPE" in
  Darwin*)
    $BUILD_CMD web
    ;;
  Linux*)
    $BUILD_CMD --build-arg UID=$(id -u) --build-arg GID=$(id -g) web
    ;;
  *)
    echo "Unknown OS Type: $OSTYPE"
    ;;
esac

$RUN_ON_WEB_CMD rails new $APPNAME --database=mysql --skip-bundle --skip-webpack-install -m /tmp/application_template/template.rb
