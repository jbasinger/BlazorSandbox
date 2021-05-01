#!/bin/bash

BLAZOR_OUTPUT_DIR=".blazor"
CORDOVA_DIR="./Cordova"
STARTING_DIR=$(pwd)

mkdir -p $BLAZOR_OUTPUT_DIR
dotnet publish BlazorSandbox.sln -o $BLAZOR_OUTPUT_DIR

rm -r $CORDOVA_DIR/www/*
mv $BLAZOR_OUTPUT_DIR/wwwroot/* $CORDOVA_DIR/www/
rm -r $BLAZOR_OUTPUT_DIR