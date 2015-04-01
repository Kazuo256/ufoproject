
local gui   = class.package 'ufo.gui'
local grid  = class.package 'ufo.gui.grid'

function grid:SquareGridElement (_name, tile_num, tile_size, atlas)
  
  gui.Element:inherit(self, _name, vec2:new{},
                      tile_num*tile_size*vec2:new{1, 1})

  local tiles = {}

  for i=1,tile_num do
    for j=1,tile_num do
      table.insert(tiles, { i = i, j = j, content = {} })
    end
  end

  local function toIndex (i, j)
    return (i-1)*tile_num + j
  end

  local function isTileVisible (i, j)
    return self:intersects(self:getPos() + tile_size*vec2:new{j-.5, i-.5})
  end

  function self:set (i, j, ...)
    local index = toIndex(i,j)
    assert(index >= 1 and index <= tile_num*tile_num)
    tiles[index].content = { ... }
  end

  function self:draw (graphics)
    for _,tile in ipairs(tiles) do
      local i, j = tile.i, tile.j
      local pos = tile_size*vec2:new{j-.5, i-.5}
      if isTileVisible(i, j) then
        for k,index in ipairs(tile.content) do
          atlas:draw(graphics, index, pos)
        end
      end
    end
  end

end
