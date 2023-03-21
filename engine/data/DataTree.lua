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
            b_grabbing = false,
            v_originalPosition = Vect2:new(0, 0),
        },
    },
    engine = {
        v_camera = Vect2:new(0, 0),
        o_map = nil,
    },
    game = {
        a_states = {},
        o_state = nil,
    },
}

--- Intialize the DataTree
function DataTree:init()
    -- Load all the parts of the engine
    self.engine.o_map = require('engine.map.Map')
end

function DataTree:registerStates(_a_states)
    for s_name , o_state in pairs(_a_states) do
        self.game.a_states[s_name] = o_state
    end
end

function DataTree:setStartingState(_s_stateName)
    self.game.o_state = self.game.a_states[_s_stateName]
end

--- Reset the game data
function DataTree:reset()
    self.game.o_state = self.game.a_states['game']
end

return DataTree