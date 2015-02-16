
local gui   = class.package 'ufo.gui'
local sprite  = class.package 'ufo.gui.sprite'

function sprite:BatchElement (_name, sprite_loader)
  
  gui.Element:inherit(self, _name, vec2:new{}, vec2:new{1024, 768})

  local descriptors = {}

  function self:addSprite (descriptor)
    table.insert(descriptors, descriptor)
  end

  function self:draw (graphics)
    for _,descriptor in ipairs(descriptors) do
      local sprite = sprite_loader:load(descriptor)
      sprite:draw(graphics, descriptor:getPos())
    end
  end

end
