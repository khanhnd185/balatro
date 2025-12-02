
StartState = Class{__includes = BaseState}

function StartState:init()
  -- gSounds['opening']:play()
  self.x  = VW/2-48
  self.y  = 300
  self.scale    = 1.0
end

function StartState:update(dt)
  if love.keyboard.wasPressed('p') then
    gStateStack:pop()
    gStateStack:push(RunState())
    gStateStack:push(SelectState(gStateStack.states[#gStateStack.states]))
  end
end

function StartState:render()
  love.graphics.setColor(1,1,1,1)
  love.graphics.setFont(gFonts['xlarge'])
  love.graphics.printf('Press P to Play',0,VH-64,VW,'center')
  love.graphics.setFont(gFonts['medium'])
end