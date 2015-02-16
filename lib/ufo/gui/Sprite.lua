
local gui = class.package 'ufo.gui'

function gui:Sprite (primitive, descriptor)

  function self:onRefresh ()
    primitive:onRefresh()
    for property, value in descriptor:eachProperty() do
      primitive:setProperty(property, value)
    end
  end
  
  function self:draw (graphics, pos)
    primitive:draw(graphics, pos)
  end

end
