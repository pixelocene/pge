local Tile = {}

function Tile:new(absolutePositon, gridPosition, index, quad, data)
    local o = {
        absolutePositon = absolutePositon,
        gridPosition = gridPosition,
        index = index,
        quad = quad,
        data = data,
    }
    
    setmetatable(o, self)
    self.__index = self

    return o
end

return Tile