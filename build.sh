#!/bin/bash


tweakname="YUNoPauseAudio.dylib"
tweakplist="YUNoPauseAudio.plist"
tweak="$PWD"/.theos/obj/iphone_simulator/$tweakname

make clean


make -f Makefile_simulator
#make

if [ "$?" != 0 ]; then
	exit 1
fi

rm /opt/simject/$tweakname
cp "$tweak" /opt/simject/
cp "${tweakname%.dylib}.plist" /opt/simject/

respring_simulator 

