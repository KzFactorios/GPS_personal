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

return wutils