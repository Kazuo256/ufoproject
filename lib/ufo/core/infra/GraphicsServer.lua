
local GraphicsServer = class:new{}

local assert   = assert
local ipairs   = ipairs
local graphics = love.graphics
local noop = function () end

function GraphicsServer:instance (obj)
  
  local steps = {}
  local enabled = {}

  function resetSteps (n)
    steps = {}
    enabled = {}
    for i=1,n do
      steps[i] = noop
      enabled[i] = false
    end
  end

  function setStep (i, step_name, enable)
    assert(i >= 1 and i <= #steps, "Invalid step index")
    steps[i] = loadResource('drawstep', step_name)
    enabled[i] = enable or false
  end

  function enableStep (i)
    assert(i >= 1 and i <= #steps, "Invalid step index")
    enabled[i] = true
  end

  function disableStep (i)
    assert(i >= 1 and i <= #steps, "Invalid step index")
    enabled[i] = false
  end

  function refresh (dt)
    for i,step in ipairs(steps) do
      if enabled[i] then
        step.update(dt)
      end
    end
  end

  function shutdown ()
    -- Does nothing?
  end

  function drawAll (engine)
    for i,step in ipairs(steps) do
      if enabled[i] then
        graphics.reset()
        step.draw(graphics, engine)
      end
    end
  end

end

return GraphicsServer
