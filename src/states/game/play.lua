
PlayState = Class{__includes = BaseState}

function PlayState:init(run)
  self.run    = run
  self.deck   = Deck()
  self.perm   = self:shuffle()
  self.ncards = N_CARD_HAND
  self.hand   = Hand(self.ncards)
  self.pointer = HorizontalPointer({
      x     = VW/6+1.5*CARDW+10
    , y     = VH-1.5*CARDH-40
    , dx    = CARDW+10
    , dy    = 0
    , size  = 24
    , color = {r=79, g=99, b=103}
  })

  for i=1,self.ncards do
    self:draw()
  end
  self:point()
end

function PlayState:draw()
  self.hand:draw(self.deck.cards[table.remove(self.perm)])
end

function PlayState:point()
  self.hand.hand[self.hand.i].state=CARD_POINTR
end

function PlayState:shuffle()
  local a = {}
  for i = 1,52 do
    a[i] = i
  end

  -- Fisher–Yates shuffle
  for i = 52, 2, -1 do
    local j = math.random(1, i)
    a[i], a[j] = a[j], a[i]
  end
  return a
end

function PlayState:update(dt)
  if love.keyboard.wasPressed('d') then
    self.hand:moveRight()
  elseif love.keyboard.wasPressed('a') then
    self.hand:moveLeft()
  elseif love.keyboard.wasPressed('space') then
    gSounds.card:play()
    self.run.type = self.hand:select(self.run.type)
    self.run:update()
  elseif love.keyboard.wasPressed('z') and self.run.type>0 and self.run.hand>0 then
    self.run:play()
    if self.run.score>=self.run.tgt_score then
      gSounds.win:play()
      self.run:win()
      gStateStack:pop()

      -- reward
      local next_state
      if math.random()>UPGRADE_HAND_PERCENT then
        next_state = RunInfoState(gStateStack.states[1],true)
      else
        next_state = ShopState(gStateStack.states[1],2)
      end
      gStateStack:push(MessageState({
          msg = 'Nice!'
        , yes = 'OK(z)'
        , x = 575
        , y = 300
        , w = 300
        , h = 200
        , c = {r=0, g=129, b=211}
        , next_state = next_state
      }))
    elseif self.run.hand==0 then
      gSounds.lose:play()
      self.run:lose()
      gStateStack:pop()
      gStateStack:push(MessageState({
          msg = 'Loser!'
        , yes = 'OK(z)'
        , x = 575
        , y = 300
        , w = 300
        , h = 200
        , c = {r=0, g=129, b=211}
        , next_state = SelectState(gStateStack.states[1])
      }))
    else
      gSounds.play:play()
      self.hand:play()
      self.hand:reset()
      for i=1,(self.ncards-#self.hand.hand) do
        self:draw()
      end
      self:point()
    end
  elseif love.keyboard.wasPressed('x') and self.run.type>0  and self.run.discard>0 then
    gSounds.discard:play()
    self.run.discard = self.run.discard-1
    self.run.base    = 0
    self.run.mult    = 0
    self.run.type    = 0

    self.hand:play()
    self.hand:reset()
    for i=1,(self.ncards-#self.hand.hand) do
      self:draw()
    end
    self:point()
  elseif love.keyboard.wasPressed('q') then
    gStateStack:push(RunInfoState(gStateStack.states[1],false))
  elseif love.keyboard.wasPressed('e') then
    gStateStack:push(DeckInfoState(self))
  elseif love.keyboard.wasPressed('c') then
    gStateStack:push(ControlState())
  end
end


function PlayState:render()
  -- render card
  local y = VH-2*CARDH
  local x = VW/6
  for i,v in pairs(self.hand.hand) do
    if v.state>CARD_ONHAND then
      y = VH-1.5*CARDH-10
    else
      y = VH-1.5*CARDH
    end
    if v.state>CARD_PLAYED then
      x = x+CARDW+10
      v:render(x,y)
    end
  end

  -- render deck
  -- love.graphics.draw(gCardCoverSheet,gCardCover[COVER_BACK],VH-30, VW-30)

  -- render pointer
  self.pointer:set(self.hand.i)
  self.pointer:render()
end
