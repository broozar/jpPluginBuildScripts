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

cd "${SHIVA_PROJECT_PATH}/Plugins/${PLUGIN_ID}/Make/Linux/"

rm -rf ../../Temp/Linux/x86_32/*
rm -rf ../../Contents/Linux/x86_32/*
make -f ${PLUGIN_NAME}.makefile TARGET_ARCH=X86_32

rm -rf ../../Temp/Linux/x86_64/*
rm -rf ../../Contents/Linux/x86_64/*
make -f ${PLUGIN_NAME}.makefile TARGET_ARCH=X86_64

#check generated files
if [ -f ../../Contents/Linux/x86_32/${PLUGIN_NAME}.so ]
then
	echo -e "\033[32m${PLUGIN_NAME}-x86_32 : OK\033[0m"
else
	echo -e "\033[31m${PLUGIN_NAME}-x86_32 : COMPILATION FAILED\033[0m"
fi

if [ -f ../../Contents/Linux/x86_32/x86_64/${PLUGIN_NAME}.so ]
then
	echo -e "\033[32m${PLUGIN_NAME}-x86_64 : OK\033[0m"
else
	echo -e "\033[31m${PLUGIN_NAME}-x86_64 : COMPILATION FAILED\033[0m"
fi

# EOF
