
BlindState = Class{__includes = BaseState}

function BlindState:init()
  self.scoreboard = ScoreBoard(VW-1.1*SCOREBOARD_W,64)
  self.deck = Deck()
  self.perm = self:shuffle()

  self.score  = 0
  self.ncards = 8
  self.target_score = 300

  self.type = 0
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
    self.type = self.hand:select(self.tpe)
  elseif love.keyboard.wasPressed('return') and self.type>0 then
    self.score = self.score+SCORES[self.type].base*SCORES[self.type].multiplier
    self.type  = 0
    self.hand:play()
    self.hand:reset()
    for i=1,(self.ncards-#self.hand.hand) do
      self:draw()
    end
    self:point()
  end
end


function BlindState:render()
  -- render card
  local y = VH-2*CARDH
  local x = VW/4
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

  -- render score
  love.graphics.printf(tostring(self.score) .. '/' .. tostring(self.target_score), 0, 32, VW-30, 'right')
  

  -- render deck
  love.graphics.draw(gCardCoverSheet,gCardCover[COVER_BACK],VH-30, VW-30)


  -- render current run info
  self.scoreboard:render(self.type)
end
