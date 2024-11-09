@REM cd sdl-lua/apps/app02/ && sdl-lua/sdl-lua.exe
@REM gcc src/*.c -o sdl-lua-console $(pkg-config --cflags --libs sdl2) -mconsole

@echo off

@SET my_path=%~dp0
@SET this_dir=%my_path:~0,-1%
CD "%this_dir%"

SET ROOT_PATH=%this_dir%\..\..
@SET PATH=%ROOT_PATH%;%PATH%
START "console" "%ROOT_PATH%\sdl-lua-console"
REM PAUSE