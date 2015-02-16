
local class   = require 'lux.oo.class'

local sprite  = class.package 'ufo.gui.sprite'

function sprite:Descriptor ()
  
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
