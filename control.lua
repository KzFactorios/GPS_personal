--require("FormatPlayerPosition")
local gui = require("lib/gui")
local migration = require("__flib__.migration")
local mod_version_migrations = require("migrations/mod-version-migrations")
local ShowGPSGUI = require("scripts/GUI/ShowGPSGUI")

script.on_init(function()
    gui.init()
    gui.build_lookup_tables()
    ShowGPSGUI.on_init()
  end)

script.on_load(function()
    gui.build_lookup_tables()
end)

script.on_configuration_changed(function(event)
    migration.on_config_changed(event, mod_version_migrations)
  end)



function OnClick(event)                      --
    local index = event.player_index
    --[[if event.element == GetDisplay(index) then --
        GetDisplay(index).destroy()
        if event.button == defines.mouse_button_type.left then
            storage.wct_gpsDisplay[index].Location = Display[storage.wct_gpsDisplay[index].Location].Next
        elseif event.button == defines.mouse_button_type.right then
            --storage.wct_gpsDisplay[index].Variant = Display[storage.wct_gpsDisplay[index].Variant].Next
        end
        EnsureDisplay(index)
    end]]
end

script.on_event(defines.events.on_gui_click, OnClick)

script.on_event(defines.events.on_tick, ShowGPSGUI.updateGPS)
script.on_event(defines.events.on_player_created, ShowGPSGUI.on_player_created)
script.on_event(defines.events.on_player_removed, ShowGPSGUI.on_player_removed)
gui.add_handlers(ShowGPSGUI.handlers)
gui.register_handlers()