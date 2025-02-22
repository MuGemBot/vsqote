@echo off

set PROJ_NAME=qtest
set VC_DIR=D:\Program Files (x86)\Microsoft Visual Studio 14.0\VC
set MSDK_DIR=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A
set QT_DIR=D:\ProgramData\Qt\Qt5.7.1\5.7\msvc2015
set WIN_KIT=C:\Program Files (x86)\Windows Kits\10
set INCLUDE=%VC_DIR%\include;%MSDK_DIR%\Include;%WIN_KIT%\Include\10.0.10150.0\ucrt
set LIB=%MSDK_DIR%\Lib;%VC_DIR%\lib;%WIN_KIT%\Lib\10.0.10150.0\ucrt\x86
set SRC_DIR=%cd%
set BUILD_DIR=%cd%\build
set PATH=%VC_DIR%\bin;%MSDK_DIR%\Bin;%QT_DIR%\bin

if not exist %QT_DIR% exit
if not exist %SRC_DIR% exit
if not exist %BUILD_DIR% md %BUILD_DIR%

cd build

%QT_DIR%\bin\qmake.exe %SRC_DIR%\%PROJ_NAME%.pro -spec win32-msvc2015  "CONFIG+=debug" "CONFIG+=console"
if exist %BUILD_DIR%\debug\%PROJ_NAME%.exe del %BUILD_DIR%\debug\%PROJ_NAME%.exe
nmake Debug
if not exist %BUILD_DIR%\debug\Qt5Cored.dll (
  %QT_DIR%\bin\windeployqt.exe %BUILD_DIR%\debug\%PROJ_NAME%.exe
)