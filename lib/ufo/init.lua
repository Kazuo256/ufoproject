
package.path = package.path .. ";./game/lib/?.lua;./lib/?.lua"

local FRAME = 1/60

-- These appear in pratically every file, so let's make them global.
vec2 = require 'lux.geom.Vector'
pack = require 'lux.pack'

-- Lua 5.X compatibility
require 'lux.portable'

local core  = pack 'ufo.core'
local gui   = pack 'ufo.gui'

local engine
local layout

function love.load ()
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

function love.keypressed (key)
  layout:keyboardAction('Pressed', key)
end

function love.mousepressed (x, y, button)
  layout:mouseAction('Pressed', vec2:new{x,y}, button)
end

function love.mousereleased (x, y, button)
  layout:mouseAction('Released', vec2:new{x,y}, button)
end

function love.joystickpressed (joystick, button)
  layout:joystickAction('ButtonPressed', button)
end

function love.joystickhat (joystick, hat, dir)
  layout:joystickAction('HatChanged', hat, dir)
end

function love.draw ()
  layout:draw(love.graphics, love.window)
end

