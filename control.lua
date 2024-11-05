-- switch to mod-gui approach
-- https://forums.factorio.com/viewtopic.php?t=53020
-- https://github.com/Bilka2/NewGamePlus

-- styles  https://lua-api.factorio.com/latest/prototypes/GuiStyle.html


local __wct_gps_gui = require("gui")

local _runOnce = false
local _play_time_seconds = -1

script.on_event(defines.events.on_player_changed_position, function(event)
    -- update every ? seconds
    -- TODO make this a setting
    local previous = _play_time_seconds
    _play_time_seconds = math.floor(event.tick / 10)
    if previous == _play_time_seconds then return end

    local player = game.players[event.player_index]
    __wct_gps_gui.make_gui(player)
   -- game.print("on player changed position")
end)

script.on_event(defines.events.on_tick, function(event)
    if not _runOnce then
        -- this is an init so do for all players
        for _, player in pairs(game.connected_players) do
            __wct_gps_gui.reset_gui(player)
            __wct_gps_gui.make_gui(player)
        end

        _runOnce = true
        game.print("run once ran")
    end

end)
