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
Map = {
    width = 0,
    height = 0,
    tileWidth = 0,
    tileHeight = 0,
    tilesets = {},
    layers = {},
    baseLayerWidth = 0,
}

--- Load a map from a file
-- 
-- @tparam string file The name of the map inside "assets/maps" without the extension. (The map data is fetch from [Tiled](https://www.mapeditor.org/)'s Lua exports.)
--
-- @usage
--
-- -- For a file "assets/maps/graveyard.lua"
-- Map:load('graveyard')
function Map:load(file)
    local data = require('assets.maps.' .. file)

    self.width = data.width
    self.height = data.height
    self.tileWidth = data.tilewidth
    self.tileHeight = data.tileheight

    self:loadTilesets(data)

    for _, layer in ipairs(data.layers) do
        table.insert(self.layers, layer)
    end

    self.baseLayerWidth = self.layers[1].width
end

--- Load the tilesets informations from the tilemap tilesets
-- @tparam string data The content of the tilemap file
function Map:loadTilesets(data)
    for _, tileset in ipairs(data.tilesets) do
        table.insert(
            self.tilesets, 
            Tileset:new(require('assets.tilesets.' .. tileset.name), tileset.firstgid)
        )
    end
end

--- Draw the map on the screen
function Map:draw()

    for _, layer in ipairs(self.layers) do
        for y = 1, layer.height - 1 do
            for x = 1, layer.width do

                local index = (x + (y - 1) * self.baseLayerWidth) + 1
                local tileId = layer.data[index]

                if tileId ~= 0 then

                    local tileset = self.tilesets[self:getTilesetForTileId(tileId)]
                    local quad = tileset:getQuad(tileId)
                    local offset = tileset.offset
                    local camera = _G.DataTree.engine.camera

                    local absolutePosition = Vect2:new(
                        (x - 1) * tileset.tileWidth,
                        (y - 1) * tileset.tileHeight
                    )

                    local position = absolutePosition + offset + camera

                    love.graphics.draw(tileset.image, quad, position.x, position.y)

                end

            end
        end
    end

end

--- Get the tileset for the tileId
-- @tparam int tileId The tile ID
-- @treturn int @{engine.Map.Tileset} id in tilesets
function Map:getTilesetForTileId(tileId)
    for index = #self.tilesets, 1, -1 do
        if tileId >= self.tilesets[index].firstTileId then
            return index
        end
    end

    return 1
end

function Map:getTileUnderCursor()
    local x, y = love.mouse.getPosition()
    local mouse = Vect2:new(x, y)

    local absolutePosition = mouse - _G.DataTree.engine.camera

    local tileX = math.ceil(absolutePosition.x / self.tileWidth)
    local tileY = math.ceil(absolutePosition.y / self.tileHeight)

    return tileX, tileY
end

return Map