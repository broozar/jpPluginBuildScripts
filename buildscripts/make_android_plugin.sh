#! /usr/bin/env bash

# (c) Julien Pierron 2018-02-05
# paths modified 2018-02-08 Felix Caffier


# -----------------------------------------------
# -- EDIT PATHS AND VARIABLES TO FIT YOUR PROJECT
# -----------------------------------------------

# example: ~/Documents/myShiVaProject
SHIVA_PROJECT_PATH=...

# example: com.mycompany.mypluginname
# must be all lowercase
PLUGIN_ID=...

# example: MyPluginName
# can have mixed case, without "com.mycompany."
PLUGIN_NAME=...

# target Android API level as installed with Android Studio
ANDROID_PLATFORM=android-23

# example: /Users/julienpierron/Library/Android/sdk
ANDROID_SDK=...

# as installed with Android Studio
CMAKE_VERSION=3.6.4111459


# -----------------------------------------------
# -- NO EDITS BEYOND THIS POINT
# -----------------------------------------------

ANDROID_NDK=${ANDROID_SDK}/ndk-bundle
CMAKE=${ANDROID_SDK}/cmake/${CMAKE_VERSION}/bin/cmake
NINJA=${ANDROID_SDK}/cmake/${CMAKE_VERSION}/bin/ninja

cd "${SHIVA_PROJECT_PATH}/Plugins/${PLUGIN_ID}"

#clean
rm -rf ./Temp/Android/*
rm -rf ./Contents/Android/*

android_abis=(
	"armeabi"
	"armeabi-v7a"
	"x86"
)

for android_abi in "${android_abis[@]}"
do
	cd "${SHIVA_PROJECT_PATH}/Plugins/${PLUGIN_ID}/Make/Android/"
	mkdir "${android_abi}"
	cd "${android_abi}"

	${CMAKE} armeabi .. -G Ninja -DCMAKE_VERBOSE_MAKEFILE=ON -DANDROID_TOOLCHAIN=gcc -DCMAKE_MAKE_PROGRAM=${NINJA} -DANDROID_DEPRECATED_HEADERS=1 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake -DANDROID_ABI=${android_abi} -DANDROID_PLATFORM=${ANDROID_PLATFORM}

	${NINJA}

	cd ..
	rm -rf "${android_abi}"
done

architectures=(
	"arm_v5te"
	"arm_v7a"
	"x86_32"
)

for architecture in "${architectures[@]}"
do
	cd "${SHIVA_PROJECT_PATH}/Plugins/${PLUGIN_ID}/Contents/Android/${architecture}"

	if [ -f ${PLUGIN_NAME}.a ]
	then
		echo -e "\033[32m${PLUGIN_NAME} - ${architecture} : OK\033[0m"
	else
		echo -e "\033[31m${PLUGIN_NAME} - ${architecture} : COMPILATION FAILED\033[0m"
	fi
done

# EOF
