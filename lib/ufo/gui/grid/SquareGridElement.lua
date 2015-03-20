
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
    return self:intersects(tile_size*vec2:new{j-.5, i-.5})
  end

  --[[
  function self:onRefresh ()
    tiles = {}
    if grid_descriptor then
      self:setFocus(grid_descriptor:getFocus())
      for pos, tiletype, stack in grid_descriptor:eachPosition() do
        if pos.i >= focus.i and pos.i <= focus.i + tile_num
           and pos.j >= focus.j and pos.j <= focus.j + tile_num then
          table.insert(tiles, {
            {
              i = pos.i - focus.i + 1,
              j = pos.j - focus.j + 1
            },
            tiletype, stack
          })
          for _,descriptor in ipairs(stack) do
            local sprite = sprite_loader:load(descriptor)
            sprite:onRefresh()
          end
        end
      end
    end
  end
  --]]

  function self:set (i, j, ...)
    local index = toIndex(i,j)
    assert(index >= 1 and index <= tile_num*tile_num)
    tiles[index].content = { ... }
  end

  function self:draw (graphics)
    for _,tile in ipairs(tiles) do
      local i, j = tile.i, tile.j
      if isTileVisible(i, j) then
        for k,index in ipairs(tile.content) do
          atlas:draw(graphics, index, tile_size*vec2:new{j-.5, i-.5})
        end
      end
    end
  end

end
