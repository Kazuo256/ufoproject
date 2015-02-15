
local class   = require 'lux.oo.class'

local sprite  = class.package 'ufo.gui.sprite'

function sprite:Sprite (img, hotspot)
  
  function self:draw (graphics, pos)
    graphics.draw(img, pos.x, pos.y, 0, 1, 1, hotspot.x, hotspot.y)
  end

end
