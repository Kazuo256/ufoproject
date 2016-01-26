
local GraphicsServer = class:new{}

local noop = function () end

function GraphicsServer:instance (obj)
  
  local steps = {}
  local enabled = {}
  local graphics = love.graphics

  function obj:resetSteps (n)
    steps = {}
    enabled = {}
    for i=1,n do
      steps[i] = noop
      enabled[i] = false
    end
  end

  function obj:setStep (i, step_name, enable)
    assert(i >= 1 and i <= #steps, "Invalid step index")
    steps[i] = loadResource('drawstep', step_name)
    enabled[i] = enable or false
  end

  function obj:enableStep (i)
    assert(i >= 1 and i <= #steps, "Invalid step index")
    enabled[i] = true
  end

  function obj:disableStep (i)
    assert(i >= 1 and i <= #steps, "Invalid step index")
    enabled[i] = false
  end

  function obj:refresh (dt)
    -- Nothing for now
  end

  function obj:drawAll ()
    for i,step in ipairs(steps) do
      if enabled[i] then
        graphics.reset()
        step(graphics)
      end
    end
  end

end

return GraphicsServer
