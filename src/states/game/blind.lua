
BlindState = Class{__includes = BaseState}

function BlindState:init(run_info)
  self.run_info = run_info

  self.scoreboard = ScoreBoard(VW-1.1*SCOREBOARD_W,64)
  self.deck = Deck()
  self.perm = self:shuffle()

  self.ncards = 8
  self.target_score = 300

  self.hand = Hand(self.ncards)

  for i=1,self.ncards do
    self:draw()
  end
  self:point()
end

function BlindState:draw()
  self.hand:draw(self.deck.cards[table.remove(self.perm)])
end

function BlindState:point()
  self.hand.hand[self.hand.i].state=CARD_POINTR
end

function BlindState:shuffle()
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

function BlindState:update(dt)
  if love.keyboard.wasPressed('d') then
    self.hand:moveRight()
  elseif love.keyboard.wasPressed('a') then
    self.hand:moveLeft()
  elseif love.keyboard.wasPressed('space') then -- select
    self.run_info.type = self.hand:select(self.run_info.type)
    if self.run_info.type>0 then
      self.run_info.base = SCORES[self.run_info.type].base
      self.run_info.mult = SCORES[self.run_info.type].mult
    else
      self.run_info.base = 0
      self.run_info.mult = 0
    end
  elseif love.keyboard.wasPressed('z') and self.run_info.type>0 and self.run_info.hand>0 then
    self.run_info.score = self.run_info.score+SCORES[self.run_info.type].base*SCORES[self.run_info.type].mult
    self.run_info.hand  = self.run_info.hand-1
    self.run_info.base  = 0
    self.run_info.mult  = 0
    self.run_info.type  = 0

    self.hand:play()
    self.hand:reset()
    for i=1,(self.ncards-#self.hand.hand) do
      self:draw()
    end
    self:point()
  elseif love.keyboard.wasPressed('x') and self.run_info.type>0  and self.run_info.discard>0 then
    self.run_info.discard = self.run_info.discard-1
    self.run_info.base    = 0
    self.run_info.mult    = 0
    self.run_info.type    = 0

    self.hand:play()
    self.hand:reset()
    for i=1,(self.ncards-#self.hand.hand) do
      self:draw()
    end
    self:point()
  elseif love.keyboard.wasPressed('q') then
    gStateStack:push(RunInfoState(gStateStack.states[#gStateStack.states]))
  elseif love.keyboard.wasPressed('return') then
    gStateStack:push(DeckInfoState(gStateStack.states[#gStateStack.states]))
  end
end


function BlindState:render()
  -- render card
  local y = VH-2*CARDH
  local x = VW/6
  for i,v in pairs(self.hand.hand) do
    if v.state>CARD_ONHAND then
      y = VH-2*CARDH-10
    else
      y = VH-2*CARDH
    end
    if v.state>CARD_PLAYED then
      x = x+CARDW+10
      v:render(x,y)
    end
  end

  -- render deck
  love.graphics.draw(gCardCoverSheet,gCardCover[COVER_BACK],VH-30, VW-30)
end
