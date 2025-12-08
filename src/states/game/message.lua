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
    , c1 = COLOR.SHADOW
    , c2 = self.c
    , c3 = COLOR.ABSWHITE
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
    , c1 = COLOR.SHADOW
    , c2 = COLOR.ORANGE
    , c3 = COLOR.ABSWHITE
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