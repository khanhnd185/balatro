Hand = Class{}

function Hand:init(ncards)
  self.ncards = ncards
  self.hand = {}
  self:reset()
end

function Hand:draw(card)
  card.state = CARD_ONHAND
  table.insert(self.hand,card)
end

function Hand:reset()
  self.nsel = 0
  self.i    = 1
end

function Hand:moveRight()
  if self.i<self.ncards then
    if self.i>0 and self.hand[self.i].state==CARD_POINTR then
      self.hand[self.i].state = CARD_ONHAND
    end
    self.i = self.i+1
    if self.hand[self.i].state==CARD_ONHAND then
      self.hand[self.i].state = CARD_POINTR
    end
  end
end

function Hand:moveLeft()
  if self.i>1 then
    if self.hand[self.i].state==CARD_POINTR then
      self.hand[self.i].state = CARD_ONHAND
    end
    self.i = self.i-1
    if self.hand[self.i].state==CARD_ONHAND then
      self.hand[self.i].state = CARD_POINTR
    end
  end
end

function Hand:select(current_type)
  if self.hand[self.i].state==CARD_POINTR and self.nsel<5 then
    self.nsel = self.nsel+1
    self.hand[self.i].state = CARD_SELECT
    return self:eval()
  elseif self.hand[self.i].state==CARD_SELECT then
    self.hand[self.i].state = CARD_POINTR
    self.nsel = self.nsel-1
    return self:eval()
  end
  return current_type
end

function Hand:play()
  local hand  = {}
  for i,v in pairs(self.hand) do
    if v.state==CARD_ONHAND or v.state==CARD_POINTR then
      table.insert(hand,v)
    elseif v.state==CARD_SELECT then
      v.state = CARD_PLAYED
    end
  end
  self.hand = hand
end

function Hand:eval()
  if self.nsel==0 then
    return 0
  end
  local cards = {}
  for i,v in pairs(self.hand) do
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
