
local Event = require 'lux.class' :new{}

local table = table

function Event:instance (_ENV, id, ...)

  local args = table.pack(...)

  function getID ()
    return id
  end

  function getArgs ()
    return table.unpack(args, 1, args.n)
  end

end

return Event
