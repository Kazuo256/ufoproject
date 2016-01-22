
package.path =
  package.path .. ";./game/lib/?.lua;./lib/?.lua;./lib/ufo/core/?.lua"

local FRAME = 1/60

-- These appear in pratically every file, so let's make them global.
prototype = require 'lux.prototype'
class     = require 'lux.class'
vec2      = require 'lux.geom.Vector'
pack      = require 'lux.pack'

-- Lua 5.X compatibility
require 'lux.portable'

local core  = pack 'ufo.core'
local gui   = pack 'ufo.gui'

local engine
local layout

function love.load (arg)
  engine = core.Engine()
  layout = gui.Layout()
  engine:setLayout(layout)
  local activities = pack 'activities'
  engine:addActivity(activities.BootstrapActivity())
end

do
  local lag = 0
  function love.update (dt)
    lag = lag + dt
    while lag >= FRAME do
      if engine:tick() == 'FINISHED' then
        love.event.push 'quit'
      end
      lag = lag - FRAME
    end
    layout:refresh()
  end
end

for k,handler in pairs(love.handlers) do
  if k ~= 'quit' then
    love[k] = function (...)
      return engine:triggerHook(k, ...)
    end
  end
end

function love.draw ()
  layout:draw(love.graphics, love.window)
  local gfxserver = engine:server "Graphics"
  if gfxserver then
    gfxserver:drawAll()
  end
end

