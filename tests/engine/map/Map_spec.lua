require('tests.lib.love2d')

local Tileset = require('engine.map.Tileset')
local Map = require('engine.map.Map')

describe('Test engine.Map', function()

    it('select the correct tileset based on the tile ID', function()

        -- Define tilesets manually by using test tilesets
        Map.tilesets = {
            Tileset:new(require('tests.resources.engine.Map.tileset_1'), 1),
            Tileset:new(require('tests.resources.engine.Map.tileset_2'), 100),
            Tileset:new(require('tests.resources.engine.Map.tileset_3'), 120),
        }

        -- Verify that the correct tileset is returned for a given tileId
        assert.are.equal(Map:getTilesetForTileId(1), 1)
        assert.are.equal(Map:getTilesetForTileId(99), 1)
        assert.are.equal(Map:getTilesetForTileId(100), 2)
        assert.are.equal(Map:getTilesetForTileId(111), 2)
        assert.are.equal(Map:getTilesetForTileId(120), 3)
        assert.are.equal(Map:getTilesetForTileId(200), 3)

    end)

end)