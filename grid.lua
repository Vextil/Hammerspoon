-----------------------------------------------------------------------------------
-- File: grid.lua
-- Author: Joaquín Cuitiño
-- License: MIT
-----------------------------------------------------------------------------------

-- To easily layout windows on the screen, we use hs.grid to create a 6x6 grid.
local GRID_SIZE = 6
local HALF_GRID_SIZE = GRID_SIZE / 2

-- Set the grid size and configure margins.
-- Also, don"t animate window changes... That"s too slow.
hs.grid.setGrid(GRID_SIZE .. "x" .. GRID_SIZE)
hs.grid.setMargins({0, 0})
hs.window.animationDuration = 0

-- Define useful pre-defined positions for the grid.
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

return p