
local Event = require 'lux.class' :new{}

function Event:instance (obj, id, ...)

  local args = table.pack(...)

  function obj:getID ()
    return id
  end

  function obj:getArgs ()
    return table.unpack(args, 1, args.n)
  end

end

return Event
