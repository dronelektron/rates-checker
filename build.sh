#!/bin/bash

PLUGIN_NAME="rates-checker"

cd scripting
spcomp $PLUGIN_NAME.sp -o ../plugins/$PLUGIN_NAME.smx
