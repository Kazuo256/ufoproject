
local Event = require 'lux.class' :new{}

local table = table

function Event:instance (obj, id, ...)

  setfenv(1, obj)

  local args = table.pack(...)

  function getID ()
    return id
  end

  function getArgs ()
    return table.unpack(args, 1, args.n)
  end

end

return Event
