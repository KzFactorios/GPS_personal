local mod_gui = require("mod-gui")
local wutils = require("wct_utils")

local __wct_gps_gui = {}

__wct_gps_gui.ensure_gui = function(player)
    local frame_flow = mod_gui.get_frame_flow(player).gui.top

    if not wutils.tableContainsKey(frame_flow.children_names, "__wct_gps_gui_root") then
        local frame = frame_flow.add {
            name = "__wct_gps_gui_root",
            type = "frame",
            direction = "horizontal",
            style = "slot_window_frame",
        }

        local subframe = frame.add {
            name = "__wct_gps_gui_subframe",
            type = "frame",
            style = "mod_gui_inside_deep_frame",
            direction = "horizontal",
        }

        local gpstitle = subframe.add {
            name = "__wct_gps_gui_title",
            type = "sprite-button",
            direction = "horizontal",
            style = "wct_gps_title_button",            
        }

        subframe.add {
            name = "__wct_gps_gui_lng",
            type = "frame",
            direction = "horizontal",
            style = "wct_gps_label",
            caption = "lng",
        }

        subframe.add {
            name = "__wct_gps_gui_caption_lng",
            type = "frame",
            direction = "horizontal",
            style = "wct_gps_output",
            caption = "...",
        }

        subframe.add {
            name = "__wct_gps_gui_lat",
            type = "frame",
            direction = "horizontal",
            style = "wct_gps_label",
            caption = "lat",
        }        

        subframe.add {
            name = "__wct_gps_gui_caption_lat",
            type = "frame",
            direction = "horizontal",
            style = "wct_gps_output",
            caption = "...",
        }
    end

    return frame_flow
end

function findLngElement(frame)
    -- we know where it is, just grab it
    return frame["__wct_gps_gui_root"]["__wct_gps_gui_subframe"]["__wct_gps_gui_caption_lng"]
end

function findLatElement(frame)
    -- we know where it is, just grab it
    return frame["__wct_gps_gui_root"]["__wct_gps_gui_subframe"]["__wct_gps_gui_caption_lat"]
end

__wct_gps_gui.update_gui_caption = function(player, frame)
    -- only update if not in map view
    if player.render_mode == defines.render_mode.game then
        local lng = findLngElement(frame)
        local lat = findLatElement(frame)

        if lng and lat then
            lng.caption = string.format("%d", math.floor(player.position.x))
            lat.caption = string.format("%d", math.floor(player.position.y))
        end
    end
end

__wct_gps_gui.make_gui = function(player)
    local flow = __wct_gps_gui.ensure_gui(player)
    __wct_gps_gui.update_gui_caption(player, flow)
end

__wct_gps_gui.reset_gui = function(player)
    for _, v in ipairs(mod_gui.get_frame_flow(player).gui.top.children) do
        if v.name == "__wct_gps_gui_root" then
            v.destroy()
            break
        end
    end
end

return __wct_gps_gui
