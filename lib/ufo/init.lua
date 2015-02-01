

package.path = package.path .. ";./game/lib/?.lua;./lib/?.lua"

local FRAME = 1/60

local class = require 'lux.oo.class'

local core  = class.package 'ufo.core'

local game_ui
local engine

function love.load ()
  engine = core.Engine()
  game_ui = engine.UI()
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
    game_ui:refresh()
  end
end

function love.keypressed (key)
  game_ui:keyboardAction('Pressed', key)
end

function love.mousepressed (x, y, button)
  game_ui:mouseAction('Pressed', vec2:new{x,y}, button)
end

function love.mousereleased (x, y, button)
  game_ui:mouseAction('Released', vec2:new{x,y}, button)
end

function love.draw ()
  game_ui:draw(love.graphics, love.window)
end

