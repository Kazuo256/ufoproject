
local Task = require 'lux.class' :new{}

function Task:instance (obj, func, ...)

  local function bootstrap (...)
    coroutine.yield()
    return func(...)
  end

  local task = coroutine.create(bootstrap)
  local delay = 0
  local onhold = false
  local params = {}

  coroutine.resume(task, ...)

  function obj:hold ()
    onhold = true
  end

  function obj:release (...)
    onhold = false
    params = table.pack(...)
  end

  function obj:resume ()
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
