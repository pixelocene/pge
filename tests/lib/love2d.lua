--[[
    Fake Löve2D API to be used during the tests.

    Only the called functions have to be added and the body and parameters are not mandatory.
]]

_G.love = {
    graphics = {
        newImage = function() end,
        newQuad = function() return {} end,
    }
}