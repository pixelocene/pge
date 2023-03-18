----------
--- String utilities

local String = {}

--- Replace a string by an another in a string
-- @tparam string subject The string to search and replace in
-- @tparam string search The substring we are looking to replace
-- @tparam string replace The string that will replace the searched one
-- @treturn string
-- @see The code is mainly inspired by https://github.com/lunarmodules/Penlight/blob/master/lua/pl/stringx.lua
function String.replace(subject, search, replace)

    return string.gsub(
        subject,
        search:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]','%%%1'), -- Escape special caracters (-.+[]()$^%?*)
        replace
    )

end

return String