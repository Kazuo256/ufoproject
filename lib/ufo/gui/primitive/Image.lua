
local gui       = class.package 'ufo.gui'
local primitive = class.package 'ufo.gui.primitive'

function primitive:Image (img, hotspot, scale)

  gui.Primitive:inherit(self)

  hotspot = hotspot or vec2:new{}
  scale   = scale or vec2:new{ img:getDimensions() }
  
  function self:draw (graphics, pos)
    graphics.setColor(255, 255, 255, 255)
    graphics.draw(img, pos.x, pos.y, 0, scale.x/img:getWidth(),
                  scale.y/img:getHeight(), hotspot.x, hotspot.y)
  end

end
