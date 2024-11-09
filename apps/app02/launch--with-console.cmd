REM cd sdl-lua/apps/app01/ && sdl-lua/sdl-lua.exe
REM gcc src/*.c -o sdl-lua-console $(pkg-config --cflags --libs sdl2) -mconsole
set ROOT_PATH=%CD%\..\..
set PATH=%ROOT_PATH%;%PATH%
start %ROOT_PATH%\sdl-lua-console
REM pause
