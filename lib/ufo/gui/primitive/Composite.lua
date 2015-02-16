
local gui       = class.package 'ufo.gui'
local primitive = class.package 'ufo.gui.primitive'

function primitive:Composite ()

  gui.Primitive:inherit(self)

  local children  = {}
  local positions = {}

  function self:setProperty (property, value)
    self:_setProperty(property, value)
    for _,child in ipairs(children) do
      child:setProperty(property, value)
    end
  end

  function self:addChild (pos, child)
    table.insert(children, child)
    positions[child] = pos
  end

  function self:draw (graphics, pos)
    for _,child in ipairs(children) do
      local p = positions[child]
      child:draw(graphics, pos + p)
    end
  end

end
