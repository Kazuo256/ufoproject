
local class   = require 'lux.oo.class'

local sprite  = class.package 'ufo.gui.sprite'
local assets  = class.package 'assets.sprites'

function sprite:ProceduralLoader ()
  
  sprite.Loader:inherit(self)

  local cache = {}

  local function getCached (descriptor)
    local sprite = cache[descriptor]
    if not sprite then
      sprite = assets[descriptor:getName()](descriptor)
      cache[descriptor] = sprite
    end
    return sprite
  end

  function self:load (descriptor)
    return getCached(descriptor)
  end

end

