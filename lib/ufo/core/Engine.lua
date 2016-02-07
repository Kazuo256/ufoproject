
local Engine  = require 'lux.class' :new{}

local Event   = require 'Event'

local assert        = assert
local ipairs        = ipairs
local pairs         = pairs
local setmetatable  = setmetatable
local require       = require
local table         = table
local noop          = function () end

function Engine:instance (_ENV)
  
  local activities = {}
  
  --[[ Activity management ]]---------------------------------------------------
  do

    local function removeActivity (index)
      local activity = activities[index]
      table.remove(activities, index)
      return activity
    end

    function addActivity (activity, i)
      i = i or #activities+1
      table.insert(activities, i, activity)
      activity.receiveEvent(Event("Load", _ENV))
    end

    function tick ()
      if #activities == 0 then
        return 'FINISHED'
      end
      local finished = {}
      for i,activity in ipairs(activities) do
        activity.processEvents()
        activity.updateTasks()
        for ev in activity.pollEvents() do
          broadcastEvent(ev)
        end
        if activity.isFinished() then
          table.insert(finished, i)
        end
      end
      for k=#finished,1,-1 do
        local removed = removeActivity(finished[k])
        local scheduled = removed.getScheduled()
        for i = #scheduled,1,-1 do
          addActivity(scheduled[i], finished[k])
        end
      end
      return 'OK'
    end

  end

  --[[ Event management ]]------------------------------------------------------
  do
  
    local hooks = setmetatable({}, { __index = function () return noop end })

    function broadcastEvent (ev)
      for _,activity in ipairs(activities) do
        activity.receiveEvent(ev)
      end
    end

    function setEventHook (hook_name, event_id, param_transfer)
      if not event_id then
        hooks[hook_name] = nil
      else
        param_transfer = param_transfer or noop
        hooks[hook_name] = function (...)
          return broadcastEvent(Event(event_id, param_transfer(...)))
        end
      end
    end

    function triggerHook (hook_name, ...)
      return hooks[hook_name](...)
    end

  end

  --[[ Infra servers management ]]----------------------------------------------

  do

    local servers = {}

    function loadServer (name)
      assert(not servers[name], "Server already loaded")
      local server = require("infra."..name.."Server") ()
      servers[name] = server
      return server
    end

    function server (name)
      return servers[name]
    end

    function refreshServers (dt)
      for _,server in pairs(servers) do
        server.refresh(dt)
      end
    end

    function shutdownServers ()
      for _,server in pairs(servers) do
        server.shutdown()
      end
    end

  end  

  --[[ Layout management (deprecated?) ]]---------------------------------------
  do

    local layout

    function getLayout ()
       return layout
     end

    function setLayout(new_layout)
      layout = new_layout
    end

  end

end

return Engine
