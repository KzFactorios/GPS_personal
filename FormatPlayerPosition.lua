require("util")

local mod_gui = require("mod-gui")

local play_time_seconds = -1

function FormatDisplayInformation(player)
    local _position = player.position
    
    local output = string.format("player - x: %d, y: %d", 
        math.floor(_position["x"]), math.floor(_position["y"]))

    return output
end

local Display = {
    top = { Next = "left" },    
    left = { Next = "top" },    
    opaque = { Next = "transparent" },
    transparent = { Next = "opaque" },
}

function EnsureDisplayLocation(index)
    if not storage.posDisplay then storage.posDisplay = {} end
    if not storage.posDisplay[index] then storage.posDisplay[index] = {} end
    if not storage.posDisplay[index].Location then storage.posDisplay[index].Location = "top" end
    if not storage.posDisplay[index].Variant then storage.posDisplay[index].Variant = "opaque" end
    return Display[storage.posDisplay[index].Location]
end

function Display.left.Area(player) return mod_gui.get_frame_flow(player) end

function Display.top.Area(player) return player.gui.top end

function GetGui(variant)
    return {
        type = variant.Variant == "opaque" and "button" or "label",
        name = "posDisplay",
        tooltip = "try left or right mouse click",
    }
end

function EnsureDisplay(index)
    local result = GetDisplay(index)
    if result then return result end

    local variant = EnsureDisplayLocation(index)
    local result = variant.Area(game.players[index]).add(GetGui(storage.posDisplay[index]))
    if storage.posDisplay[index].Location == "float" then
        result.location = storage.posDisplay[index].GuiLocation
    end
    return result
end

function GetDisplay(index)
    local variant = EnsureDisplayLocation(index)
    local area = variant.Area(game.players[index])
    return area.posDisplay
end

function ShowPlayerPosition(event)
    -- update every ? seconds
    -- TODO make this a setting
    local previous = play_time_seconds
    play_time_seconds = math.floor(game.tick / 6)
    if previous == play_time_seconds then return end

    -- do for all players
    for i, player in pairs(game.connected_players) do
        local posDisplay = EnsureDisplay(player.index)
        local value = FormatDisplayInformation(player)
        posDisplay.caption = value
    end
end

function OnClick(event)                      --
    local index = event.player_index
    if event.element == GetDisplay(index) then --
        GetDisplay(index).destroy()
        if event.button == defines.mouse_button_type.left then
            storage.posDisplay[index].Location = Display[storage.posDisplay[index].Location].Next
        elseif event.button == defines.mouse_button_type.right then
            storage.posDisplay[index].Variant = Display[storage.posDisplay[index].Variant].Next
        end
        EnsureDisplay(index)
    end
end

script.on_event(defines.events.on_gui_click, OnClick)
