
local gui       = class.package 'ufo.gui'
local primitive = class.package 'ufo.gui.primitive'

function primitive:Image (img, hotspot)

  gui.Primitive:inherit(self, graphics)

  hotspot = hotspot or vec2:new{}
  
  function self:draw (graphics, pos)
    graphics.setColor(255, 255, 255, 255)
    graphics.draw(img, pos.x, pos.y, 0, 1, 1, hotspot.x, hotspot.y)
  end

end
