----------
--- Base GameState

local Vect2 = require "engine.util.Vect2"

local GameState = {}

--- Constructor
--
-- @usage
--
-- -- game/states/MyGameState.lua
-- 
-- local MyGameState = require('engine.GameState'):new()
-- 
-- function MyGameState:update(dt)
--     -- All the things to do for this state
-- end
--
-- function MyGameState:draw()
--     -- All the things to draw for this state
-- end
--
-- return MyGameState
function GameState:new()
    --- @warning Not to be used directly. Extend it instead.
    local o = {}
    setmetatable(o, self)
    self.__index = self

    return o
end

--- Empty update function.
-- @tparam number dt The Delta Time since the last update
function GameState:update(dt)
end

--- Empty draw function.
function GameState:draw()
end

return GameState