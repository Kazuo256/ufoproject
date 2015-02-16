
local class   = require 'lux.oo.class'
local vec2    = require 'lux.geom.Vector'

local input   = class.package 'ufo.gui.input'
local Event   = class.package 'ufo.core' .Event
local Element = class.package 'ufo.gui' .Element

local dirmap = {
  d = 'down',
  l = 'left',
  r = 'right',
  u = 'up'
}

function input:GamePadElement (_name, engine)

  Element:inherit(self, _name, vec2:new{}, vec2:new{1024, 768})

  local button_bindings = {}

  function self:bindButton (button, event)
    button_bindings[button] = event
  end

  function self:onGamePadHatChanged (hat, dir)
    local id = dirmap[dir]
    if id then
      engine:broadcastEvent(Event('MoveInput', id))
    end
  end

  function self:onGamePadButtonPressed (button)
    local event = button_bindings[button]
    if event then
      engine:broadcastEvent(Event(event))
    end
  end

  function self:draw (graphics)
    -- draws nothing (maybe debug info)
  end

end
