#!/bin/bash

LUAJ=c:/MSYS64/home/dario/luajit/src

gcc src/*.c -o sdl-lua-console $(pkg-config --cflags --libs sdl2) -I$LUAJ -L$LUAJ -lluajit-5.1.dll -mconsole
gcc src/*.c -o sdl-lua-windows $(pkg-config --cflags --libs sdl2) -I$LUAJ -L$LUAJ -lluajit-5.1.dll -mwindows

cp /c/msys64/mingw64/bin/SDL2.dll .
cp /c/msys64/mingw64/bin/lua51.dll .
