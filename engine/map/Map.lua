----------
--- The Map module

local Tileset = require('engine.map.Tileset')
local Vect2   = require('engine.util.Vect2')

--- The map data
-- @field width (**int**) The map width in tiles
-- @field height (**int**) The map height in tiles
-- @field tileWidth (**int**) The width of a tile in pixels
-- @field tileHeight (**int**) The height of a tile in pixels
-- @field tilesets (@{engine.map.Tileset}[]) A table of tilesets
-- @field nodes () A matrix of all the tiles with their data (data only, nothing relative to rendering)
Map = {
    v_size = nil,
    v_tileSize = nil,
    a_tilesets = {},
    a_layers = {},
    a_nodes = {},
}

--- Load a map from a file
-- 
-- @tparam string file The name of the map inside "assets/maps" without the extension. (The map data is fetch from [Tiled](https://www.mapeditor.org/)'s Lua exports.)
--
-- @usage
--
-- -- For a file "assets/maps/graveyard.lua"
-- Map:load('graveyard')
function Map:load(_s_file)
    local tbl_data = require('assets.maps.' .. _s_file)

    self.v_size = Vect2:new(tbl_data.width, tbl_data.height)
    self.v_tileSize = Vect2:new(tbl_data.tilewidth, tbl_data.tileheight)

    self:loadTilesets(tbl_data)

    for _, tbl_layer in ipairs(tbl_data.layers) do
        table.insert(self.a_layers, tbl_layer)
    end

    --self:loadNodes()
end

--- Load the tilesets informations from the tilemap tilesets
-- @tparam string data The content of the tilemap file
function Map:loadTilesets(_tbl_data)
    for _, tbl_tileset in ipairs(_tbl_data.tilesets) do
        table.insert(
            self.a_tilesets, 
            Tileset:new(require('assets.tilesets.' .. tbl_tileset.name), tbl_tileset.firstgid)
        )
    end
end

--- Draw the map on the screen
function Map:draw()

    for _, tbl_layer in ipairs(self.a_layers) do
        for i_y = 1, tbl_layer.height - 1 do
            for i_x = 1, tbl_layer.width do

                local i_index = (i_x + (i_y - 1) * self.v_size.n_x) + 1
                local i_tileId = tbl_layer.data[i_index]

                if i_tileId ~= 0 then

                    local o_tileset = self.a_tilesets[self:getTilesetForTileId(i_tileId)]
                    local o_quad = o_tileset:getQuad(i_tileId)
                    local v_offset = o_tileset.v_offset
                    local v_camera = _G.DataTree.engine.v_camera

                    local v_absolutePosition = Vect2:new(
                        (i_x - 1) * o_tileset.v_tileSize.n_x,
                        (i_y - 1) * o_tileset.v_tileSize.n_y
                    )

                    local v_position = v_absolutePosition + v_offset + v_camera

                    love.graphics.draw(o_tileset.o_image, o_quad, v_position.n_x, v_position.n_y)

                end

            end
        end
    end

end

--- Get the tileset for the tileId
-- @tparam int tileId The tile ID
-- @treturn int @{engine.Map.Tileset} id in tilesets
function Map:getTilesetForTileId(_i_tileId)
    for i_index = #self.a_tilesets, 1, -1 do
        if _i_tileId >= self.a_tilesets[i_index].i_firstTileId then
            return i_index
        end
    end

    return 1
end

function Map:getTileUnderCursor()
    local i_x, i_y = love.mouse.getPosition()
    local v_mouse = Vect2:new(i_x, i_y)

    local v_absolutePosition = v_mouse - _G.DataTree.engine.v_camera

    local i_tileX = math.ceil(v_absolutePosition.n_x / self.v_tileSize.n_x)
    local i_tileY = math.ceil(v_absolutePosition.n_y / self.v_tileSize.n_y)

    return Vect2:new(i_tileX, i_tileY)
end

function Map:getNode(_v_tile)
    return {}
end

return Map