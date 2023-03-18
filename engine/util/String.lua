local String = {}

function String.replace(subject, search, replace)
    return string.gsub(subject, search, replace)
end

return String