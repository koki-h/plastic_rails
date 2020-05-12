#!/bin/bash
SUBCOMMAND=$1
APPNAME=$2
set -eu
#BUILD_CMD="docker-compose build --build-arg APPNAME=$APPNAME --no-cache "
BUILD_CMD="docker-compose build --build-arg APPNAME=$APPNAME"
echo "appname: $APPNAME"

case "$OSTYPE" in
  darwin*)
    $BUILD_CMD web
    ;;
  linux*)
    $BUILD_CMD --build-arg UID=$(id -u) --build-arg GID=$(id -g) web
    ;;
  *)
    echo "Unknown OS Type: $OSTYPE"
    ;;
esac

case "$SUBCOMMAND" in
  new)
    docker-compose run --rm web rails new $APPNAME --database=mysql
esac
docker-compose run --rm -e $APPNAME web bundle install 
docker-compose run --rm -e $APPNAME web yarn install --check-files
docker-compose run --rm -e $APPNAME web rails db:setup
