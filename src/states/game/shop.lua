ShopState = Class{__includes = BaseState}

function ShopState:init(run, n)
  self.run = run
  local X = 384
  local Y = 40
  local W = 720
  local H = 640
  self.window  = ShadowTextBox({
      x = X
    , y = Y
    , w = W
    , h = H
    , c1 = {r=25, g=25, b=25}
    -- , c2 = {r=94, g=121, b=119}
    , c2 = {r=113, g=141, b=191}
    , c3 = {r=255, g=255, b=255}
    , size = 'large'
    , dx = 80
    , dy = 8
  })

  local w = 140
  local h = 40
  self.sel_box = ShadowTextBox({
      x = X+(W-w)/2
    , y = Y+H-h*2-16
    , w = w
    , h = h
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=234, g=150, b=0}
    , c3 = {r=255, g=255, b=255}
    , size = 'xmedium'
    , dx = 4
    , dy = 4
  })
  self.back_box = ShadowTextBox({
      x = X+(W-w)/2
    , y = Y+H-h-8
    , w = w
    , h = h
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=234, g=150, b=0}
    , c3 = {r=255, g=255, b=255}
    , size = 'xmedium'
    , dx = 4
    , dy = 4
  })

  local dx=150
  local x = 100
  local y = 120
  self.jokers = {}
  self.pricetags = {}
  for i=1,n do
    table.insert(self.jokers, Joker({
        id=math.random(2)
      , run=run
      , x=X+x+(i-1)*dx
      , y=Y+y
    }))
    table.insert(self.pricetags, Text({
        x = X+x+(i-1)*dx+CARDW/2-12
      , y = Y+y+CARDH+8
      , c = {r=245, g=166, b=0}
      , size = 'xmedium'
    }))
  end
  self.pointer = HorizontalPointer({
      x     = X+x+CARDW/2
    , y     = Y+y-8
    , dx    = dx
    , dy    = 0
    , size  = 24
    , color = {r=79, g=99, b=103}
  })

end

function ShopState:update(dt)
  if love.keyboard.wasPressed('x') then
    gStateStack:pop()
  elseif love.keyboard.wasPressed('a') and self.pointer and self.pointer.pos>1 then
    self.pointer:left()
  elseif love.keyboard.wasPressed('d') and self.pointer and self.pointer.pos<#self.jokers then
    self.pointer:right()
  elseif self.pointer and love.keyboard.wasPressed('z') then
    if self.run.money<self.jokers[self.pointer.pos].price then
      gStateStack:push(MessageState({
          msg = 'Ur broke!'
        , yes = 'OK(z)'
        , x = 575
        , y = 300
        , w = 300
        , h = 200
        , c = {r=0, g=129, b=211}
      }))
    else
      self.run:buy(self.jokers[self.pointer.pos])
      gStateStack:pop()
      gStateStack:push(SelectState(gStateStack.states[1]))
    end
  end
end

function ShopState:render()
  if self.pointer then
    self.window:render('Shop')
    self.pointer:render()
    self.sel_box:render('Select (z)')
  else
    self.window:render('Run Info')
  end
  for i=1,#self.jokers do
    self.jokers[i]:render()
    self.pricetags[i]:render('$' .. tostring(self.jokers[i].price))
  end
  self.back_box:render('Back (x)')
end
