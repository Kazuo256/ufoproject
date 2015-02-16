
local gui       = class.package 'ufo.gui'
local primitive = class.package 'ufo.gui.primitive'

function primitive:Text (width, font, format, hotspot)

  gui.Primitive:inherit(self)

  assert(width)
  hotspot = hotspot or vec2:new{}
  font = font or love.graphics.newFont(16)
  format = format or 'center'

  function self:draw (graphics, pos)
    graphics.setColor(0, 0, 0, 255)
    local text = self:getProperty('text') or "?"
    local oldfont = graphics.getFont()
    graphics.setFont(font)
    graphics.printf(text, pos.x - hotspot.x, pos.y - hotspot.y, width, format)
    graphics.setColor(255, 255, 255, 255)
    graphics.setFont(oldfont)
  end

end
