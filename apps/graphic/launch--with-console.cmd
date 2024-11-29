@echo off

@SET my_path=%~dp0
@SET this_dir=%my_path:~0,-1%
CD "%this_dir%"

SET ROOT_PATH=%this_dir%\..\..
@SET PATH=%ROOT_PATH%;%PATH%
START "console" "%ROOT_PATH%\sdl-lua-console"
REM PAUSE