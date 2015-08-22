
local core  = pack 'ufo.core'

local Engine = require 'lux.class' :new{}

function Engine:instance (obj)
  
  local activities = {}
  local layout

  local function removeActivity (index)
    local activity = activities[index]
    table.remove(activities, index)
    return activity
  end

  function obj:addActivity (activity, i)
    i = i or #activities+1
    table.insert(activities, i, activity)
    activity:receiveEvent(core.Event("Load", self))
  end

  function obj:broadcastEvent (ev)
    for _,activity in ipairs(activities) do
      activity:receiveEvent(ev)
    end
  end

  function obj:getLayout ()
     return layout
   end

  function obj:setLayout(new_layout)
    layout = new_layout
  end

  function obj:tick ()
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

return Engine
