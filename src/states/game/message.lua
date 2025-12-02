MessageState = Class{__includes = BaseState}

function MessageState:init(def)
  self.msg = def.msg
  self.yes = def.yes
  self.x   = def.x
  self.y   = def.y
  self.w   = def.w
  self.h   = def.h
  self.c   = def.c
  self.next_state = def.next_state

  self.box = ShadowTextBox({
      x = self.x
    , y = self.y
    , w = self.w
    , h = self.h
    , c1 = {r=25, g=25, b=25}
    , c2 = self.c
    , c3 = {r=255, g=255, b=255}
    , size = 'xlarge'
    , dx = 8
    , dy = 8
  })

  local w = 80
  local h = 32
  self.but = ShadowTextBox({
      x = self.x+(self.w-w)/2
    , y = self.y+self.h-h-8
    , w = w
    , h = h
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=234, g=150, b=0}
    , c3 = {r=255, g=255, b=255}
    , size = 'xmedium'
    , dx = 4
    , dy = 4
  })
end

function MessageState:update(dt)
  if love.keyboard.wasPressed('z') then
    gStateStack:pop()
    if self.next_state then
      gStateStack:push(self.next_state)
    end
  end
end

function MessageState:render()
  self.box:render(self.msg)
  self.but:render(self.yes)
end