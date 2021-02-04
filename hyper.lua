local This = {}

-----------------------------------------------------------------------------------
-- File: hyper.lua
-- Author: J.H. Kuperus
-- Source: https://github.com/jhkuperus/dotfiles/blob/master/hammerspoon/hyper.lua
-- "License": Feel free to use this file any way you like. Issues or improvements
--            are welcome on the GitHub repository. No warranties whatsoever.
-----------------------------------------------------------------------------------

-- To use Hyper in your init.lua script, import it and adapt this example to
-- your needs:
-- 
-- local hyper = require('hyper')
-- hyper.install('F18') 
-- hyper.bindkey('r', hs.reload)
--
-- The above three lines initialize Hyper to respond to F18 key-events and binds
-- Hyper+r to Hammerspoon Reload (easy way to refresh Hammerspoon's config)

-- Hyper mode needs to be bound to a key. Here we are binding
-- it to F17, because this is yet another key that's unused.
-- Why not F18? We will use key-events from F18 to turn hyper
-- mode on and off. Using F17 as the modal and source of key
-- events, will result in a very jittery Hyper mode.

This.hyperMode = hs.hotkey.modal.new({}, 'F17')
theHotkey = nil

-- Enter Hyper Mode when F18 (Hyper) is pressed
function enterHyperMode()
  This.hyperMode.triggered = false
  This.hyperMode:enter()
end

-- Leave Hyper Mode when F18 (Hyper) is pressed
function exitHyperMode()
   This.hyperMode:exit()
   if not This.hyperMode.triggered then
    hs.hid.capslock.set(not hs.hid.capslock.get())
  end
end

-- Utility to bind handler to Hyper+key
function This.bind(mods, key, handler)
  superHandler = function() 
    hs.alert("triggered super handler");
    This.hyperMode.triggered = true
    handler()
  end
  This.hyperMode:bind(mods, key, superHandler)
end

function This.bindKey(key, handler)
    This.bind({}, key, handler)
end

-- Utility to bind handler to Hyper+Shift+key
function This.bindShiftKey(key, handler)
   This.bind({'shift'}, key, handler)
end

-- Utility to bind handler to Hyper+Command+Shift+key
function This.bindCommandShiftKey(key, handler)
  This.bind({'command', 'shift'}, key, handler)
end

-- Utility to bind handler to Hyper+modifiers+key
function This.bindKeyWithModifiers(key, mods, handler)
   This.bind(mods, key, handler)
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

function This.remap(initialMods, initialKey, mods, key) 
  handler = function() 
    hs.eventtap.keyStroke(mods, key, 1000) 
  end
  This.bind(initialMods, initialKey, handler)
end

function This.remapKey(initialKey, key) 
   This.remap({}, initialKey, {}, key)
end

return This