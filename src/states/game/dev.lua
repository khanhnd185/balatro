
DevModeState = Class{__includes = BaseState}

function DevModeState:init()
  self.deck = Deck()
  self.perm = self:shuffle()

  self.score = 0
  self.target_score = 300
  self.card_on_hand = 8

  self.type = 0
  self.hand = Hand(self.deck.cards,self.card_on_hand)

  for i=1,self.card_on_hand do
    self.hand:draw(table.remove(self.perm))
  end
  self.deck.cards[self.hand.ptr].state=CARD_POINTR
end

function DevModeState:shuffle()
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

function DevModeState:update(dt)
  if love.keyboard.wasPressed('d') then
    self.hand:moveRight()
  elseif love.keyboard.wasPressed('a') then
    self.hand:moveLeft()
  elseif love.keyboard.wasPressed('space') then -- select
    self.type = self.hand:select(self.tpe)
  elseif love.keyboard.wasPressed('return') and self.type>0 then
    self.score = self.score+SCORES[self.type].base*SCORES[self.type].multiplier
    self.type  = 0
    self.hand:play()
    for i=1,(self.card_on_hand-#self.hand.hand) do
      self.hand:draw(table.remove(self.perm))
    end
    self.hand.nsel  = 0
    self.deck.cards[self.hand.ptr].state=CARD_POINTR
  end
end


function DevModeState:render()
  -- render card
  local y = VH-256
  local x = 0
  for i,v in pairs(self.hand.hand) do
    if self.deck.cards[v].state>CARD_ONHAND then
      y = VH-266
    else
      y = VH-256
    end
    if self.deck.cards[v].state>CARD_PLAYED then
      x = x+80
      self.deck.cards[v]:render(x,y)
    end
  end

  -- render score
  love.graphics.printf(tostring(self.score) .. '/' .. tostring(self.target_score), 0, 32, VW-30, 'right')
  

  -- render deck
  love.graphics.draw(gCardCoverSheet,gCardCover[COVER_BACK],VH-30, VW-30)
  

  -- render current run info
  love.graphics.draw(gRunInfo,10,VW-80)
  local base = 'base'
  local mul  = 'mul'
  if self.type>0 then
    base = SCORES[self.type].base
    mul  = SCORES[self.type].multiplier
  end
  love.graphics.draw(gRunInfo,32,32)
  love.graphics.printf(tostring(base), 48, 40, 50, 'right')
  love.graphics.printf(tostring(mul) , 128, 40, 50, 'left')
end
