
local gui = class.package 'ufo.gui'

function gui:Sprite (atlas)

  local frame = 1
  local size = vec2:new{1,1}

  function self:setFrame (new_frame)
    frame = new_frame
  end

  function self:setSize (new_size)
    size = new_size:clone()
  end
  
  function self:draw (graphics, pos)
    atlas:draw(graphics, frame, pos, size)
  end

end
