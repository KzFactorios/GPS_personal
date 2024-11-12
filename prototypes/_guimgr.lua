local _constants = require("prototypes/constants")
local _gui = require("prototypes/gui")

local __wct_gui_mgr = {}

__wct_gui_mgr.update_gui = function(_custom, player)
  if player then
    _gui.update_gui(_custom, player)
  end
end

__wct_gui_mgr.reset_gui = function(_custom, player)
  if player then
    _gui.reset_gui(_custom, player)
  end
end

return __wct_gui_mgr
