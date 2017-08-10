
local Task = require 'lux.class' :new{}

local coroutine = coroutine
local debug     = debug
local error     = error
local table     = table
local type      = type

function Task:instance (obj, func, ...)

  setfenv(1, obj)

  local function bootstrap (...)
    coroutine.yield()
    return func(...)
  end

  local task = coroutine.create(bootstrap)
  local delay = 0
  local onhold = false
  local params = {}

  coroutine.resume(task, ...)

  function hold ()
    onhold = true
  end

  function release (...)
    onhold = false
    params = table.pack(...)
  end

  function resume ()
    if coroutine.status(task) == 'dead' then
      return false
    elseif delay > 0 then
      delay = delay - 1
    elseif not onhold then
      local check, result = coroutine.resume(task,
                                             table.unpack(params, 1, params.n))
      if not check then
        error(debug.traceback(task, result))
      end
      params = {}
      if type(result) == 'number' then
        delay = result
      end
    end
    return true
  end

end

return Task
