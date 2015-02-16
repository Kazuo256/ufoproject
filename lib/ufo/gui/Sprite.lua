
local class = require 'lux.oo.class'

local gui = class.package 'ufo.gui'

function gui:Sprite (descriptor)

  function self:onRefresh ()
    -- optional method
  end
  
  function self:draw (graphics, pos)
    error "Unimplemented method Sprite:draw"
  end

end
