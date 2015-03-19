
local grid = class.package 'ufo.gui.grid'

function grid:FixedTileSet (image, tile_size)
  
  local quads = {}

  do -- preload quads
  
    local w, h = image:getDimensions()
    local n = math.floor(h/tile_size)
    local m = math.floor(w/tile_size)
    local newQuad = love.graphics.newQuad

    for i=1,n do
      for j=1,m do
        local x, y = (j-1)*tile_size, (i-1)*tile_size
        table.insert(quads, newQuad(x, y, tile_size, tile_size, w, h))
      end
    end

  end

  function self:getTileSize ()
    return tile_size
  end

  function self:draw (graphics, index, pos)
    graphics.draw(image, quads[index], pos.x, pos.y)
  end

end
