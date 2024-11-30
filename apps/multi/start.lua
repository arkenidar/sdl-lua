-- This is the entry point for the multi app
-- It will load the other apps and call their Draw functions

-- Add the parent directory to the package.path
-- https://chatgpt.com/c/6739bee7-c6e0-800a-bf9d-4c8ba0943f74
package.path = package.path .. ";../?.lua"

-- Load the other apps
local app01 = require("app01.start")
local app02 = require("app02.start")
local app03 = require("app03.start")

local graphic = require("graphic.start")

require("common.deltatime")

function Draw()
    local dt = DeltaTime()
    app01.Draw(dt)
    app02.Draw(dt)
    app03.Draw(dt)
    
    graphic.Draw(dt)
end

print("Hello from multi/start.lua")
