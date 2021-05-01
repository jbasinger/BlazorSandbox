#!/bin/bash

BLAZOR_OUTPUT_DIR=".blazor"
CORDOVA_DIR="./Cordova"
STARTING_DIR=$(pwd)

./publish.sh

cd $CORDOVA_DIR
cordova serve
cd $STARTING_DIR
