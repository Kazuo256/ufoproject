
local Sprite = require 'lux.class' :new{}

function Sprite:instance (obj, atlas)

  local frame = 1
  local size = vec2:new{1,1}
  local color = vec2:new{1.0, 1.0, 1.0, 1.0}

  function obj:setFrame (new_frame)
    frame = new_frame
  end

  function obj:setSize (w, h)
    if h then
      size = vec2:new{w, h}
    else
      size = w:clone()
    end
  end

  function obj:setColor (r, g, b, a)
    if g then
      color = vec2:new{r, g, b, a}
    else
      color = r:clone()
    end
  end
  
  function obj:draw (graphics, pos)
    graphics.setColor(255*color)
    atlas:draw(graphics, frame, pos, size)
    graphics.setColor(255, 255, 255, 255)
  end

end

return Sprite
