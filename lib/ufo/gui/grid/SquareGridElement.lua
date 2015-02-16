
local gui   = class.package 'ufo.gui'
local grid  = class.package 'ufo.gui.grid'

function grid:SquareGridElement (_name, tile_size, num, sprite_loader)
  
  gui.Element:inherit(self, _name, vec2:new{}, num*tile_size*vec2:new{1, 1})

  local grid_descriptor
  local focus = { i = 1, j = 1 }
  local tiles = {}

  local function isTileVisible (i, j)
    return self:intersects(tile_size*vec2:new{j-.5, i-.5})
  end

  function self:setFocus (i, j)
    focus.i = math.ceil(i - num/2)
    focus.j = math.ceil(j - num/2)
  end

  function self:setGridDescriptor (descriptor)
    grid_descriptor = descriptor
  end

  function self:onRefresh ()
    tiles = {}
    if grid_descriptor then
      self:setFocus(grid_descriptor:getFocus())
      for pos, tiletype, stack in grid_descriptor:eachPosition() do
        if pos.i >= focus.i and pos.i <= focus.i + num
           and pos.j >= focus.j and pos.j <= focus.j + num then
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

  function self:draw (graphics)
    for _,tile in ipairs(tiles) do
      local pos, tiletype, stack = unpack(tile)
      local i, j = pos.i, pos.j
      if isTileVisible(i, j) then
        local t = (i + j) % 2
        graphics.setColor(100, 100 + t*50, 100 + t*50, 255)
        graphics.rectangle('fill', (j-1)*tile_size, (i-1)*tile_size,
                           tile_size, tile_size)
        for k,descriptor in ipairs(stack) do
          local sprite = sprite_loader:load(descriptor)
          sprite:draw(graphics, tile_size*vec2:new{j-.5, i-.5})
        end
      end
    end
  end

end
