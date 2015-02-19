
local class   = require 'lux.oo.class'
local vec2    = require 'lux.geom.Vector'
local lambda  = require 'lux.functional'

local input   = class.package 'ufo.gui.input'
local Event   = class.package 'ufo.core' .Event
local Element = class.package 'ufo.gui' .Element

function input:KeyboardElement (_name, engine)

  Element:inherit(self, _name, vec2:new{}, vec2:new{1024, 768})

  local key_bindings = {}

  function self:bindKey (key, event, ...)
    key_bindings[key] = lambda.bindLeft(Event, event, ...)
  end

  function self:onKeyPressed (key)
    local event = key_bindings[key]
    if event then
      engine:broadcastEvent(event())
    end
  end

  function self:draw (graphics)
    -- draws nothing (maybe debug info)
  end

end
