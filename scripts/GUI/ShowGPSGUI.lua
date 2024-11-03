local gui = require("lib/gui")

  local ShowGPSGUI = {}

--handlers="add_tag.root_frame", 
  local add_tag_frame_template = function(player)
    return
      {type = "flow", save_as = "root_frame", direction = "flow", style = "slot_window_frame", children = {
  
        {type = "flow", style = "mod_gui_inside_deep_frame", children = {
          {type = "empty-widget", save_as = "buttons.draggable_space_header", style = "draggable_space", width = "75px"},
          {type = "label", style = "slot_button", caption = ShowGPSGUI.formatGPScoords(player)},
        }},
  
      }} -- end of root frame
  end

  ShowGPSGUI.on_init = function()
    if (storage.wct_showGpsGUI == nil) then
      storage.wct_showGpsGUI = {}
    end
    if not storage.wct_showGpsGUI.players then
        storage.wct_showGpsGUI = {
        players = {}
        }
        for _, player in pairs(game.players) do
        storage.wct_showGpsGUI.players[player.index] = {}
        end
    end
  end
  
  ShowGPSGUI.on_player_created = function(event)
    storage.wct_showGpsGUI.players[event.player_index] = {}
  end
  
  ShowGPSGUI.on_player_removed = function(event)
    storage.wct_showGpsGUI.players[event.player_index] = nil
  end
  
  ShowGPSGUI.is_open = function(player)   
    if player then
        return storage.wct_showGpsGUI.players[player.index].elements ~= nil
    end
  end

  ShowGPSGUI.open = function(player)
    if player then
      local position = player.position
      local elements = gui.build(player.gui.screen, {add_tag_frame_template(player)})
  
      --elements.root_frame.force_auto_center()
      -- elements.fields.text.focus()
      elements.buttons.draggable_space_header.drag_target = elements.root_frame
  
      -- Not sure if this will fix the problem aka are we building the player correctly?
      if not storage.wct_showGpsGUI.players[player.index] then
        storage.wct_showGpsGUI.players[player.index] = player
      end
  
      storage.wct_showGpsGUI.players[player.index].elements = elements
      storage.wct_showGpsGUI.players[player.index].position = position
      player.opened = elements.root_frame    
      
    end
  end

  ShowGPSGUI.close = function(player)
    if player then
      if not ShowGPSGUI.is_open(player) then
        return
      end    
      player.opened = nil
    end
  end

  ShowGPSGUI.formatGPScoords = function(player)
    if(player) then
        return string.format("GPS: long %d lat %d", math.floor(player.position.x), math.floor(player.position.y))
    end
    return ""
  end

  ShowGPSGUI.updateGPS = function(event)
    -- TODO update every ? seconds setting
    -- TODO only update when not in map view
    local previous = play_time_seconds
    play_time_seconds = math.floor(game.tick / 6)
    if previous == play_time_seconds then return end

    if not storage.wct_showGpsGUI then
        ShowGPSGUI.on_init()
    end

    for idx, player in ipairs(game.connected_players) do
        if storage.wct_showGpsGUI and storage.wct_showGpsGUI.players[idx] then
          ShowGPSGUI.open(player)
        end
    end
end

--[[ShowGPSGUI.handlers = { 
    add_tag = {
        root_frame = {
          on_gui_closed = function(event)
            storage.GUI.AddTag.players[event.player_index].elements.root_frame.destroy()
            storage.GUI.AddTag.players[event.player_index] = {}
          end
        },
    }
}]]
  
return ShowGPSGUI


