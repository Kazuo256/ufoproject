
local gui     = class.package 'ufo.gui'
local sprite  = class.package 'ufo.gui.sprite'
local assets  = class.package 'assets.sprites'

local PATH = "assets/sprites/%s.lua"

function sprite:ProceduralLoader ()
  
  sprite.Loader:inherit(self)

  local cache = {}

  local function pathTo (name)
    return PATH:format(name)
  end

  local function getCached (descriptor)
    local sprite = cache[name]
    if not sprite then
      local name = descriptor:getName()
      local ok, script = pcall(love.filesystem.load, pathTo(name))
      assert(ok, "Failed to load asset '"..name.."'")
      sprite = gui.Sprite(script(), descriptor)
      cache[name] = sprite
    end
    return sprite
  end

  function self:load (descriptor)
    return getCached(descriptor)
  end

end

