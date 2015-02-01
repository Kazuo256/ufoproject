
local class = require 'lux.oo.class' 
local vec2  = require 'lux.geom.Vector'

local gui   = class.package 'ufo.gui'
local grid  = class.package 'ufo.gui.grid'

function grid:SquareGridElement (tile_size, columns, rows, _name)
  
  gui.Element:inherit(self, _name, vec2:new{},
                      vec2:new{columns*tile_size, rows*tile_size})

  function self:draw (graphics)
    for i=1,rows do
      for j=1,columns do
        local t = (i + j) % 2
        graphics.setColor(100, 100 + t*50, 100 + t*50, 255)
        graphics.rectangle('fill', (j-1)*tile_size, (i-1)*tile_size,
                           tile_size, tile_size)
      end
    end
  end

end
