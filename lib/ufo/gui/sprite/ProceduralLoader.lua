
local class   = require 'lux.oo.class'

local sprite  = class.package 'ufo.gui.sprite'

local PATH = "assets/sprites/%s.lua"

function sprite:ProceduralLoader ()
  
  sprite.SpriteLoader:inherit(self)

  local cache = {}

  local function pathTo (name)
    return PATH:format(name)
  end

  local function getCached (name)
    local script = cache[name]
    if not script then
      local ok
      ok, script = pcall(love.filesystem.load, pathTo(name))
      assert(ok, "Failed to load asset '"..name.."'")
      cache[name] = script
    end
    return script
  end

  function self:load (name)
    return getCached(name) ()
  end

end

