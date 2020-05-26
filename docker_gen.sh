#!/bin/sh
set -eu
APPNAME=$1
cp -a tmpl $APPNAME
cd $APPNAME
./build.sh $APPNAME

sed -i -e "s|\(working_dir: /apps/\)|\1$APPNAME|" docker-compose.yml # working_dirをrailsアプリのディレクトリに変更する
./setup.sh
