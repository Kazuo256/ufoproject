
local gui     = pack 'ufo.gui'
local Element = require 'lux.class' :new{}

local id = 0

function Element:instance (obj, name, pos, size)

  if not name then
    name = "Generated-"..id
    id = id + 1
  end
  pos = pos or vec2:new{0, 0}
  size = size or vec2:new{32, 32}

  local visible = true

  function obj:getName ()
    return name
  end

  function obj:isVisible ()
    return visible
  end

  function obj:getPos ()
    return pos:clone()
  end

  function obj:getX ()
    return pos.x
  end

  function obj:getY ()
    return pos.y
  end

  function obj:setPos (x, y)
    if type(x) == 'number' then
      pos = vec2:new{x,y}
    else
      pos = x:clone()
    end
  end

  function obj:getSize ()
    return size:clone()
  end

  function obj:getWidth ()
    return size.x
  end

  function obj:getHeight ()
    return size.y
  end

  function obj:setSize (w, h)
    if type(w) == 'number' then
      size = vec2:new{w,h}
    else
      size = w:clone()
    end
  end

  function obj:left ()
    return pos.x
  end

  function obj:right ()
    return pos.x + size.x
  end

  function obj:top ()
    return pos.y
  end

  function obj:bottom ()
    return pos.y + size.y
  end

  function obj:intersects (point)
    if point.x < self:left() or
       point.y < self:top() or
       point.x > self:right() or
       point.y > self:bottom() then
      return false
    else
      return true
    end
  end

  function obj:draw (graphics, window)
    graphics.setColor(220, 80, 80, 255)
    graphics.rectangle('fill', pos.x, pos.y, size.x, size.y)
  end

  function obj:onRefresh ()
    -- abstract method
  end

  function obj:onMousePressed (point, button)
    -- abstract method
  end

  function obj:onMouseReleased (point, button)
    -- abstract method
  end

  function obj:onMouseHover (point, mouse)
    -- abstract method
  end

  function obj:onKeyPressed (key)
    -- abstract method
  end

  function obj:onKeyReleased (key)
    -- abstract method
  end

  function obj:onGamePadButtonPressed (button)
    -- abstract method
  end

  function obj:onGamePadHatChanged (hat, dir)
    -- abstract method
  end

end

return Element
