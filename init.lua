-----------------------------------------------------------------------------------
-- File: init.lua
-- Author: Joaquín Cuitiño
-- License: MIT
-----------------------------------------------------------------------------------

local grid = require("grid")
local hyper = require("hyper")
local windowManager = require("window-manager")
local doubleShift = require("double-shift")

hyper.install("F18")

hyper.bindKey("r", hs.reload)
hyper.bindKey("`",  hs.caffeinate.systemSleep)
hyper.remapKey("h", "left")
hyper.remapKey("j", "down")
hyper.remapKey("k", "up")
hyper.remapKey("l", "right")
hyper.remapKey("delete", "forwarddelete")
hyper.remap({}, "s", {"control", "shift", "cmd"}, "4") -- Screenshot area to clipboard
hyper.remap({"shift"}, "s", {"shift", "cmd"}, "4") -- Screenshot area to desktop
hyper.remap({"option"}, "s", {"shift", "cmd"}, "5") -- Screenshot/recording tool

-- Arrange windows for Chill configuration (dual display).
function chill()
  apps = {
    ["Code"] = { screen = 1, space = 1, position = grid.max },

    ["WhatsApp"] = { screen = 2, space = 1, position = grid.bottomLeft },
    ["Spotify"] = { screen = 2, space = 1, position = grid.topLeft },
    
    ["Safari"] = { screen = 2, space = 1, position = grid.right },
  }
  windowManager.arrange(apps)
end
hyper.bindKey("c", chill)

-- Arrange windows for Desktop configuration (dual display).
function desktop()
  apps = {
    ["Trello"] = { screen = 1, space = 3, position = grid.max },
    ["Toggl Track"] = { screen = 1, space = 2, position = grid.one_6 },
    ["Code"] = { screen = 1, space = 1, position = grid.max },

    ["WhatsApp"] = { screen = 2, space = 2, position = grid.topLeft },
    ["Messages"] = { screen = 2, space = 2, position = grid.topLeft },
    ["Slack"] = { screen = 2, space = 2, position = grid.topRight },
    ["Spotify"] = { screen = 2, space = 2, position = grid.bottomRight },
    ["GitKraken"] = { screen = 2, space = 2, position = grid.bottomLeft },
    
    ["Safari"] = { screen = 2, space = 1, position = grid.right },
    ["iTerm2"] = { screen = 2, space = 1, position = grid.topLeft },
    ["Firefox"] = { screen = 2, space = 1, position = grid.right },
    ["Google Chrome"] = { screen = 2, space = 1, position = grid.bottomLeft },
    ["Postman"] = { screen = 2, space = 1, position = grid.topRight }
  }
  windowManager.arrange(apps)
end
hyper.bindKey("d", desktop)


-- Arrange windows for Game Dev configuration (dual display).
function gameDev()
  apps = {
    ["Discord"] = { screen = 2, space = 2, position = grid.topRight },
    ["WhatsApp"] = { screen = 2, space = 2, position = grid.topLeft },
    ["Spotify"] = { screen = 2, space = 2, position = grid.bottomRight },
    ["GitKraken"] = { screen = 2, space = 2, position = grid.bottomLeft },

    ["Code"] = { screen = 1, space = 1, position = grid.max },
    ["Rider"] = { screen = 1, space = 1, position = grid.max },
    ["Safari"] = { screen = 1, space = 2, position = grid.max },
    ["Firefox"] = { screen = 1, space = 2, position = grid.max },
    ["Unity"] = { screen = 2, space = 1, position = grid.max }
  }
  windowManager.arrange(apps)
end
hyper.bindKey("g", gameDev)

-- Arrange windows for on-the-go configuration (single display).
function mobile()
  apps = {
    ["Trello"] = { screen = 1, space = 6, position = grid.max },

    ["Messages"] = { screen = 1, space = 5, position = grid.left },
    ["WhatsApp"] = { screen = 1, space = 5, position = grid.left },
    ["Slack"] = { screen = 1, space = 5, position = grid.right },
    ["Spotify"] = { screen = 1, space = 5, position = grid.right },
    ["Music"] = { screen = 1, space = 5, position = grid.right },

    ["Postman"] = { screen = 1, space = 3, position = grid.max },

    ["GitKraken"] = { screen = 1, space = 4, position = grid.four_1 },
    ["iTerm2"] = { screen = 1, space = 4, position = grid.two_5 },
    ["Toggl Track"] = { screen = 1, space = 4, position = grid.one_6 },

    ["Code"] = { screen = 1, space = 2, position = grid.max },
    ["Safari"] = { screen = 1, space = 1, position = grid.max },
    ["Firefox"] = { screen = 1, space = 1, position = grid.max }
  }
  windowManager.arrange(apps)
end
hyper.bindKey("e", mobile)

-- Kill front application. Press Hyper+F to pay respects.
function F()
  local app = hs.application.frontmostApplication()
  app:kill9()
end
hyper.bindKey("f", F)
