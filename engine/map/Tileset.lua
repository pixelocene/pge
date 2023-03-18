----------
--- Tileset used by the Map

local String = require('engine.util.String')
local Vect2 = require('engine.util.Vect2')
local Tile = require('engine.map.Tile')

--- Tileset data
-- @field firstTileId (**int**) The id of the first tile as called in the @{engine.Map.Tileset}
-- @field image (**love.graphics.image**) The tileset image resource
-- @field offset (@{engine.util.Vect2}) The offset inside the tileset image
-- @field tileWidth (**int**) The width of a tile
-- @field tileHeight (**int**) The height of a tile
-- @field quads (@{engine.map.Tile}[]) The tiles in the tileset, indexed by tile number
local Tileset = {
    firstTileId = 1,
    image = nil,
    offset = nil,
    tileWidth = nil,
    tileHeight = nil,
    tiles = {},
    cols = 0,
    rows = 0,
}

--- Constructor
-- @param tilesetDefinition A tileset Lua export from Tiled
-- @tparam int firstTileId The id of the first tile
function Tileset:new(tilesetDefinition, firstTileId)
    local o = {
        firstTileId = firstTileId,
        tiles = {},
    }
    
    setmetatable(o, self)
    self.__index = self

    o:load(tilesetDefinition)

    return o
end

--- Load the tilset data in usable format
-- This method is called automaticaly by the constructor.
function Tileset:load(tilesetDefinition)
    local imageRealPath = String.replace(tilesetDefinition.image, '..', 'assets')

    self.image = love.graphics.newImage(imageRealPath)
    self.offset = Vect2.fromTable(tilesetDefinition.tileoffset)
    self.tileWidth = tilesetDefinition.tilewidth
    self.tileHeight = tilesetDefinition.tileheight
    self.cols = tilesetDefinition.columns
    self.rows = tilesetDefinition.tilecount / self.cols

    local imageWidth = tilesetDefinition.imagewidth
    local imageHeight = tilesetDefinition.imageheight

    -- Generate Quads for each tile
    local index = 1
    for y = 1, self.rows do
        for x = 1, self.cols do
            local gridPosition = Vect2:new(x, y)
            local absolutePosition = Vect2:new(
                (x - 1) * self.tileWidth,
                (y - 1) * self.tileHeight
            )

            local quad = love.graphics.newQuad(absolutePosition.x, absolutePosition.y, self.tileWidth, self.tileHeight, imageWidth, imageHeight)

            local tile = Tile:new(absolutePosition, gridPosition, index, quad, {})

            table.insert(self.tiles, tile)

            index = index + 1
        end
    end
end

--- Get the quad from its Id
-- @tparam int tileId The Id of the tile
-- @return love.graphics.Quad
function Tileset:getQuad(tileId) 
    return self.tiles[tileId - self.firstTileId + 1].quad
end

return Tileset