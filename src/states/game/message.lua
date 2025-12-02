MessageState = Class{__includes = BaseState}

function MessageState:init(def)
  self.msg = def.msg
  self.yes = def.yes
  self.x   = def.x
  self.y   = def.y
  self.w   = def.w
  self.h   = def.h
  self.c   = def.c
end

function MessageState:update(dt)
  if love.keyboard.wasPressed('z') then
    gStateStack:pop()
  end
end

function MessageState:render()

end