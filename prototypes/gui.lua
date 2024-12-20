local wutils = require("wct_utils")
local _constants = require("prototypes/constants")

local __wct_gps_gui = {}


__wct_gps_gui.update_gui = function(_custom, player)
    -- TODO make one liner after debug
    if player then
        local gui = build_gui(player)
        __wct_gps_gui.update_gui_caption(player, gui)
    end
end

__wct_gps_gui.reset_gui = function(_custom, player)
    if player then        
        destroy_legacy_mod_gui(player)
        destroy_common_mod_gui(player)
    end
end

__wct_gps_gui.update_gui_caption = function(player, gui)
    -- only update if not in map view
    if player and gui and player.render_mode == defines.render_mode.game then
        local lng = findLngElement(gui)
        local lat = findLatElement(gui)

        if lng and lat then
            lng.caption = string.format("%d", math.floor(player.position.x))
            lat.caption = string.format("%d", math.floor(player.position.y))
        end
    end
end

-- returns the container of the widgets where we can land our own widget
-- first, try to get from shared top gui
-- if no go, then make a new top gui to work from
function get_parent_workspace(player)
    if player then
        local _top = wutils.tableFindByName(player.gui.top.children, _constants.GUITOPFRAME)
        if _top then
            local _inner = wutils.tableFindByName(_top.children, _constants.GUIINNERFRAME)
            if _inner then
                return _inner
            end
        else
            return create_parent_gui_failsafe(player)
        end
    end
    return nil
end

-- if for some reason there is no structure to place our gui in, mimic and create
function create_parent_gui_failsafe(player)
    if player then
        local _top = wutils.tableFindByName(player.gui.top.children, _constants.GUITOPFRAME)
        if not _top then
            _top = player.gui.top.add {
                name = _constants.GUITOPFRAME,
                type = "frame",
                direction = "horizontal",
                style = "slot_window_frame"
            }
        end

        local _inner = wutils.tableFindByName(_top.children, _constants.GUIINNERFRAME)
        if not _inner then
            _inner = _top.add {
                name = _constants.GUIINNERFRAME,
                type = "frame",
                direction = "horizontal",
                style = "mod_gui_inside_deep_frame"
            }
        end

        return _inner
    end
    return nil
end

function destroy_common_mod_gui(player)
    if player then
        local _top = wutils.tableFindByName(player.gui.top.children, _constants.GUITOPFRAME)
        if _top then
            local _inner = wutils.tableFindByName(_top.children, _constants.GUIINNERFRAME)
            if _inner then
                local _gui = wutils.tableFindByName(_inner.children, _constants.GPS_MODNAME)
                if _gui then
                    _gui.destroy()
                end
            end
        end
    end
end

function destroy_legacy_mod_gui(player)
    if player then
        local legacy_gui = wutils.tableFindByName(player.gui.top.children, _constants.LEGACYGPS_MODNAME)
        if legacy_gui then
            legacy_gui.destroy()
        end
    end
end

-- ensures we have proper structure in place
function build_gui(player)
    if player then
        
        local parent = get_parent_workspace(player)
        if parent and parent[_constants.GPS_MODNAME] then return parent[_constants.GPS_MODNAME] end

        if not parent then
            -- something went wrong
            -- build it the legacy way
            return nil
        end

        -- so now we have a parent container
        local gps
        if not parent[_constants.GPS_MODNAME] then
            gps = createGpsContainer(parent)
            local lngLine = createLngLine(gps)
            local latLine = createLatLine(gps)
        end
        -- so now we have built our gps
        return parent[_constants.GPS_MODNAME]
    end

    return nil
end

function createGpsContainer(parent)
    local _gps = parent.add {
        name = _constants.GPS_MODNAME,
        type = "frame",
        direction = "vertical",
        style = _constants.GPS_MODNAME,
    }

    return _gps
end

function createLngLine(p)
    local lng_line = p.add {
        name = _constants.GPS_MODNAME .. "_lng_line",
        type = "frame",
        --direction = "horizontal",
        style = _constants.GPS_MODNAME .. "_line",
    }

    lng_line.add {
        name = _constants.GPS_MODNAME .. "_label",
        type = "label",
        style = _constants.GPS_MODNAME .. "_label",
        caption = "lng",
    }

    lng_line.add {
        name = _constants.GPS_MODNAME .. "_value",
        type = "label",
        style = _constants.GPS_MODNAME .. "_value",
    }

    return lng_line
end

function createLatLine(p)
    local lat_line = p.add {
        name = _constants.GPS_MODNAME .. "_lat_line",
        type = "frame",
        --direction = "horizontal",
        style = _constants.GPS_MODNAME .. "_line",
    }

    lat_line.add {
        name = _constants.GPS_MODNAME .. "_label",
        type = "label",
        style = _constants.GPS_MODNAME .. "_label",
        caption = "lat",
    }

    lat_line.add {
        name = _constants.GPS_MODNAME .. "_value",
        type = "label",
        style = _constants.GPS_MODNAME .. "_value",
    }

    return lat_line
end

function findLngElement(gui)
    if gui[_constants.GPS_MODNAME .. "_lng_line"]
        and gui[_constants.GPS_MODNAME .. "_lng_line"][_constants.GPS_MODNAME .. "_value"]
    then
        -- we know where it is, just grab it
        return gui[_constants.GPS_MODNAME .. "_lng_line"][_constants.GPS_MODNAME .. "_value"]
    end
    return nil
end

function findLatElement(gui)
    if gui[_constants.GPS_MODNAME .. "_lat_line"]
        and gui[_constants.GPS_MODNAME .. "_lat_line"][_constants.GPS_MODNAME .. "_value"]
    then
        -- we know where it is, just grab it
        return gui[_constants.GPS_MODNAME .. "_lat_line"][_constants.GPS_MODNAME .. "_value"]
    end
    return nil
end

return __wct_gps_gui
