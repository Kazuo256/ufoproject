
local Event = require 'ufo.Event'
local Task  = require 'ufo.Task'
local Queue = require 'lux.common.Queue'

local coroutine = coroutine
local ipairs    = ipairs
local pairs     = pairs
local select    = select
local table     = table
local type      = type

local Activity = require 'lux.class' :new{}

function Activity:instance (obj)

  setfenv(1, obj)

  local QUEUE_MAX_SIZE = 32

  local finished = false
  local scheduled = {}
  local in_queue, out_queue = Queue(QUEUE_MAX_SIZE), Queue(QUEUE_MAX_SIZE)
  local tasks = {}
  local new_tasks, finished_tasks = {}, {}

  __accept = {}
  __task   = {}
  local current_task

  -- Generic stuff

  function isFinished ()
    return finished
  end

  function finish ()
    finished = true
  end

  function switch (...)
    for i = 1,select('#', ...) do
      table.insert(scheduled, (select(i, ...)))
    end
    finished = true
  end

  function getScheduled ()
    return scheduled
  end

  -- Event stuff

  function pollEvents ()
    return function () return out_queue.pop(1) end
  end

  function sendEvent (id)
    return function (...)
      out_queue.push(Event(id, ...))
    end
  end

  function receiveEvent (ev)
    in_queue.push(ev)
  end

  function processEvents ()
    for ev in (function () return in_queue.pop(1) end) do
      if finished then return end
      local callback = __accept[ev.getID()]
      if callback then
        callback(ev.getArgs())
      end
    end
  end

  -- Task stuff

  function yield (opt, ...)
    if type(opt) == 'string' then
      local task = current_task
      task.hold()
      __accept[opt] = function (...)
        task.release(...)
        __accept[opt] = nil
      end
    end
    return coroutine.yield(opt, ...)
  end

  function currentTask ()
    return current_task
  end

  function addTask (name, ...)
    local task = Task(__task[name], ...)
    table.insert(new_tasks, task)
  end

  function updateTasks ()
    for _,task in ipairs(new_tasks) do
      tasks[task] = true
    end
    new_tasks = {}
    for task,_ in pairs(tasks) do
      if finished then return end
      current_task = task
      if not task.resume() then
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
