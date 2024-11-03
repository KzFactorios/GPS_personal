--[[local mod_gui = require("mod-gui")]]


for idx, player in pairs(game.players) do
    --[[local gui = mod_gui.get_frame_flow(player).hwclock
    if gui then
        gui.destroy() 
        player.print("show player position migration 0.1.0")
    end ]] 

    -- cleanup renamed table
    if storage.posDisplay and storage.posDisplay[idx] then
        storage.posDisplay = nil
        player.print("posDisplay migration 0.1.0")
    end

    if storage["wct_gpsDisplay"] and storage["wct_gpsDisplay"][idx] then
        storage["wct_gpsDisplay"][idx] = nil
        game.print("wct_gpsDisplay migration 0.1.0")
    end

    if storage.wct_showGpsGUI and storage.wct_showGpsGUI[idx] then
        storage.wct_showGpsGUI = nil
        player.print("wct_showGpsGUI migration 0.1.0")
    end
end


if storage["wct_gpsDisplay"] then
    storage["wct_gpsDisplay"] = nil
    game.print("wct_gpsDisplay migration 0.1.0")
end

--]]