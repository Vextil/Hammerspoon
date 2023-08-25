-----------------------------------------------------------------------------------
-- File: hyper.lua
-- Author: Joaquín Cuitiño
-- Adapted from: https://github.com/jhkuperus/dotfiles/blob/master/hammerspoon/hyper.lua
-- License: MIT
-----------------------------------------------------------------------------------

-- To use Hyper in your init.lua script, import it and adapt this example to
-- your needs:
-- 
-- local hyper = require("hyper")
-- hyper.install("F18") 
-- hyper.bindkey("r", hs.reload)
--
-- The above three lines initialize Hyper to respond to F18 key-events and binds
-- Hyper+r to Hammerspoon Reload (easy way to refresh Hammerspoon"s config)

-- Hyper mode needs to be bound to a key. Here we are binding
-- it to F17, because this is yet another key that"s unused.
-- Why not F18? We will use key-events from F18 to turn hyper
-- mode on and off. Using F17 as the modal and source of key
-- events, will result in a very jittery Hyper mode.
--
-- If the hyper key is pressed but not triggered (no shortcut is executed) 
-- then an "ESCAPE" keypress is emitted. This was added so we can replace the
-- Caps Lock key for Escape in touchbar MacBooks.


local This = {}

This.hyperMode = hs.hotkey.modal.new({}, "F17")

-- Enter Hyper Mode when F18 (Hyper) is pressed
function enterHyperMode()
  This.hyperMode.triggered = false
  This.hyperMode:enter()
end

-- Leave Hyper Mode when F18 (Hyper) is pressed
function exitHyperMode()
  This.hyperMode:exit()
  if not This.hyperMode.triggered then
    -- hs.eventtap.keyStroke({}, "ESCAPE")
    hs.hid.capslock.toggle()
  end
end

-- Binds handler function to Hyper+[modifiers]+key
function This.bind(mods, key, handler)
  superHandler = function() 
    This.hyperMode.triggered = true
    -- exitHyperMode()
    -- hs.alert("hyper", nil, hs.screen.mainScreen(), 1)
    handler()
  end
  This.hyperMode:bind(mods, key, superHandler)
end

-- Binds handler function to Hyper+key
function This.bindKey(key, handler)
  This.bind({}, key, handler)
end

-- Binds handler function to Hyper+Shift+key
function This.bindShiftKey(key, handler)
  This.bind({"shift"}, key, handler)
end

-- Binds handler function to Hyper+Command+Shift+key
function This.bindCommandShiftKey(key, handler)
  This.bind({"command", "shift"}, key, handler)
end

function This.remap(initialMods, initialKey, mods, key) 
  handler = function() 
    hs.eventtap.keyStroke(mods, key, 1000) 
  end
  This.bind(initialMods, initialKey, handler)
end

function This.remapKey(initialKey, key) 
  This.remap({}, initialKey, {}, key)
end

-- Binds the enter/exit functions of the Hyper modal to all combinations of modifiers
function This.install(hotKey)
  hs.hotkey.bind({}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "shift", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
end

return This