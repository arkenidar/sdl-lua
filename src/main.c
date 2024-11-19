// Include the SDL2 library
#include <SDL2/SDL.h>

// Include the standard I/O library
#include <stdio.h>

// Include the standard library for random numbers (and seed the random number
// generator)
#include <stdlib.h>
#include <time.h>

// Include for Lua

// minilua ON
#define LUA_IMPL
#include "minilua.h"

// lua or luajit

// luajit OFF
/*
#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>
*/

SDL_Renderer* renderer;

int DrawPoint(lua_State* L)
{
    // Check if the first argument is integer and return the value
    int x = luaL_checkinteger(L, 1);

    // Check if the second argument is integer and return the value
    int y = luaL_checkinteger(L, 2);

    // printf("DrawPoint(%d,%d)\n", x, y);
    SDL_RenderDrawPoint(renderer, x, y);

    return 0;
}

int SetDrawColor(lua_State* L)
{
    int r = luaL_checkinteger(L, 1);
    int g = luaL_checkinteger(L, 2);
    int b = luaL_checkinteger(L, 3);

    // printf("SetDrawColor(%d,%d,%d)\n", r, g, b);
    SDL_SetRenderDrawColor(renderer, r, g, b, SDL_ALPHA_OPAQUE);

    return 0;
}

int GetTicks(lua_State* L)
{
    lua_Integer ticks = SDL_GetTicks64();
    lua_pushinteger(L, ticks);
    return 1;
}

int InputPoint(lua_State* L)
{
    int    ix, iy; // mouse position point
    Uint32 mouseButtonState = SDL_GetMouseState(&ix, &iy);
    int    primaryButtonPressed =
        mouseButtonState & SDL_BUTTON(SDL_BUTTON_LEFT) ? 1 : 0;
    lua_pushinteger(L, ix);
    lua_pushinteger(L, iy);
    lua_pushboolean(L, primaryButtonPressed);
    return 3;
}

int WindowSize(lua_State* L)
{
    int w, h;
    SDL_GetWindowSize(SDL_GetWindowFromID(1), &w, &h);
    lua_pushinteger(L, w);
    lua_pushinteger(L, h);
    return 2;
}

int main(int argc, char* argv[])
{
    printf("Hello, SDL2!\n");

    // Initialize Lua

    lua_State* L = luaL_newstate();
    luaL_openlibs(L);

    //----------------------------------
    // bind functions to Lua
    //----------------------------------

    // Push the pointer to function
    lua_pushcfunction(L, DrawPoint);

    // Get the value on top of the stack
    // and set as a global, in this case is the function
    lua_setglobal(L, "DrawPoint");

    //----------------------------------

    // Push the pointer to function
    lua_pushcfunction(L, SetDrawColor);

    // Get the value on top of the stack
    // and set as a global, in this case is the function
    lua_setglobal(L, "SetDrawColor");

    //----------------------------------

    // Push the pointer to function
    lua_pushcfunction(L, GetTicks);

    // Get the value on top of the stack
    // and set as a global, in this case is the function
    lua_setglobal(L, "GetTicks");

    //----------------------------------

    // Push the pointer to function
    lua_pushcfunction(L, InputPoint);

    // Get the value on top of the stack
    // and set as a global, in this case is the function
    lua_setglobal(L, "InputPoint");

    //----------------------------------

    // Push the pointer to function
    lua_pushcfunction(L, WindowSize);

    // Get the value on top of the stack
    // and set as a global, in this case is the function
    lua_setglobal(L, "WindowSize");

    //----------------------------------

    // Load the script

    printf(" ! Loading 'pix-let' application ! ( Lua embedded variant ) ! \n");

    if (luaL_dofile(L, "start.lua") == LUA_OK)
    {
        lua_pop(L, lua_gettop(L));
    }
    else
    {
        printf("luaL_dofile failed: %s\n", lua_tostring(L, -1));
        lua_close(L);
        return 1;
    }

    //----------------------------------

    // Seed the random number generator
    srand(time(NULL));

    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO) < 0)
    {
        printf("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());
        return 1;
    }

    // Create a window
    SDL_Window* window = SDL_CreateWindow(
        "Pixlet app. (Lua+SDL)", SDL_WINDOWPOS_UNDEFINED,
        SDL_WINDOWPOS_UNDEFINED, 300, 300,
        SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE | SDL_WINDOW_ALLOW_HIGHDPI);
    if (window == NULL)
    {
        printf("Window could not be created! SDL_Error: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    // Create a renderer
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    if (renderer == NULL)
    {
        printf("Renderer could not be created! SDL_Error: %s\n",
               SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    // Main loop flag
    int quit = 0;

    // Event handler
    SDL_Event e;

    // While application is running
    while (!quit)
    {
        // Handle events on queue
        while (SDL_PollEvent(&e) != 0)
        {
            // User requests quit
            if (e.type == SDL_QUIT)
            {
                quit = 1;
            }

            // User presses a key
            else if (e.type == SDL_KEYDOWN)
            {
                switch (e.key.keysym.sym)
                {
                case SDLK_ESCAPE:
                    quit = 1;
                    break;
                }
            }
        } // End SDL_PollEvent loop

        //--------------------------------------------

        // Clear screen

        // Set draw color to light gray
        SDL_SetRenderDrawColor(renderer, 0xCC, 0xCC, 0xCC, SDL_ALPHA_OPAQUE);

        // Clear the screen
        SDL_RenderClear(renderer);

        //--------------------------------------------

        // call function Draw()
        lua_getglobal(L, "Draw");
        if (lua_isfunction(L, -1))
        {
            if (lua_pcall(L, 0, 1, 0) == LUA_OK)
            {
                lua_pop(L, 1);
            }
        }
        else
            lua_pop(L, 1);

        //--------------------------------------------

        // - update the screen
        // - repeat
        // - until the user closes the window
        // - or presses the ESC key

        // Update screen
        SDL_RenderPresent(renderer);
    } // loop

    lua_close(L);

    // Destroy renderer and window
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);

    // Quit SDL subsystems
    SDL_Quit();

    return 0;
}
