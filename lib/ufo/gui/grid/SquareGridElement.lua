
local class = require 'lux.oo.class' 
local vec2  = require 'lux.geom.Vector'

local gui   = class.package 'ufo.gui'
local grid  = class.package 'ufo.gui.grid'

function grid:SquareGridElement (tile_size, _name)
  
  gui.Element:inherit(self, _name, vec2:new{}, vec2:new{1024, 768})

  local grid_descriptor

  function self:setGridDescriptor (descriptor)
    grid_descriptor = descriptor
  end

  function self:draw (graphics)
    if grid_descriptor then
      for pos, tiletype, stack in grid_descriptor:eachPosition() do
        local i, j = pos.i, pos.j
        local t = (i + j) % 2
        graphics.setColor(100, 100 + t*50, 100 + t*50, 255)
        graphics.rectangle('fill', (j-1)*tile_size, (i-1)*tile_size,
                           tile_size, tile_size)
      end
    end
  end

end
