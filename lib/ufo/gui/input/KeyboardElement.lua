
local lambda  = require 'lux.functional'
local Event   = require 'ufo.core.Event'
local Element = require 'ufo.gui.Element'

local KeyboardElement = require 'lux.class' :new{}

KeyboardElement:inherit(Element)

function KeyboardElement:instance (obj, _name, engine)

  self:super(obj, _name, vec2:new{}, vec2:new{1024, 768})

  local key_bindings = {}

  function obj:bindKey (key, event, ...)
    key_bindings[key] = lambda.bindLeft(Event, event, ...)
  end

  function obj:onKeyPressed (key)
    local event = key_bindings[key]
    if event then
      engine:broadcastEvent(event())
    end
  end

  function obj:draw (graphics)
    -- draws nothing (maybe debug info)
  end

end

return KeyboardElement
