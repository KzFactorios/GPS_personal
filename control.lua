local _mgr = require("prototypes/_guimgr")

-- TODO got to be a better way...
local _runOnce = false
local _play_time_seconds = -1

-- temp flag to use the new display method
-- pass it to the mgr
local _custom_gui = false  -- true is old method (separate gui)


script.on_event(defines.events.on_player_changed_position, function(event)
    -- update every ? seconds
    -- TODO make this a setting

    -- debounce
    local previous = _play_time_seconds
    _play_time_seconds = math.floor(event.tick / 10)
    if previous == _play_time_seconds then return end

    local player = game.players[event.player_index]
    _mgr.update_gui(_custom_gui, player)
    -- game.print("on player changed position")
end)

-- TODO I am sure there is a better way, more specific event to hook into
-- but in the interest of time...I'll get it on the next go-round
script.on_event(defines.events.on_tick, function(event)
    if not _runOnce then
        -- this is an init so do for all players
        for _, player in pairs(game.connected_players) do
            _mgr.reset_gui(_custom_gui, player)
            _mgr.update_gui(_custom_gui, player)
        end

        _runOnce = true
        --game.print("run once ran")
    end
end)
