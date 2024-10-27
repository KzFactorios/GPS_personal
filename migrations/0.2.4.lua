local mod_gui = require("mod-gui")

for _, player in pairs(game.players) do
    local gui = mod_gui.get_frame_flow(player).hwclock
    if gui then
        gui.destroy() 
        player.print("show player position migration 0.1.0")
    end  
end