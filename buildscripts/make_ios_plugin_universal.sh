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

cd "${SHIVA_PROJECT_PATH}/Plugins/${PLUGIN_ID}/Make/iOS/"

#clean
xcodebuild clean -alltargets
rm -rf ../../Temp/iOS/*
rm -rf ../../Contents/iOS/*

#build device
xcodebuild -project ${PLUGIN_NAME}.xcodeproj -alltargets -configuration Release

#build simulator
xcodebuild -project ${PLUGIN_NAME}.xcodeproj -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.2' -scheme ${PLUGIN_NAME} -configuration Release

#merge binaries
cd ../../Contents/iOS
lipo -create "${PLUGIN_NAME}-arm64.a" "${PLUGIN_NAME}-x86_64.a" -output "${PLUGIN_NAME}.a"
rm ${PLUGIN_NAME}-arm64.a
rm ${PLUGIN_NAME}-x86_64.a

#check generated files
cd "${SHIVA_PROJECT_PATH}/Plugins/${PLUGIN_ID}/Contents/iOS/"

if [ -f ${PLUGIN_NAME}.a ]
then
	echo -e "\033[32m${PLUGIN_NAME} : OK\033[0m"
else
	echo -e "\033[31m${PLUGIN_NAME} : COMPILATION FAILED\033[0m"
fi

#EOF
