Hand = Class{}

function Hand:init(cards,card_on_hand)
  self.card_on_hand = card_on_hand
  self.cards = cards
  self.hand = {}
  self.ptr  = 1
  self.nsel = 0
end

function Hand:draw(n)
  table.insert(self.hand,n)
  self.cards[n].state = CARD_ONHAND
end

function Hand:moveRight()
  if self.ptr<self.card_on_hand then
    if self.ptr>0 and self.cards[self.hand[self.ptr]].state==CARD_POINTR then
      self.cards[self.hand[self.ptr]].state = CARD_ONHAND
    end
    self.ptr = self.ptr+1
    if self.cards[self.hand[self.ptr]].state==CARD_ONHAND then
      self.cards[self.hand[self.ptr]].state = CARD_POINTR
    end
  end
end

function Hand:moveLeft()
  if self.ptr>1 then
    if self.cards[self.hand[self.ptr]].state==CARD_POINTR then
      self.cards[self.hand[self.ptr]].state = CARD_ONHAND
    end
    self.ptr = self.ptr-1
    if self.cards[self.hand[self.ptr]].state==CARD_ONHAND then
      self.cards[self.hand[self.ptr]].state = CARD_POINTR
    end
  end
end

function Hand:select(current_type)
  if self.cards[self.hand[self.ptr]].state==CARD_POINTR and self.nsel<5 then
    self.nsel = self.nsel+1
    self.cards[self.hand[self.ptr]].state = CARD_SELECT
    return self:eval()
  elseif self.cards[self.hand[self.ptr]].state==CARD_SELECT then
    self.cards[self.hand[self.ptr]].state = CARD_POINTR
    self.nsel = self.nsel-1
    return self:eval()
  end
  return current_type
end

function Hand:play()
  self.ptr   = 1
  self.hand  = {}
  for i,v in pairs(self.cards) do
    if v.state==CARD_ONHAND or v.state==CARD_POINTR then
      self:draw(i)
    elseif v.state==CARD_SELECT then
      v.state = CARD_PLAYED
    end
  end
end

function Hand:eval()
  if self.nsel==0 then
    return 0
  end
  local cards = {}
  for i,v in pairs(self.cards) do
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
