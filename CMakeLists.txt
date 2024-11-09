cmake_minimum_required(VERSION 3.10)
project(app_project VERSION 0.1 LANGUAGES C)

add_executable(sdl "src/main.c")

find_package(SDL2 REQUIRED)

if (WIN32)
    target_link_libraries(sdl ${SDL2_LIBRARIES} m)
endif (WIN32)

if (UNIX)
    target_link_libraries(sdl ${SDL2_LIBRARIES} m)
endif (UNIX)
