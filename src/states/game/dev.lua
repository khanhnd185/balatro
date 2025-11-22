
DevModeState = Class{__includes = BaseState}

function DevModeState:init()
  self.deck = Deck()
  self.perm = self:shuffle()
  self.hand = {}

  self.score = 0
  self.target_score = 300
  self.card_on_hand = 8

  self.ptr  = 1
  self.nsel = 0
  self.type = 0

  for i=1,self.card_on_hand do
    self:draw(table.remove(self.perm))
  end
  self.deck.cards[self.hand[self.ptr]].state=CARD_POINTR
end

function DevModeState:draw(n)
  table.insert(self.hand,n)
  self.deck.cards[n].state = CARD_ONHAND
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
  if love.keyboard.wasPressed('d') then -- right
    if self.ptr<self.card_on_hand then
      if self.ptr>0 and self.deck.cards[self.hand[self.ptr]].state==CARD_POINTR then
        self.deck.cards[self.hand[self.ptr]].state = CARD_ONHAND
      end
      self.ptr = self.ptr+1
      if self.deck.cards[self.hand[self.ptr]].state==CARD_ONHAND then
        self.deck.cards[self.hand[self.ptr]].state = CARD_POINTR
      end
    end
  elseif love.keyboard.wasPressed('a') then -- right
    if self.ptr>1 then
      if self.deck.cards[self.hand[self.ptr]].state==CARD_POINTR then
        self.deck.cards[self.hand[self.ptr]].state = CARD_ONHAND
      end
      self.ptr = self.ptr-1
      if self.deck.cards[self.hand[self.ptr]].state==CARD_ONHAND then
        self.deck.cards[self.hand[self.ptr]].state = CARD_POINTR
      end
    end
  elseif love.keyboard.wasPressed('space') then -- select
    if self.deck.cards[self.hand[self.ptr]].state==CARD_POINTR and self.nsel<5 then
      self.nsel = self.nsel+1
      self.deck.cards[self.hand[self.ptr]].state = CARD_SELECT
      self.type = self:eval()
    elseif self.deck.cards[self.hand[self.ptr]].state==CARD_SELECT then
      self.deck.cards[self.hand[self.ptr]].state = CARD_POINTR
      self.nsel = self.nsel-1
      self.type = self:eval()
    end
  elseif love.keyboard.wasPressed('return') and self.type>0 then
    self.score = self.score+SCORES[self.type].base*SCORES[self.type].multiplier
    self.type  = 0
    self.ptr   = 1
    self.hand  = {}
    for i,v in pairs(self.deck.cards) do
      if v.state==CARD_ONHAND or v.state==CARD_POINTR then
        self:draw(i)
      elseif v.state==CARD_SELECT then
        v.state = CARD_PLAYED
      end
    end

    for i=1,(self.card_on_hand-#self.hand) do
      self:draw(table.remove(self.perm))
    end
    self.nsel  = 0
    self.deck.cards[self.hand[self.ptr]].state=CARD_POINTR
  end
end


function DevModeState:eval()
  if self.nsel==0 then
    return 0
  end
  local cards = {}
  for i,v in pairs(self.deck.cards) do
    if v.state==CARD_SELECT then
      cards[v.suit+v.rank]=true
    end
  end

  -- Extract ranks and suits
  local ranks = {}  -- rank -> count
  local suits = {}  -- suit -> count
  local rankList = {} -- for sorting
  for card,_ in pairs(cards) do
    local rank = card % 13
    local suit = math.floor(card / 13)
    ranks[rank] = (ranks[rank] or 0) + 1
    suits[suit] = (suits[suit] or 0) + 1
    table.insert(rankList, rank)
  end

  table.sort(rankList)  -- ascending order

  -- Check flush
  local isFlush = false
  for _, count in pairs(suits) do
    if count == 5 then
      isFlush = true
      break
    end
  end

  -- Check straight
  local isStraight = false
  local sortedRanks = {}
  for _, r in ipairs(rankList) do sortedRanks[r+1] = true end

  -- Handle Ace-low straight (A-2-3-4-5)
  local aceLow = {0,1,2,3,4}  -- ranks 0=A,1=2,...
  local straightCount = 0
  for _, r in ipairs(aceLow) do
    if sortedRanks[r+1] then
      straightCount = straightCount + 1
    end
  end
  if straightCount == 5 then
    isStraight = true
  else
    -- Normal straight
    table.sort(rankList)
    local consecutive = 1
    for i = 2,#rankList do
      if rankList[i] == rankList[i-1]+1 then
        consecutive = consecutive + 1
        if consecutive == 5 then
          isStraight = true
          break
        end
      elseif rankList[i] ~= rankList[i-1] then
        consecutive = 1
      end
    end
  end

  -- Count duplicates
  local counts = {}  -- how many ranks have x-of-a-kind
  for _, cnt in pairs(ranks) do
    counts[cnt] = (counts[cnt] or 0) + 1
  end

  -- Determine hand type
  if isStraight and isFlush then
    return 9  -- straight flush
  elseif counts[4] then
    return 8  -- four of a kind
  elseif counts[3] and counts[2] then
    return 7  -- full house
  elseif isFlush then
    return 6  -- flush
  elseif isStraight then
    return 5  -- straight
  elseif counts[3] then
    return 4  -- three of a kind
  elseif counts[2] and counts[2] > 1 then
    return 3  -- two pair
  elseif counts[2] then
    return 2  -- pair
  else
    return 1  -- high card
  end
end

function DevModeState:render()
  -- render card
  local y = VH-256
  local x = 0
  for i,v in pairs(self.hand) do
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
