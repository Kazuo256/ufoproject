
local class   = require 'lux.oo.class'

local sprite  = class.package 'ufo.gui.sprite'
local Queue   = class.package 'ufo.core' .Queue

function sprite:Descriptor ()

  local queue = Queue(16)

  function self:setProperty (property, value)
    queue:push {property, value}
  end

  function self:eachProperty ()
    return queue:popEach()
  end
  
  function self:getPos ()
    error ("Unimplemented method 'SpriteDescriptor:getPos'")
  end

  function self:getDepth ()
    error ("Unimplemented method 'SpriteDescriptor:getDepth'")
  end

  function self:getName ()
    error ("Unimplemented method 'SpriteDescriptor:getName'")
  end

end
