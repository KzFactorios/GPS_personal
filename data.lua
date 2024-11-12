local _constants = require("prototypes/constants")

local gui = data.raw["gui-style"]["default"]


gui[_constants.LEGACYGPS_MODNAME .. "_container"] = {
    type = "frame_style",
    parent = "slot_window_frame",
    --height = 56,
    padding = 8,
}

gui[_constants.GPS_MODNAME] = {
    type = "frame_style",
    parent = "invisible_frame", -- spacing is whack in "frame"!!!
    padding = 0,
    height = 38,
    left_margin = 2,
    right_margin = 2,
    use_header_filler = false,
    graphical_set = {
        base = {
            position = { 0, 0 },
            size = { 1, 1 },
            -- can't get color to work 11-11-24
            --color = { r = 0.7, g = 0.7, b = 0.9, a = 1 },
        }
    }
}

gui[_constants.GPS_MODNAME .. "_line"] = {
    type = "frame_style",
    parent = "invisible_frame",
    direction = "horizontal_align",
    padding = 0,
    top_margin = 1,
    height = 17,
}

gui[_constants.GPS_MODNAME .. "_label"] = {
    type = "label_style",
    font = "default-small",
    width = 30,
    height = 14,
    padding = 0,
    left_padding = 8,
}

gui[_constants.GPS_MODNAME .. "_value"] = {
    type = "label_style",
    minimal_width = 35,
    height = 14,
    padding = 0,
    left_padding = 2,
    right_padding = 8,
    horizontal_align = "left",
    font = "default-small",
    font_color = { r = 255, g = 192, b = 64 },
}
