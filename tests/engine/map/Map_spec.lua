require('tests.lib.love2d')

local Tileset = require('engine.map.Tileset')
local Map = require('engine.map.Map')

describe('engine.map.Map', function()

    it('Select the correct tileset based on the tile ID', function()

        -- Define tilesets manually by using test tilesets
        Map.a_tilesets = {
            Tileset:new(require('tests.resources.engine.Map.tileset_1'), 1),
            Tileset:new(require('tests.resources.engine.Map.tileset_2'), 100),
            Tileset:new(require('tests.resources.engine.Map.tileset_3'), 120),
        }

        -- Verify that the correct tileset is returned for a given tileId
        assert.are.equal(1, Map:getTilesetForTileId(1))
        assert.are.equal(1, Map:getTilesetForTileId(99))
        assert.are.equal(2, Map:getTilesetForTileId(100))
        assert.are.equal(2, Map:getTilesetForTileId(111))
        assert.are.equal(3, Map:getTilesetForTileId(120))
        assert.are.equal(3, Map:getTilesetForTileId(200))

    end)

end)