-----------------------------------------------------------------------------------
-- File: window-manager.lua
-- Author: Joaquín Cuitiño
-- License: MIT
-----------------------------------------------------------------------------------

local grid = require("grid")
local spaces = require("hs._asm.undocumented.spaces")
local internal = require("hs._asm.undocumented.spaces.internal")
local logger = hs.logger.new("windowManager", "verbose")

hs.application.enableSpotlightForNameSearches(true)

local This = {}

function This.positionApp(appTitle, screen, space, position)
  logger.v("Positioning " .. appTitle)
  if (hs.application.get(appTitle) == nil) then
    logger.e("Application " .. appTitle .. " not found")
    return
  end

  windows = hs.application.get(appTitle):allWindows()
  if (#windows == 0) then
    logger.v("No windows found for ".. appTitle)
  end
  for k,v in pairs(windows) do
    logger.v("Positioning window "..v:id().. " of app "..appTitle)
    spaces.moveWindowToSpace(v:id(), space)
    if (position == nil) then
      position = grid.max
    end
    hs.grid.set(v, position, screen)
    v:application():unhide()
    if (v:isMinimized()) then
        v:unminimize()
    end
  end
end

function This.arrange(apps)
  local screens = hs.screen.allScreens()

  -- Select all aplications for filter
  local filter = hs.window.filter.new(false):setCurrentSpace(nil)
  logger.v(dump(filter:getWindows()))

  for appName,app in pairs(apps) do
      -- hs.application.launchOrFocus(appName)
      filter:allowApp(appName)
  end

  -- Hide all windows (this fixes inconsistent window arrangement)
  local windows = filter:getWindows()
  logger.v(dump(windows))
  for k,v in pairs(windows) do
      v:application():hide()
  end

  -- Get spaces
  logger.v("Fetching spaces and screens")
  local allSpaces = spaces:layout()
  logger.v(dump(allSpaces))

  -- Find primary and secondary screens UUIDs
  local primaryScreenUUID = hs.screen.primaryScreen():getUUID()
  logger.v("Primary screen UUID: " .. primaryScreenUUID)
  local secondaryScreenUUID = hs.screen.primaryScreen():next():getUUID()
  logger.v("Secondary screen UUID: " .. secondaryScreenUUID)

  -- Organize all windows
  for appName,app in pairs(apps) do
      local screenSpaces = nil
      if app.screen == 1 then
          screenSpaces = allSpaces[primaryScreenUUID]
      else
          screenSpaces = allSpaces[secondaryScreenUUID] 
      end
      This.positionApp(appName, screens[app.screen], screenSpaces[app.space], app.position)
  end

end

-- Prints a table.
function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k,v in pairs(o) do
      if type(k) ~= "number" then k = '"'..k..'"' end
      s = s .. "["..k.."] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

return This