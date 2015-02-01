
local core = require 'lux.oo.class' .package 'ufo.core'

function core:Event (id, ...)

  local args = { n = select('#', ...), ... }

  function self:getID ()
    return id
  end

  function self:getArgs ()
    return unpack(args, 1, args.n)
  end

end
