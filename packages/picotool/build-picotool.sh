#!/bin/bash

set -euo pipefail

BITNESS=$1
ARCH=$2

export PICO_SDK_PATH="$PWD/pico-sdk"
export LDFLAGS="-static -static-libgcc -static-libstdc++"

cd pico-sdk/tools/pioasm
mkdir -p build
cd build
cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Release -Wno-dev -DPIOASM_VERSION_STRING="2.2.0"
cmake --build .

cd ../../../..
INSTALLDIR="pico-sdk-tools/mingw$BITNESS"
mkdir -p $INSTALLDIR
cp pico-sdk/tools/pioasm/build/pioasm.exe $INSTALLDIR
cp ../packages/pico-sdk-tools/pico-sdk-tools-config.cmake $INSTALLDIR

cd picotool
mkdir -p build
cd build
cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Release
cmake --build .

cd ../..
INSTALLDIR="picotool-install/mingw$BITNESS"
mkdir -p $INSTALLDIR
cp picotool/build/picotool.exe $INSTALLDIR
cp "/mingw$BITNESS/bin/libusb-1.0.dll" $INSTALLDIR
