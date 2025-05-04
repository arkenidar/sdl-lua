#!/bin/bash

LJDIR=c:/MSYS64/home/dario/luajit/src

gcc src/*.c -o sdl-lua-console $(pkg-config --cflags --libs sdl3) -I$LJDIR -L$LJDIR -lluajit-5.1.dll -mconsole
gcc src/*.c -o sdl-lua-windows $(pkg-config --cflags --libs sdl3) -I$LJDIR -L$LJDIR -lluajit-5.1.dll -mwindows

cp /c/msys64/mingw64/bin/SDL3.dll .
cp $LJDIR/lua51.dll .
