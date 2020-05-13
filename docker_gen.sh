#!/bin/sh
APPNAME=$1
cp -a tmpl $APPNAME
cd $APPNAME
./build.sh $APPNAME
./setup.sh $APPNAME
