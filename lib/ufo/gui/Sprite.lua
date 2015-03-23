
local gui = class.package 'ufo.gui'

function gui:Sprite (atlas)

  local frame = 1

  function self:setFrame (new_frame)
    frame = new_frame
  end
  
  function self:draw (graphics, pos)
    atlas:draw(graphics, frame, pos)
  end

end
