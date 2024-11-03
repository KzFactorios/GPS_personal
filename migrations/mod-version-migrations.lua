-- for migrations that should run on script.on_configuration_changed

local gui = require("lib/gui")
local ShowGPSGUI = require("scripts/GUI/ShowGPSGUI")

-- MUST be ordered from older to newer
return {
  ["0.1.0"] = function()
    gui.init()
    gui.build_lookup_tables()
    ShowGPSGUI.on_init()
  end
}
