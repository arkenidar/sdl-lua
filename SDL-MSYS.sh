#!/bin/bash

cp /c/msys64/mingw64/bin/SDL2.dll .
gcc src/*.c -o sdl-lua-console $(pkg-config --cflags --libs sdl2) -mconsole
gcc src/*.c -o sdl-lua-windows $(pkg-config --cflags --libs sdl2) -mwindows
