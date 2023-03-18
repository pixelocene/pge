----------
--- All the game variables

local Vect2 = require "engine.util.Vect2"

--- The DataTree contains all game variables.
-- @field system
-- @field system.mouse
-- @field system.mouse.grabbing (bool) Is the mouse currently holding button 1?
-- @field system.mouse.originalPosition (@{engine.util.Vect2}) The last position for the drag (must be refresh at each update())
-- @field engine
-- @field engine.map (@{engine.map.Map}) The map engine
-- @field game
-- @field game.states (@{engine.state.GameState}[]) All the available states 
-- @field game.state (@{engine.state.GameState}) The current state
DataTree = {
    system = {
        mouse = {
            grabbing = false,
            originalPosition = Vect2:new(0, 0),
        },
    },
    engine = {
        camera = Vect2:new(0, 0),
        map = nil,
    },
    game = {
        states = {},
        state = nil,
    },
}

--- Intialize the DataTree
function DataTree:init()
    -- Load all the parts of the engine
    self.engine.map = require('engine.map.Map')
end

function DataTree:registerStates(states)
    for name , state in pairs(states) do
        self.game.states[name] = state
    end
end

function DataTree:setStartingState(stateName)
    self.game.state = self.game.states[stateName]
end

--- Reset the game data
function DataTree:reset()
    self.game.state = self.game.states['game']
end

return DataTree