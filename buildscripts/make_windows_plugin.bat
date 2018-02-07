@echo off & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: (c) Julien Pierron 2018-02-05
:: paths modified 2018-02-08 Felix Caffier


:: -----------------------------------------------
:: -- EDIT PATHS AND VARIABLES TO FIT YOUR PROJECT
:: -----------------------------------------------

:: example: ~/Documents/myProject
SET SHIVA_PROJECT_PATH=...

:: example: com.mycompany.mypluginname
:: must be all lowercase
SET PLUGIN_ID=...

:: example: MyPluginName
:: can have mixed case, without "com.mycompany."
SET PLUGIN_NAME=...


:: -----------------------------------------------
:: -- NO EDITS BEYOND THIS POINT
:: -----------------------------------------------

call "%vs140comntools%vsvars32.bat"

SET PLUGIN_ROOT=!SHIVA_PROJECT_PATH!\Plugins\!PLUGIN_ID!
SET SOLUTION_FOLDER=!PLUGIN_ROOT!\Make\Windows
SET SOLUTION_PATH=!SOLUTION_FOLDER!\!PLUGIN_NAME!.sln

::clean and build x86_32
del /S /Q !SOLUTION_FOLDER!\..\..\Contents\Windows\x86_32\*
msbuild !SOLUTION_PATH! /t:Clean /property:Configuration=Release /property:Platform=Win32
msbuild !SOLUTION_PATH! /property:Configuration=Release /property:Platform=Win32 

::clean and build x86_64
del /S /Q !SOLUTION_FOLDER!\..\..\Contents\Windows\x86_64\*
msbuild !SOLUTION_PATH! /t:Clean /property:Configuration=Release /property:Platform=x64
msbuild !SOLUTION_PATH! /property:Configuration=Release /property:Platform=x64

SET PLUGIN_ROOT=!SHIVA_PROJECT_PATH!\Plugins\!PLUGIN_ID!

if exist !PLUGIN_ROOT!\Contents\Windows\x86_32\!PLUGIN_NAME!.dll (
    echo !PLUGIN_NAME! - x86_32 : OK
) else (
    echo !PLUGIN_NAME! - x86_32 : COMPILATION FAILED
)

if exist !PLUGIN_ROOT!\Contents\Windows\x86_64\!PLUGIN_NAME!.dll (
    echo !PLUGIN_NAME! - x86_64 : OK
) else (
    echo !PLUGIN_NAME! - x86_64 : COMPILATION FAILED
)

pause

:: EOF
