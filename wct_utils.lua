local wutils = {}

wutils.tableContainsKey = function(t, key)
    for k, v in pairs(t) do
        if k == key or v == key then
            return true
        end
    end
    return false
end

wutils.addToSet = function(set, key)
    set[key] = true
end

wutils.removeFromSet = function(set, key)
    set[key] = nil
end

wutils.setContains = function(set, key)
    return set[key] ~= nil
end

function hex_to_rgb(hex)
    -- Remove # if present
    hex = hex:gsub("#","")
    
    -- Convert to rgb values (0-1 range)
    local r = tonumber("0x"..hex:sub(1,2)) / 255
    local g = tonumber("0x"..hex:sub(3,4)) / 255
    local b = tonumber("0x"..hex:sub(5,6)) / 255
    
    return {r=r, g=g, b=b}
end

return wutils