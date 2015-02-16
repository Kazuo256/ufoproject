
local gui = class.package 'ufo.gui'

function gui:Primitive (graphics)
  
  local properties = {}

  function self:onRefresh ()
    -- optional method
  end

  function self:setProperty (property, value)
    properties[property] = value
  end

  function self:getProperty (property, ...)
    if property or select('#', ...) > 0 then
      return properties[property], self:getProperty(...)
    end
  end

  function self:draw (pos)
    error "Unimplemented method Primitive:draw"
  end

end
