data.raw["gui-style"]["default"]["wct_gps_frame"] =
{
    type = "frame_style",
    parent = "frame",
    height = 40,
    padding = 0,
    base = {
        padding = 0
    },
    drag_by_title = false,
    use_header_filler = false
}

data.raw["gui-style"]["default"]["wct_gps_title_button"] =
{
    type = "button_style",
    parent = "slot_button",
    
    default_graphical_set = {
        filename = "__show-player-position__/graphics/button.png",
        width = 32,
        height = 32
    },
    hovered_graphical_set = {
        filename = "__show-player-position__/graphics/button.png",
        width = 32,
        height = 32
    },
    clicked_graphical_set = {
        filename = "__show-player-position__/graphics/button.png",
        width = 32,
        height = 32
    },
}

data.raw["gui-style"]["default"]["wct_gps_label"] =
{
    type = "frame_style",
    parent = "frame",
    height = 40,    
    top_padding = 6,
    left_padding = 6,
    --font = "default-small",
    use_header_filler = false,
}

data.raw["gui-style"]["default"]["wct_gps_output"] =
{
    type = "frame_style",
    parent = "deep_frame_in_shallow_frame",    
    ---parent = "label",
    height = 40,
    minimal_width = 50,
    top_padding = 10,
    left_padding = 6,
    use_header_filler = false,
}

-- couldn't override the font size above
local override_output = util.table.deepcopy(data.raw["gui-style"]["default"]["wct_gps_output"])
override_output.font = "default-small"
data.raw["gui-style"]["default"]["wct_gps_output"] = override_output