
local gui     = pack 'ufo.gui'
local sprite  = pack 'ufo.gui.sprite'

local BatchElement = require 'lux.class' :new{}

BatchElement:inherit(gui.Element)

function BatchElement:instance (obj, _name)
  
  self:super(obj, _name, vec2:new{}, vec2:new{1024, 768})

  local sprites = {}

  local function comp (lhs, rhs)
    return sprites[lhs].z < sprites[rhs].z
  end

  function obj:putSprite (pos, sprite)
    sprites[sprite] = pos
  end

  function obj:removeSprite (sprite)
    sprites[sprite] = nil
  end

  function obj:draw (graphics)
    local order = {}
    for sprite,pos in pairs(sprites) do
      table.insert(order, sprite)
    end
    table.sort(order, comp)
    for _,sprite in ipairs(order) do
      sprite:draw(graphics, sprites[sprite])
    end
  end

end

return BatchElement
