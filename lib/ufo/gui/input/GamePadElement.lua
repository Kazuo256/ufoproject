
local gui             = pack 'ufo.gui'
local Event           = pack 'ufo.core' .Event
local GamePadElement  = require 'lux.class' :new{}

local dirmap = {
  d = 'down',
  l = 'left',
  r = 'right',
  u = 'up'
}

GamePadElement:inherit(gui.Element)

function GamePadElement:instance (obj, _name, engine)

  self:super(obj, _name, vec2:new{}, vec2:new{1024, 768})

  local button_bindings = {}

  function obj:bindButton (button, event)
    button_bindings[button] = event
  end

  function obj:onGamePadHatChanged (hat, dir)
    local id = dirmap[dir]
    if id then
      engine:broadcastEvent(Event('MoveInput', id))
    end
  end

  function obj:onGamePadButtonPressed (button)
    local event = button_bindings[button]
    if event then
      engine:broadcastEvent(Event(event))
    end
  end

  function obj:draw (graphics)
    -- draws nothing (maybe debug info)
  end

end

return GamePadElement
