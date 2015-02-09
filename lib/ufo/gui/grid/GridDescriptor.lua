
local class = require 'lux.oo.class' 
local vec2  = require 'lux.geom.Vector'

local gui   = class.package 'ufo.gui'
local grid  = class.package 'ufo.gui.grid'

local function abstractMethod (name)
  error("Unimplemented abstract method '"..name.."'")
end

function grid:GridDescriptor ()

  function self:describe (pos, tile, stack)
    return coroutine.yield(pos, tile, stack)
  end

  function self:iterate ()
    abstractMethod "iterate"
  end

  function self:eachPosition ()
    local routine = coroutine.create(self.iterate)
    return function ()
      if coroutine.status(routine) ~= 'dead' then
        local check, pos_or_err, tile, stack = coroutine.resume(routine, self)
        assert(check, pos_or_err)
        return pos_or_err, tile, stack
      end
    end
  end

end
