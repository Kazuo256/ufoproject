
local gui   = class.package 'ufo.gui'
local sprite  = class.package 'ufo.gui.sprite'

function sprite:BatchElement (_name)
  
  gui.Element:inherit(self, _name, vec2:new{}, vec2:new{1024, 768})

  local sprites = {}

  function self:putSprite (pos, sprite)
    sprites[sprite] = pos
  end

  function self:draw (graphics)
    for sprite,pos in pairs(sprites) do
      sprite:draw(graphics, pos)
    end
  end

end
