spaces = require("hs._asm.undocumented.spaces")
internal = require('hs._asm.undocumented.spaces.internal')
-- Load and install the Hyper key extension. Binding to F18
local hyper = require('hyper')

hyper.install('F18')

hyper.bindKey('r', hs.reload)
hyper.bindKey('return',  hs.caffeinate.systemSleep)
hyper.remapKey('h', 'left')
hyper.remapKey('j', 'down')
hyper.remapKey('k', 'up')
hyper.remapKey('l', 'right')
hyper.remapKey('delete', 'forwarddelete')
hyper.remap({}, 's', {'control', 'shift', 'cmd'}, '4') -- Screenshot area to clipboard
hyper.remap({'shift'}, 's', {'shift', 'cmd'}, '4') -- Screenshot area to desktop
hyper.remap({'option'}, 's', {'shift', 'cmd'}, '5') -- Screenshot/recording tool

hs.application.enableSpotlightForNameSearches(true)

eventtap = hs.eventtap
timer = hs.timer

primaryId = nil
secondaryId = nil

primarySpaces = {}
secondarySpaces = {}

-- To easily layout windows on the screen, we use hs.grid to create
-- a 6x6 grid. If you want to use a more detailed grid, simply 
-- change its dimension here
local GRID_SIZE = 6
local HALF_GRID_SIZE = GRID_SIZE / 2
-- Set the grid size and add a few pixels of margin
-- Also, don't animate window changes... That's too slow
hs.grid.setGrid(GRID_SIZE .. 'x' .. GRID_SIZE)
hs.grid.setMargins({0, 0})
hs.window.animationDuration = 0

-- Positions in the grid
local p = {
    left = {
        x = 0, y = 0,
        w = HALF_GRID_SIZE, h = GRID_SIZE
    },      
    right       = {
        x = HALF_GRID_SIZE, y = 0,
        w = HALF_GRID_SIZE, h = GRID_SIZE
    },      
    top         = {
        x = 0, y = 0,
        w = GRID_SIZE, h = HALF_GRID_SIZE
    },      
    bottom      = {
        x = 0, y = HALF_GRID_SIZE,
        w = GRID_SIZE, h = HALF_GRID_SIZE
    },      
    topLeft     = {
        x = 0, y = 0,
        w = HALF_GRID_SIZE, h = HALF_GRID_SIZE
    },      
    topRight    = {
        x = HALF_GRID_SIZE, y = 0,
        w = HALF_GRID_SIZE, h = HALF_GRID_SIZE
    },      
    bottomLeft  = {
        x = 0, y = HALF_GRID_SIZE,
        w = HALF_GRID_SIZE, h = HALF_GRID_SIZE
    },      
    bottomRight = {
        x = HALF_GRID_SIZE, y = HALF_GRID_SIZE,
        w = HALF_GRID_SIZE, h = HALF_GRID_SIZE
    },      
    max = {
        x = 0, y = 0, 
        w = GRID_SIZE, h = GRID_SIZE
    },      
    one_1 = {
        x = 0, y = 0, 
        w = 1, h = GRID_SIZE
    },
    one_2 = {
        x = 1, y = 0, 
        w = 1, h = GRID_SIZE
    },
    one_3 = {
        x = 2, y = 0, 
        w = 1, h = GRID_SIZE
    },
    one_4 = {
        x = 3, y = 0, 
        w = 1, h = GRID_SIZE
    },
    one_5 = {
        x = 4, y = 0, 
        w = 1, h = GRID_SIZE
    },     
    one_6 = {
        x = 5, y = 0, 
        w = 1, h = GRID_SIZE
    },
    two_1 = {
        x = 0, y = 0, 
        w = 2, h = GRID_SIZE
    },
    two_2 = {
        x = 1, y = 0, 
        w = 2, h = GRID_SIZE
    },
    two_3 = {
        x = 2, y = 0, 
        w = 2, h = GRID_SIZE
    },
    two_4 = {
        x = 3, y = 0, 
        w = 2, h = GRID_SIZE
    },
    two_5 = {
        x = 4, y = 0, 
        w = 2, h = GRID_SIZE
    },
    three_1 = {
        x = 0, y = 0, 
        w = 3, h = GRID_SIZE
    },
    three_2 = {
        x = 1, y = 0, 
        w = 3, h = GRID_SIZE
    },
    three_3 = {
        x = 2, y = 0, 
        w = 3, h = GRID_SIZE
    },
    three_4 = {
        x = 3, y = 0, 
        w = 3, h = GRID_SIZE
    },
    four_1 = {
        x = 0, y = 0, 
        w = 4, h = GRID_SIZE
    },
    four_2 = {
        x = 1, y = 0, 
        w = 3, h = GRID_SIZE
    },
    four_3 = {
        x = 2, y = 0, 
        w = 3, h = GRID_SIZE
    },
    five_1 = {
        x = 0, y = 0,
        w = 5, h = GRID_SIZE
    }, 
    five_2 = {
        x = 1, y = 0,
        w = 5, h = GRID_SIZE
    }
}

logger = hs.logger.new('windowManager', 'verbose')

function setSpaces()
    -- Set spaces
    currentSpace = spaces.activeSpace()
    currentSpaceHotkey = 0
    logger.v('Finding spaces')
    allSpaces = spaces.layout()

    local n = 0
    for k,v in pairs(allSpaces) do
      if n == 0 then
        primaryId = k
        logger.v("Primary screen ID: " .. primaryId);
      elseif n == 1 then
        secondaryId = k
        logger.v("Secondary screen ID: " .. secondaryId);
      end
      n = n + 1
    end

    primarySpaces = allSpaces[primaryId]
    secondarySpaces = allSpaces[secondaryId]

    logger.v(dump(spaces.layout()));
    logger.v(dump(primarySpaces));
    logger.v(dump(secondarySpaces));

end

function sleep(n)
    os.execute("sleep " .. tonumber(n))
end


function positionApp(appTitle, screen, space, position)
    logger.v('Positioning ' .. appTitle)
    if (hs.application.get(appTitle) == nil) then
        logger.e('Application ' .. appTitle .. ' not found')
        return
    end

    --hs.application.get(appTitle):activate()
    windows = hs.application.get(appTitle):allWindows()
    if (#windows == 0) then
        logger.v('No windows found for '.. appTitle)
    end
    for k,v in pairs(windows) do
        -- if (#internal.windowsOnSpaces(v:id()) <= 1) then
            logger.v('Positioning window '..v:id().. ' of app '..appTitle)
            spaces.moveWindowToSpace(v:id(), space)
            if (position == nil) then
              position = p.max
            end
            hs.grid.set(v, position, screen)
            v:application():unhide()
            if (v:isMinimized()) then
                v:unminimize()
            end
        -- end
    end
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function arrange(apps)
    setSpaces()
    local screens = hs.screen.allScreens()

    -- Select all aplications for filter
    local filter = hs.window.filter.new(false):setCurrentSpace(nil)
    logger.v(dump(filter:getWindows()))

    for appName,app in pairs(apps) do
        filter:allowApp(appName)
    end

    -- Hide all windows
    local windows = filter:getWindows()
    dump(windows)
    for k,v in pairs(windows) do
        v:application():hide()
    end

    -- Get spaces
    logger.v('Fetching spaces and screens')
    local allSpaces = spaces.layout()

    -- Find primary and secondary screens UUIDs
    local primaryScreenUUID = hs.screen.primaryScreen().getUUID()
    logger.v("Primary screen UUID: " .. primaryScreenUUID);
    local secondaryScreenUUID = nil
    for k,v in pairs(allSpaces) do
      if not k == primaryScreenUUID then
        secondaryScreenUUID = k
        logger.v("Secondary screen UUID: " .. secondaryScreenUUID);
      end
    end
    logger.v(dump(spaces.layout()));

    -- Organize all windows
    for appName,app in pairs(apps) do
        local screenSpaces = nil
        if app.screen == 1 then
            screenSpaces = allSpaces[primaryScreenUUID]
        else
            screenSpaces = allSpaces[secondaryScreenUUID] 
        end
        positionApp(appName, screens[app.screen], screenSpaces[app.space], app.position)
    end

    logger.v(dump(windows))

end

function desktop()

    apps = {
        ['Trello'] = { screen = 1, space = 3, position = p.max },
        ['Toggl Track'] = { screen = 1, space = 2, position = p.one_6 },
        ['Code'] = { screen = 1, space = 1, position = p.max },
    
        ['WhatsApp'] = { screen = 2, space = 2, position = p.topLeft },
        ['Messages'] = { screen = 2, space = 2, position = p.topLeft },
        ['Slack'] = { screen = 2, space = 2, position = p.topRight },
        ['Spotify'] = { screen = 2, space = 2, position = p.bottomRight },
        ['GitKraken'] = { screen = 2, space = 2, position = p.bottomLeft },
        
        ['Safari'] = { screen = 2, space = 1, position = p.bottomRight },
        ['iTerm2'] = { screen = 2, space = 1, position = p.topLeft },
        ['Firefox'] = { screen = 2, space = 1, position = p.right },
        ['Google Chrome'] = { screen = 2, space = 1, position = p.bottomLeft },
        ['Postman'] = { screen = 2, space = 1, position = p.topRight }
    }

    arrange(apps)

end

function gameDev()

    apps = {
        ['Discord'] = { screen = 2, space = 2, position = p.topRight },
        ['WhatsApp'] = { screen = 2, space = 2, position = p.topLeft },
        ['Spotify'] = { screen = 2, space = 2, position = p.bottomRight },
        ['GitKraken'] = { screen = 2, space = 2, position = p.bottomLeft },

        ['Code'] = { screen = 1, space = 1, position = p.max },
        ['Rider'] = { screen = 1, space = 1, position = p.max },
        ['Safari'] = { screen = 1, space = 2, position = p.max },
        ['Firefox'] = { screen = 1, space = 2, position = p.max },
        ['Unity'] = { screen = 2, space = 1, position = p.max }
    }

    arrange(apps)

end

function mobile()

    apps = {
        ['Trello'] = { screen = 1, space = 6, position = p.max },

        ['Messages'] = { screen = 1, space = 5, position = p.left },
        ['WhatsApp'] = { screen = 1, space = 5, position = p.left },
        ['Slack'] = { screen = 1, space = 5, position = p.right },
        ['Spotify'] = { screen = 1, space = 5, position = p.right },
        ['Music'] = { screen = 1, space = 5, position = p.right },

        ['Postman'] = { screen = 1, space = 3, position = p.max },

        ['GitKraken'] = { screen = 1, space = 4, position = p.four_1 },
        ['iTerm2'] = { screen = 1, space = 4, position = p.two_5 },
        ['Toggl Track'] = { screen = 1, space = 4, position = p.one_6 },

        ['Code'] = { screen = 1, space = 2, position = p.max },
        ['Safari'] = { screen = 1, space = 1, position = p.max },
        ['Firefox'] = { screen = 1, space = 1, position = p.max }
    }

    arrange(apps)

end

function F()
    local app = hs.application.frontmostApplication()
    app:kill9()
end

hyper.bindKey('d', desktop)
hyper.bindKey('g', gameDev)
hyper.bindKey('e', mobile)
hyper.bindKey('f', F)
