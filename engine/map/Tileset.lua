----------
--- Tileset used by the Map

local stringx = require('pl.stringx')
local Vect2   = require('engine.util.Vect2')

--- Tileset data
-- @field firstTileId (**int**) The id of the first tile as called in the @{engine.Map.Tileset}
-- @field image (**love.graphics.image**) The tileset image resource
-- @field offset (@{engine.util.Vect2}) The offset inside the tileset image
-- @field tileWidth (**int**) The width of a tile
-- @field tileHeight (**int**) The height of a tile
-- @field quads (**love.graphics.quad[]**) The quads of the tiles in the tileset, indexed by tile number
local Tileset = {
    firstTileId = 1,
    image = nil,
    offset = nil,
    tileWidth = nil,
    tileHeight = nil,
    quads = {},
}

--- Constructor
-- @param tilesetDefinition A tileset Lua export from Tiled
-- @tparam int firstTileId The id of the first tile
function Tileset:new(tilesetDefinition, firstTileId)
    local o = {
        firstTileId = firstTileId,
        quads = {},
    }
    
    setmetatable(o, self)
    self.__index = self

    o:load(tilesetDefinition)

    return o
end

--- Load the tilset data in usable format
-- This method is called automaticaly by the constructor.
function Tileset:load(tilesetDefinition)
    local imageRealPath = stringx.replace(tilesetDefinition.image, '..', 'assets')

    self.image = love.graphics.newImage(imageRealPath)
    self.offset = Vect2.fromTable(tilesetDefinition.tileoffset)
    self.tileWidth = tilesetDefinition.tilewidth
    self.tileHeight = tilesetDefinition.tileheight

    local imageWidth = tilesetDefinition.imagewidth
    local imageHeight = tilesetDefinition.imageheight
    local cols = tilesetDefinition.columns
    local rows = tilesetDefinition.tilecount / cols

    -- Generate Quads for each tile
    for y = 1, rows do
        for x = 1, cols do
            table.insert(self.quads, love.graphics.newQuad(
                (x - 1) * self.tileWidth,
                (y - 1) * self.tileHeight,
                self.tileWidth,
                self.tileHeight,
                imageWidth,
                imageHeight
            ))
        end
    end
end

--- Get the quad from its Id
-- @tparam int tileId The Id of the tile
-- @return love.graphics.Quad
function Tileset:getQuad(tileId) 
    return self.quads[tileId - self.firstTileId + 1]
end

return Tileset