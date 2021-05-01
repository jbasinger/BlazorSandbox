#!/bin/bash

STARTING_DIR=$(pwd)

./publish.sh

cd Cordova
cordova build android
cd $STARTING_DIR