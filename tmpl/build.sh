set -eu
APPNAME=$1
BUILD_CMD="docker-compose build --no-cache --build-arg APPNAME=$APPNAME"
RUN_ON_WEB_CMD="docker-compose run --rm web"

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

$RUN_ON_WEB_CMD rails new $APPNAME --database=mysql --skip-bundle --skip-webpack-install
