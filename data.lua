local wutils = require("wct_utils")

data.raw["gui-style"]["default"]["wct_gps_frame"] =
{
    type = "frame_style",
    parent = "frame",
    padding = 4,
    drag_by_title = false,
    use_header_filler = false
}

data.raw["gui-style"]["default"]["wct_gps_frame_inside_background"] = {
    type = "frame_style",
    parent = "mod_gui_inside_deep_frame",
    height = 42,
}

data.raw["gui-style"]["default"]["wct_gps_title_label"] =
{
    type = "label_style",
    parent = "label",
    padding = 8,
    top_padding = 4,
    right_padding = 0,
    font = "default-large-bold",
    font_color = { r=255, g=160, b=32 },
}

data.raw["gui-style"]["default"]["wct_gps_title_button"] =
{
    type = "button_style",
    parent = "slot_button",
    padding = 8,
    --font = "default-large-bold",    
    --minimal_width = 40,

    --[[default_graphical_set = {
        base = {
            width = 32,
            height = 32,
            border = 1, -- Thin border
            --filename = "__GPS_personal__/graphics/button.png",
        },
    },

    -- Minimal hover effect
    hovered_graphical_set = {
        border = 2, -- Border thickness
        border_color = { r = 255, g = 128, b = 0, a = 255 },
        base = {
            width = 31,
            height = 31,
            filename = "__GPS_personal__/graphics/button.png",
            -- No position change means no orange overlay -- Claude LIES!
        },
    },

    clicked_graphical_set = {
        base = {
            width = 30,
            height = 30,
            filename = "__GPS_personal__/graphics/button.png",
        },
    },]]
}

data.raw["gui-style"]["default"]["wct_gps_output_frame"] = {
    type = "frame_style",
    parent = "invisible_frame",
    padding = 0,
    height = 36,
}

data.raw["gui-style"]["default"]["wct_gps_output_lng_line"] = {
    type = "frame_style",
    parent = "invisible_frame",
    height = 18,    
    padding = 0,
}

data.raw["gui-style"]["default"]["wct_gps_output_lat_line"] = {
    type = "frame_style",
    parent = "invisible_frame",
    height = 18,
    padding = 0,
}

data.raw["gui-style"]["default"]["wct_gps_output_label"] = {
    type = "label_style",
    font = "default-bold",
    --font_color = {r = 255, g = 160, b = 32},
    width = 30,
    left_padding = 8,
}

data.raw["gui-style"]["default"]["wct_gps_output_value"] = {
    type = "label_style",
    parent = "label",
    minimal_width = 40,
    left_padding = 8,
    horizontal_align = "left",
}


    -- Optional: if you want a slight color change on hover instead
    --default_sprite_color = {r=1, g=1, b=1},
    --hovered_sprite_color = {r=255, g=128, b=1},  -- Keep full opacity
    
    -- Optional: disable the clicked offset if you don't want the button to move
    --clicked_vertical_offset = 0


--[[

local default_orange_color = {
    r = 255,
    g = 128,
    b = 0
  }

  local hovered_label_color = {
    r = 0.5 * (1 + default_orange_color.r),
    g = 0.5 * (1 + default_orange_color.g),
    b = 0.5 * (1 + default_orange_color.b),
  }
data.raw["gui-style"]["default"]["wct_gps_title_button_container"] = {
    type = "frame_style",
    parent = "invisible_frame",
    height = 32,
    width = 32,
}]]
