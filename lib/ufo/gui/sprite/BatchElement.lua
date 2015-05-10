
local gui   = class.package 'ufo.gui'
local sprite  = class.package 'ufo.gui.sprite'

function sprite:BatchElement (_name)
  
  gui.Element:inherit(self, _name, vec2:new{}, vec2:new{1024, 768})

  local sprites = {}

  local function comp (lhs, rhs)
    return sprites[lhs].z < sprites[rhs].z
  end

  function self:putSprite (pos, sprite)
    sprites[sprite] = pos
  end

  function self:removeSprite (sprite)
    sprites[sprite] = nil
  end

  function self:draw (graphics)
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
