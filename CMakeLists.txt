cmake_minimum_required(VERSION 3.10)
project(app_project VERSION 0.1 LANGUAGES C)

add_executable(sdl "src/main.c")
add_executable(sdlw "src/main.c")

find_package(SDL2 REQUIRED)
target_link_libraries(sdl PRIVATE ${SDL2_LIBRARIES})
target_link_libraries(sdlw PRIVATE ${SDL2_LIBRARIES})

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

# use LuaJIT ?
if(WIN32)
    # directories for LuaJIT
    link_directories(c:/MSYS64/home/dario/luajit/src)
    include_directories(c:/MSYS64/home/dario/luajit/src)

    # Link against LuaJIT
    # ##target_link_libraries(sdl PRIVATE ${LUAJIT_LIBRARIES})

    # variant: no console window on Windows (Wine also works)
    # WARNING : when using this will not PRINT to stdout console !!! not good if debugging !
    # ### target_link_options( sdl PRIVATE -mwindows ) # uncomment for Windows (MinGW)
    target_link_libraries(sdl PRIVATE luajit-5.1.dll)
    target_link_libraries(sdlw PRIVATE luajit-5.1.dll)
    target_link_options( sdlw PRIVATE -mwindows ) # specific for sdlw.exe
endif()

# If you're on Linux, you might need to link against these additional libraries
if(UNIX AND NOT APPLE)
    target_link_libraries(sdl PRIVATE dl m)
endif()
