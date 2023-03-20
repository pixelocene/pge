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
    i_firstTileId = 1,
    o_image = nil,
    v_offset = nil,
    v_tileSize = nil,
    i_tileWidth = nil,
    i_tileHeight = nil,
    a_tiles = {},
    v_size = nil,
}

--- Constructor
-- @param _tblTilesetDefinition A tileset Lua export from Tiled
-- @tparam _iFirstTileId The id of the first tile
function Tileset:new(_tbl_tilesetDefinition, _i_firstTileId)
    local tbl_o = {
        i_firstTileId = _i_firstTileId,
        a_tiles = {},
    }

    setmetatable(tbl_o, self)
    self.__index = self

    tbl_o:load(_tbl_tilesetDefinition)

    return tbl_o
end

--- Load the tilset data in usable format
-- This method is called automaticaly by the constructor.
function Tileset:load(_tbl_tilesetDefinition)
    local sImageRealPath = String.replace(_tbl_tilesetDefinition.image, '..', 'assets')
    local v_imageSize = Vect2:new(_tbl_tilesetDefinition.imagewidth, _tbl_tilesetDefinition.imageheight)
    local tbl_tilesProperties = {}

    self.o_image = love.graphics.newImage(sImageRealPath)
    self.v_offset = Vect2.fromTable(_tbl_tilesetDefinition.tileoffset)
    self.v_tileSize = Vect2:new(_tbl_tilesetDefinition.tilewidth, _tbl_tilesetDefinition.tileheight)
    self.v_size = Vect2:new(_tbl_tilesetDefinition.columns, _tbl_tilesetDefinition.tilecount / _tbl_tilesetDefinition.columns)

    for i_index = 1, #_tbl_tilesetDefinition.tiles do
        local tbl_tile = _tbl_tilesetDefinition.tiles[i_index]
        tbl_tilesProperties[tbl_tile.id] = tbl_tile.properties
    end

    -- Generate Quads for each tile
    local i_index = 1
    for i_y = 1, self.v_size.n_y do
        for i_x = 1, self.v_size.n_x do
            local v_gridPosition = Vect2:new(i_x, i_y)
            local v_absolutePosition = Vect2:new(
                (i_x - 1) * self.v_tileSize.n_x,
                (i_y - 1) * self.v_tileSize.n_y
            )

            local o_quad = love.graphics.newQuad(
                v_absolutePosition.n_x,
                v_absolutePosition.n_y,
                self.v_tileSize.n_x,
                self.v_tileSize.n_y,
                v_imageSize.n_x,
                v_imageSize.n_y
            )

            local o_tile = Tile:new(v_absolutePosition, v_gridPosition, i_index, o_quad, tbl_tilesProperties[i_index])

            table.insert(self.a_tiles, o_tile)

            i_index = i_index + 1
        end
    end
end

--- Get the quad from its Id
-- @tparam int tileId The Id of the tile
-- @return love.graphics.Quad
function Tileset:getQuad(_i_tileId) 
    return self.a_tiles[_i_tileId - self.i_firstTileId + 1].o_quad
end

return Tileset