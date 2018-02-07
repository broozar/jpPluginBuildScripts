#! /usr/bin/env bash

# (c) Julien Pierron 2018-02-05
# paths modified 2018-02-08 Felix Caffier


# -----------------------------------------------
# -- EDIT PATHS AND VARIABLES TO FIT YOUR PROJECT
# -----------------------------------------------

# example: ~/Documents/myProject
SHIVA_PROJECT_PATH=...

# example: com.mycompany.mypluginname
# must be all lowercase
PLUGIN_ID=...

# example: MyPluginName
# can have mixed case, without "com.mycompany."
PLUGIN_NAME=...


# -----------------------------------------------
# -- NO EDITS BEYOND THIS POINT
# -----------------------------------------------

cd "${SHIVA_PROJECT_PATH}/Plugins/${PLUGIN_ID}/Make/Mac/"

#clean
xcodebuild clean -alltargets
rm -rf ../../Temp/Mac/*
rm -rf ../../Contents/Mac/*

#build
xcodebuild -project ${PLUGIN_NAME}.xcodeproj -alltargets -configuration Release

#check generated files
cd "${SHIVA_PROJECT_PATH}/Plugins/${PLUGIN_ID}/Contents/Mac/"

if [ -f ${PLUGIN_NAME}.a ]
then
	echo -e "\033[32m${PLUGIN_NAME} : OK\033[0m"
else
	echo -e "\033[31m${PLUGIN_NAME} : COMPILATION FAILED\033[0m"
fi

# EOF
