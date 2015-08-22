
local core = pack 'ufo.core'

local Event = core.Event
local Task  = core.Task
local Queue = require 'lux.struct.Queue'

local Activity = require 'lux.class' :new{}

function Activity:instance (obj)

  local QUEUE_MAX_SIZE = 32

  local finished = false
  local scheduled = {}
  local in_queue, out_queue = Queue(QUEUE_MAX_SIZE), Queue(QUEUE_MAX_SIZE)
  local tasks = {}
  local new_tasks, finished_tasks = {}, {}

  obj.__accept = {}
  obj.__task   = {}
  local current_task

  -- Generic stuff

  function obj:isFinished ()
    return finished
  end

  function obj:finish ()
    finished = true
  end

  function obj:switch (...)
    for i = 1,select('#', ...) do
      table.insert(scheduled, (select(i, ...)))
    end
    finished = true
  end

  function obj:getScheduled ()
    return scheduled
  end

  -- Event stuff

  function obj:pollEvents ()
    return out_queue:popEach()
  end

  function obj:sendEvent (id)
    return function (...)
      out_queue:push(Event(id, ...))
    end
  end

  function obj:receiveEvent (ev)
    in_queue:push(ev)
  end

  function obj:processEvents ()
    for ev in in_queue:popEach() do
      if finished then return end
      local callback = self.__accept[ev:getID()]
      if callback then
        callback(self, ev.getArgs())
      end
    end
  end

  -- Task stuff

  function obj:yield (opt, ...)
    if type(opt) == 'string' then
      local task = current_task
      task:hold()
      self.__accept[opt] = function (self, ...)
        task:release(...)
        self.__accept[opt] = nil
      end
    end
    return coroutine.yield(opt, ...)
  end

  function obj:currentTask ()
    return current_task
  end

  function obj:addTask (name, ...)
    local task = Task(self.__task[name], self, ...)
    table.insert(new_tasks, task)
  end

  function obj:updateTasks ()
    for _,task in ipairs(new_tasks) do
      tasks[task] = true
    end
    for task,_ in pairs(tasks) do
      if finished then return end
      current_task = task
      if not task:resume() then
        table.insert(finished_tasks, task)
      end
      current_task = nil
    end
    for _,task in ipairs(finished_tasks) do
      tasks[task] = nil
    end
  end

end

return Activity
