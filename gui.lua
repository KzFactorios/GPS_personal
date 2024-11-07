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
            style = "wct_gps_frame",
        }

        local flow_container = frame.add {
            name = "__wct_gps_gui_flow_container",
            type = "frame",
            direction = "horizontal",
            style = "wct_gps_frame_inside_background",
        }

        -- temp Label version
        local gps_title_button = flow_container.add {
            name = "__wct_gps_gui_title_label",
            type = "label",
            direction = "horizontal",
            style = "wct_gps_title_label",
            caption = "GPS",
        }

--[[    TBD Button version
        local gps_title_button = flow_container.add {
            name = "__wct_gps_gui_title_button",
            type = "sprite-button",
            direction = "horizontal",
            style = "wct_gps_title_button",
            caption = "GPS",
        }]]

        local output_frame = flow_container.add {
            name = "__wct_gps_gui_output_frame",
            type = "frame",
            direction = "vertical",
            style = "wct_gps_output_frame",
        }

        local lng_line = output_frame.add {
            name = "__wct_gps_gui_output_lng_line",
            type = "frame",
            direction = "horizontal",
            style = "wct_gps_output_lng_line",
        }

        lng_line.add {
            name = "__wct_gps_gui_output_label",
            type = "label",
            style = "wct_gps_output_label",
            caption = "lng",
        }

        lng_line.add {
            name = "__wct_gps_gui_output_value",
            type = "label",
            style = "wct_gps_output_value",
        }

        local lat_line = output_frame.add {
            name = "__wct_gps_gui_output_lat_line",
            type = "frame",
            direction = "horizontal",
            style = "wct_gps_output_lat_line",
        }

        lat_line.add {
            name = "__wct_gps_gui_output_label",
            type = "label",
            style = "wct_gps_output_label",
            caption = "lat",
        }

        lat_line.add {
            name = "__wct_gps_gui_output_value",
            type = "label",
            style = "wct_gps_output_value",
        }
    end

    return frame_flow
end

function findLngElement(frame)
    if frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]
        and frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]["__wct_gps_gui_output_frame"]
        and frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]["__wct_gps_gui_output_frame"]["__wct_gps_gui_output_lng_line"]
        and frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]["__wct_gps_gui_output_frame"]["__wct_gps_gui_output_lng_line"]["__wct_gps_gui_output_value"]
    then
        -- we know where it is, just grab it
        return frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]["__wct_gps_gui_output_frame"]
        ["__wct_gps_gui_output_lng_line"]["__wct_gps_gui_output_value"]
    end
    return nil
end

function findLatElement(frame)
    if frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]
        and frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]["__wct_gps_gui_output_frame"]
        and frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]["__wct_gps_gui_output_frame"]["__wct_gps_gui_output_lat_line"]
        and frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]["__wct_gps_gui_output_frame"]["__wct_gps_gui_output_lat_line"]["__wct_gps_gui_output_value"]
    then
        -- we know where it is, just grab it
        return frame["__wct_gps_gui_root"]["__wct_gps_gui_flow_container"]["__wct_gps_gui_output_frame"]
        ["__wct_gps_gui_output_lat_line"]["__wct_gps_gui_output_value"]
    end
    return nil
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
