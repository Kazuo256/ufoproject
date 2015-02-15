
local class = require 'lux.oo.class'

local core  = class.package 'ufo.core'

function core:Engine ()
  
  local activities = {}
  local layout

  local function removeActivity (index)
    local activity = activities[index]
    table.remove(activities, index)
    return activity
  end

  function self:addActivity (activity, i)
    i = i or #activities+1
    table.insert(activities, i, activity)
    activity:receiveEvent(core.Event("Load", self))
  end

  function self:broadcastEvent (ev)
    for _,activity in ipairs(activities) do
      activity:receiveEvent(ev)
    end
  end

  function self:getLayout ()
     return layout
   end

  function self:setLayout(new_layout)
    layout = new_layout
  end

  function self:tick ()
    if #activities == 0 then
      return 'FINISHED'
    end
    local finished = {}
    for i,activity in ipairs(activities) do
      activity:processEvents()
      activity:updateTasks()
      for ev in activity:pollEvents() do
        self:broadcastEvent(ev)
      end
      if activity:isFinished() then
        table.insert(finished, i)
      end
    end
    for k=#finished,1,-1 do
      local removed = removeActivity(finished[k])
      local scheduled = removed:getScheduled()
      for i = #scheduled,1,-1 do
        self:addActivity(scheduled[i], finished[k])
      end
    end
    return 'OK'
  end

end
