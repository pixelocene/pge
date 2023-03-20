local Tile = {}

function Tile:new(_v_absolutePositon, _v_gridPosition, _i_index, _o_quad, _tbl_properties)
    local tbl_o = {
        v_absolutePositon = _v_absolutePositon,
        v_gridPosition = _v_gridPosition,
        i_index = _i_index,
        o_quad = _o_quad,
        tbl_properties = _tbl_properties,
    }
    
    setmetatable(tbl_o, self)
    self.__index = self

    return tbl_o
end

return Tile