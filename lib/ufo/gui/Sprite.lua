
local gui = class.package 'ufo.gui'

function gui:Sprite (primitive, descriptor)

  function self:onRefresh ()
    primitive:onRefresh()
    for property in descriptor:eachProperty() do
      primitive:setProperty(unpack(property))
    end
  end
  
  function self:draw (graphics, pos)
    primitive:draw(graphics, pos)
  end

end
