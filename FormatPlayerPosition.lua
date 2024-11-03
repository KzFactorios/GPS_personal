require("util")

local mod_gui = require("mod-gui")

local play_time_seconds = -1

-- add in the wct_gpsDisplay Table that holds output
function FormatCaption(player)

    return string.format("GPS: Long %d  Lat %d", math.floor(player.position.x), math.floor(player.position.y))

    --{type = "frame", save_as = "root_frame", direction = "vertical", handlers="add_tag.root_frame", children = {
    --    {type = "flow", style = "frame_header_flow", children = {
    --        {type = "label", style = "frame_title", caption = {"gui-tag-edit.frame_title"}},
    
    --output = output .. string.format("{type = \"label\", style = \"frame_title\", caption = {\"x: %d, y: %d\" }}", 
      --  math.floor(_position["x"]), math.floor(_position["y"]))

end

local Display = {
    top = { Next = "left" },    
    left = { Next = "top" },    
    --opaque = { Next = "transparent" },
    --transparent = { Next = "opaque" },
}

function EnsureDisplayLocation(index)
   -- if not index then return end
   --[[if storage.wct_gpsDisplay[index].Variant then
    storage.wct_gpsDisplay[index].Variant = nil
   end
   --[[
   if storage.posDisplay then
    storage.posDisplay = nil
   end]]

    if not storage.wct_gpsDisplay then storage.wct_gpsDisplay = {} end
    if not storage.wct_gpsDisplay[index] then storage.wct_gpsDisplay[index] = {} end
    if not storage.wct_gpsDisplay[index].Location then storage.wct_gpsDisplay[index].Location = "top" end
    if not storage.wct_gpsDisplay[index].Variant then storage.wct_gpsDisplay[index].Variant = "frame" end
    return Display[storage.wct_gpsDisplay[index].Location]
end

--function Display.left.Area(player) return mod_gui.get_frame_flow(player) end

function Display.left.Area(player) return player.gui.left end

function Display.top.Area(player) return player.gui.top end

function GetGui(variant)
    return {
        type = variant.Variant == "frame", --"opaque" and "button" or "label",
        name = "wct_gpsDisplay",
        tooltip = "left click to change location"--"try left or right mouse click",
    }
end

function GetDisplay(index)
    local variant = EnsureDisplayLocation(index)
    local area = variant.Area(game.players[index])
    return area.wct_gpsDisplay
end

function EnsureDisplay(index)
    local result = GetDisplay(index)
    if result then return result end
    
    -- local variant = EnsureDisplayLocation(index)
    -- local result = variant.Area(game.players[index]).add(GetGui(storage.posDisplay[index]))

    local guiFrame_variant = EnsureDisplayLocation(index)
    local guiElement_table = GetGui(storage.wct_gpsDisplay[index])
    local areaToAdd = guiFrame_variant.Area(game.players[index])

    local newArea = areaToAdd.add(guiElement_table)

    if storage.wct_gpsDisplay[index].Location == "float" then
        newArea.location = storage.wct_gpsDisplay[index].GuiLocation
    end
    return result
end

function ShowPlayerPosition(event)
    -- update every ? seconds
    -- TODO make this a setting

    -- TODO only update when not in map view - or don't show in map view
    local previous = play_time_seconds
    play_time_seconds = math.floor(game.tick / 6)
    if previous == play_time_seconds then return end

    -- do for all players
    for _, player in pairs(game.connected_players) do
        EnsureDisplay(player.index).caption = FormatCaption(player)
    end
end


function OnClick(event)                      --
    local index = event.player_index
    if event.element == GetDisplay(index) then --
        GetDisplay(index).destroy()
        if event.button == defines.mouse_button_type.left then
            storage.wct_gpsDisplay[index].Location = Display[storage.wct_gpsDisplay[index].Location].Next
        elseif event.button == defines.mouse_button_type.right then
            --storage.wct_gpsDisplay[index].Variant = Display[storage.wct_gpsDisplay[index].Variant].Next
        end
        EnsureDisplay(index)
    end
end

script.on_event(defines.events.on_gui_click, OnClick)
