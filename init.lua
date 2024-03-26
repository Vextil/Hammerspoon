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
    ["com.microsoft.VSCode"] = { screen = 1, space = 1, position = grid.max },
    ["Rider"] = { screen = 1, space = 1, position = grid.max },
    ["Zed"] = { screen = 1, space = 1, position = grid.max },

    ["net.whatsapp.WhatsApp"] = { screen = 2, space = 1, position = grid.centerStage_topLeft },
    ["Mail"] = { screen = 2, space = 1, position = grid.centerStage_bottomLeft },
    ["Calendar"] = { screen = 2, space = 2, position = grid.centerStage_bottomLeftSidecar },
    ["com.spotify.client"] = { screen = 2, space = 1, position = grid.centerStage_bottomRight },
    
    ["com.apple.Safari"] = { screen = 2, space = 1, position = grid.centerStage },
  }
  windowManager.arrange(apps)
end
hyper.bindKey("c", chill)

-- Arrange windows for Desktop configuration (dual display).
function desktop()
  apps = {
    ["com.tinyspeck.slackmacgap"] = { screen = 2, space = 2, position = grid.centerStage_topRight },
    ["com.spotify.client"] = { screen = 2, space = 2, position = grid.centerStage_bottomRight },
    ["Mail"] = { screen = 2, space = 2, position = grid.centerStage_bottomLeft },
    ["Calendar"] = { screen = 2, space = 2, position = grid.centerStage_bottomLeftSidecar },

    ["com.apple.Safari"] = { screen = 2, space = 1, position = grid.right },
    -- ["HookSounds - "] = { screen = 2, space = 1, position = grid.left },
    -- ["Home - "] = { screen = 2, space = 1, position = grid.right },
    ["com.microsoft.VSCode"] = { screen = 1, space = 1, position = grid.max },
    ["Rider"] = { screen = 1, space = 1, position = grid.max },
    ["Zed"] = { screen = 1, space = 1, position = grid.max },

    ["net.whatsapp.WhatsApp"] = { screen = 2, space = 2, position = grid.centerStage_topLeft },
  }
  windowManager.arrange(apps)
end
hyper.bindKey("d", desktop)

-- Arrange windows for Game Dev configuration (dual display).
function gameDev()
  apps = {
    ["com.tinyspeck.slackmacgap"] = { screen = 2, space = 2, position = grid.centerStage_topRight },
    ["com.spotify.client"] = { screen = 2, space = 2, position = grid.centerStage_bottomRight },
    ["Mail"] = { screen = 2, space = 2, position = grid.centerStage_bottomLeft },
    ["Sublime Merge"] = { screen = 2, space = 2, position = grid.centerStage_bottomLeftSidecar },

    ["com.apple.Safari"] = { screen = 2, space = 1, position = grid.right },
    ["Unity"] = { screen = 2, space = 1, position = grid.left },
    ["com.microsoft.VSCode"] = { screen = 1, space = 1, position = grid.max },
    ["Rider"] = { screen = 1, space = 1, position = grid.max },
    ["Zed"] = { screen = 1, space = 1, position = grid.max },

    ["net.whatsapp.WhatsApp"] = { screen = 2, space = 2, position = grid.centerStage_topLeft },
  }
  windowManager.arrange(apps)
end
hyper.bindKey("g", gameDev)

function launchDesktop()
  hs.application.launchOrFocus("Mail")
  hs.application.launchOrFocus("Code")
  hs.application.launchOrFocus("Slack")
  hs.application.launchOrFocus("net.whatsapp.WhatsApp")
  hs.application.launchOrFocus("Toggl Track")
  hs.application.launchOrFocus("com.apple.Safari")
  hs.application.launchOrFocus("com.spotify.client")
end
hyper.bindKey("l", launchDesktop)

-- Arrange windows for on-the-go configuration (single display).
function mobile()
  apps = {
    ["net.whatsapp.WhatsApp"] = { screen = 1, space = 3, position = grid.topLeft },
    ["com.tinyspeck.slackmacgap"] = { screen = 1, space = 3, position = grid.topRight },
    ["com.spotify.client"] = { screen = 1, space = 3, position = grid.bottomRight },
    ["HEY"] = { screen = 1, space = 3, position = grid.bottomLeft },
    ["Calendar"] = { screen = 1, space = 3, position = grid.bottomRight },

    ["com.microsoft.VSCode"] = { screen = 1, space = 2, position = grid.max },
    ["com.apple.Safari"] = { screen = 1, space = 1, position = grid.max },
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