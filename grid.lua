-----------------------------------------------------------------------------------
-- File: grid.lua
-- Author: Joaquín Cuitiño
-- License: MIT
-----------------------------------------------------------------------------------

-- To easily layout windows on the screen, we use hs.grid to create a 6x6 grid.
local GRID_SIZE = 18
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
    centerStage_bottomLeft = {
      x = 0, y = HALF_GRID_SIZE,
      w = 6, h = HALF_GRID_SIZE
    },
    centerStage_bottomLeftSidecar = {
      x = 6, y = HALF_GRID_SIZE,
      w = 6, h = HALF_GRID_SIZE
    },
    centerStage_topLeft = {
      x = 0, y = 0,
      w = 6, h = HALF_GRID_SIZE
    },
    centerStage_bottomRight = {
      x = 12, y = HALF_GRID_SIZE,
      w = 6, h = HALF_GRID_SIZE
    },
    centerStage_topRight = {
      x = 12, y = 0,
      w = 6, h = HALF_GRID_SIZE
    },
    centerStage = {
      x = 6, y = 0,
      w = 6, h = GRID_SIZE
    },
}

return p