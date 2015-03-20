
local sprite = class.package 'ufo.gui.sprite'

function sprite:FixedAtlas (image, frame_size, hotspot)
  
  local quads = {}

  hotspot = hotspot or frame_size/2

  do -- preload quads
  
    local w, h = image:getDimensions()
    local n = math.floor(h/frame_size.y)
    local m = math.floor(w/frame_size.x)
    local newQuad = love.graphics.newQuad

    for i=1,n do
      for j=1,m do
        local x, y = (j-1)*frame_size.x, (i-1)*frame_size.y
        table.insert(quads, newQuad(x, y, frame_size.x, frame_size.y, w, h))
      end
    end

  end

  function self:getTileSize ()
    return frame_size:clone()
  end

  function self:draw (graphics, index, pos)
    graphics.draw(image, quads[index], pos.x, pos.y, 0, 1, 1,
                  hotspot.x, hotspot.y)
  end

end
