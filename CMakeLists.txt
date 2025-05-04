cmake_minimum_required(VERSION 3.31)
project(
  sdl-lua-project
  VERSION 1.0
  DESCRIPTION "SDL Lua Project"
  LANGUAGES C)

add_executable(sdl "src/main.c")
if(WIN32)
  add_executable(sdlw "src/main.c")
endif()

find_package(SDL3 REQUIRED)
target_link_libraries(sdl PRIVATE ${SDL3_LIBRARIES})
if(WIN32)
  target_link_libraries(sdlw PRIVATE ${SDL3_LIBRARIES})
endif()

# use LuaJIT ?
if(NOT WIN32)
  # Find LuaJIT package
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(LUAJIT REQUIRED luajit)

  # Include directories for LuaJIT
  target_include_directories(sdl PRIVATE ${LUAJIT_INCLUDE_DIRS})

  # Link against LuaJIT
  target_link_libraries(sdl PRIVATE ${LUAJIT_LIBRARIES})

  # Set compiler flags
  target_compile_options(sdl PRIVATE ${LUAJIT_CFLAGS_OTHER})
endif()

# use LuaJIT ? yes
if(WIN32)

  # set this to your LuaJIT sources ("src") directory
  set(DIR_LUAJIT "c:/MSYS64/home/dario/luajit/src")

  # directories for LuaJIT
  link_directories("${DIR_LUAJIT}")
  include_directories("${DIR_LUAJIT}")

  # Link against LuaJIT

  # variant: no console window on Windows (Wine also works) . WARNING : when
  # using this will not PRINT to stdout console !!! not good if debugging !
  target_link_libraries(sdl PRIVATE "${DIR_LUAJIT}/libluajit-5.1.dll.a")
  if(WIN32)
    target_link_libraries(sdlw PRIVATE "${DIR_LUAJIT}/libluajit-5.1.dll.a")
    # specific for sdlw.exe for Windows (MinGW)
    target_link_options(sdlw PRIVATE -mwindows)
  endif()
endif()

# If you're on Linux, you might need to link against these additional libraries
if(UNIX AND NOT APPLE)
  target_link_libraries(sdl PRIVATE dl m)
endif()
