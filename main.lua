
require 'src/include'

function love.load()
  love.window.setTitle('Balatro')
  love.graphics.setDefaultFilter('nearest', 'nearest')
  math.randomseed(os.time())

  push:setupScreen(VW, VH, WIDTH, HEIGHT, {
    fullscreen = false,
    vsync = true,
    resizable = true
  })

  gStateStack = StateStack()
  gStateStack:push(StartState())

  love.keyboard.keysPressed = {}
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

function love.update(dt)
  Timer.update(dt)
  gStateStack:update(dt)

  love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()
  -- love.graphics.draw(gBackground,0,0,0,0.5,0.5)
  -- love.graphics.clear(69/255, 147/255, 155/255, 1)
  love.graphics.clear(51/255, 68/255, 97/255, 1)
  gStateStack:render()
  push:finish()
end