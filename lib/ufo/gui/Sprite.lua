
local gui = class.package 'ufo.gui'

function gui:Sprite (primitive, descriptor)

  function self:onRefresh ()
    
  end
  
  function self:draw (graphics, pos)
    primitive:draw(graphics, pos)
  end

end
