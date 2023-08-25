-----------------------------------------------------------------------------------
-- File: init.lua
-- Author: Joaquín Cuitiño
-- License: MIT
-----------------------------------------------------------------------------------

local grid = require("grid")
local hyper = require("hyper")
local windowManager = require("window-manager")
-- local doubleShift = require("double-shift")

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

hyper.remap({}, "1", {"control"}, "1") -- Move to desktop 1
hyper.remap({}, "2", {"control"}, "2") -- Move to desktop 2
hyper.remap({}, "3", {"control"}, "3") -- Move to desktop 3
hyper.remap({}, "4", {"control"}, "4") -- Move to desktop 4
hyper.remap({}, "q", {"control"}, "5") -- Move to desktop 5
hyper.remap({}, "w", {"control"}, "6") -- Move to desktop 6


-- Arrange windows for Chill configuration (dual display).
function chill()
  apps = {
    ["Code"] = { screen = 1, space = 1, position = grid.max },

    ["WhatsApp"] = { screen = 2, space = 1, position = grid.bottomLeft },
    ["WhatsApp Beta"] = { screen = 2, space = 1, position = grid.bottomLeft },
    ["Spotify"] = { screen = 2, space = 1, position = grid.topLeft },
    
    ["Safari"] = { screen = 2, space = 1, position = grid.right },
    ["Arc"] = { screen = 2, space = 1, position = grid.right },
  }
  windowManager.arrange(apps)
end
hyper.bindKey("c", chill)

-- Arrange windows for Desktop configuration (dual display).
function desktop()
  apps = {
    ["WebStorm"] = { screen = 1, space = 2, position = grid.max },
    ["PhpStorm"] = { screen = 1, space = 2, position = grid.max },
    ["Trello"] = { screen = 1, space = 2, position = grid.five_2 },
    ["Toggl Track"] = { screen = 1, space = 2, position = grid.one_1 },

    ["iTerm2"] = { screen = 2, space = 1, position = grid.topLeft },
    ["Firefox"] = { screen = 2, space = 1, position = grid.right },
    ["Google Chrome"] = { screen = 2, space = 1, position = grid.bottomLeft },
    ["Postman"] = { screen = 2, space = 1, position = grid.bottomLeft },

    ["Messages"] = { screen = 2, space = 2, position = grid.topLeft },
    ["WhatsApp"] = { screen = 2, space = 2, position = grid.topLeft },
    ["WhatsApp Beta"] = { screen = 2, space = 2, position = grid.topLeft },
    ["Slack"] = { screen = 2, space = 2, position = grid.topRight },
    ["Spotify"] = { screen = 2, space = 2, position = grid.bottomRight },
    ["YT Music"] = { screen = 2, space = 2, position = grid.bottomRight },
    ["GitKraken"] = { screen = 2, space = 2, position = grid.bottomLeft },
    ["Mail"] = { screen = 2, space = 2, position = grid.bottomLeft },
    ["HEY"] = { screen = 2, space = 2, position = grid.bottomLeft },
    ["Sublime Merge"] = { screen = 2, space = 2, position = grid.bottomLeft },
    
    ["Safari"] = { screen = 2, space = 1, position = grid.right },
    ["Arc"] = { screen = 2, space = 1, position = grid.right },
    ["Code"] = { screen = 1, space = 1, position = grid.max },
  }
  windowManager.arrange(apps)
end
hyper.bindKey("d", desktop)

-- function monitor()
--   apps = {
--     ["WebStorm"] = { screen = 1, space = 1, position = grid.bottomRight },
--     ["PhpStorm"] = { screen = 1, space = 2, position = grid.bottomRight },
--     ["Trello"] = { screen = 1, space = 2, position = grid.bottomLeft },
--     ["Toggl Track"] = { screen = 1, space = 2, position = grid.bottomLeft },

--     ["DataGrip"] = { screen = 1, space = 1, position = grid.topLeft },
--     ["iTerm2"] = { screen = 1, space = 1, position = grid.topLeft },
--     ["Firefox"] = { screen = 1, space = 1, position = grid.right },
--     ["Google Chrome"] = { screen = 1, space = 1, position = grid.bottomLeft },
--     ["Postman"] = { screen = 1, space = 1, position = grid.bottomLeft },

--     ["Messages"] = { screen = 1, space = 2, position = grid.topLeft },
--     ["WhatsApp"] = { screen = 1, space = 2, position = grid.topLeft },
--     ["Slack"] = { screen = 1, space = 2, position = grid.topRight },
--     ["Spotify"] = { screen = 1, space = 2, position = grid.bottomRight },
--     ["YT Music"] = { screen = 1, space = 2, position = grid.bottomRight },
--     ["GitKraken"] = { screen = 1, space = 2, position = grid.bottomLeft },
--     ["Mail"] = { screen = 1, space = 2, position = grid.bottomLeft },
--     ["HEY"] = { screen = 1, space = 2, position = grid.bottomLeft },
--     ["Sublime Merge"] = { screen = 1, space = 2, position = grid.bottomLeft },
    
--     ["Safari"] = { screen = 1, space = 1, position = grid.topRight },
--     ["Code"] = { screen = 1, space = 1, position = grid.bottomRight }
--   }
--   windowManager.arrange(apps)
-- end
-- hyper.bindKey("w", monitor)

function launchDesktop()
  hs.application.launchOrFocus("HEY")
  hs.application.launchOrFocus("Code")
  hs.application.launchOrFocus("Slack")
  hs.application.launchOrFocus("WhatsApp")
  hs.application.launchOrFocus("Toggl Track")
  hs.application.launchOrFocus("Arc")
  hs.application.launchOrFocus("iTerm2")
  hs.application.launchOrFocus("Spotify")
end
hyper.bindKey("l", launchDesktop)


-- Arrange windows for Game Dev configuration (dual display).
function gameDev()
  apps = {
    ["Discord"] = { screen = 2, space = 2, position = grid.topRight },
    ["WhatsApp"] = { screen = 2, space = 2, position = grid.topLeft },
    ["WhatsApp Beta"] = { screen = 2, space = 2, position = grid.topLeft },
    ["Spotify"] = { screen = 2, space = 2, position = grid.bottomRight },
    ["Mail"] = { screen = 2, space = 2, position = grid.bottomLeft },
    ["HEY"] = { screen = 2, space = 2, position = grid.bottomLeft },
    ["GitKraken"] = { screen = 2, space = 2, position = grid.bottomLeft },
    ["Sublime Merge"] = { screen = 2, space = 2, position = grid.bottomLeft },

    ["Firefox"] = { screen = 1, space = 2, position = grid.max },

    ["Unity"] = { screen = 2, space = 1, position = grid.max },
    ["Code"] = { screen = 1, space = 1, position = grid.max },
    ["Rider"] = { screen = 1, space = 1, position = grid.max },
    ["Safari"] = { screen = 1, space = 2, position = grid.max },
    ["Arc"] = { screen = 1, space = 2, position = grid.max },
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
    ["WhatsApp Beta"] = { screen = 1, space = 5, position = grid.left },
    ["Slack"] = { screen = 1, space = 5, position = grid.right },
    ["Spotify"] = { screen = 1, space = 5, position = grid.right },
    ["Music"] = { screen = 1, space = 5, position = grid.right },

    ["Postman"] = { screen = 1, space = 3, position = grid.max },

    ["GitKraken"] = { screen = 1, space = 4, position = grid.four_1 },
    ["Sublime Merge"] = { screen = 1, space = 4, position = grid.four_1 },
    ["iTerm2"] = { screen = 1, space = 4, position = grid.two_5 },
    ["Toggl Track"] = { screen = 1, space = 4, position = grid.one_6 },

    ["Firefox"] = { screen = 1, space = 1, position = grid.max },
    ["Mail"] = { screen = 1, space = 1, position = grid.right },
    ["HEY"] = { screen = 1, space = 1, position = grid.right },

    ["Code"] = { screen = 1, space = 2, position = grid.max },
    ["Safari"] = { screen = 1, space = 1, position = grid.max },
    ["Arc"] = { screen = 1, space = 1, position = grid.max },
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


function passwords()
  local url = 'x-apple.systempreferences:com.apple.Passwords-Settings.extension'
  local handler = 'com.apple.systempreferences'
  hs.urlevent.openURLWithBundle(url, handler)
end
hyper.bindKey("p", passwords)