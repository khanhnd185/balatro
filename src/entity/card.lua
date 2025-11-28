Card = Class{}

function Card:init(suit, rank)
  self.suit   = suit*13
  self.rank   = rank
  self.back   = gCardCover[COVER_BACK]
  self.skin   = gCardCover[COVER_FRONT]
  self.state  = CARD_UNUSED
  self.fold   = false
  if rank==0 then
    self.front  = gCard[suit*13+13]
  else
    self.front  = gCard[suit*13+rank]
  end
end

function Card:render(x,y)
  if self.state==CARD_SELECT then
    love.graphics.setColor(1, 1, 1, 1)
  else
    love.graphics.setColor(0.85, 0.85, 0.85, 1)
  end
  if self.fold then
    love.graphics.draw(gCardCoverSheet,self.back,x,y)
  else
    -- love.graphics.printf(tostring(self.rank), x, y-40, 50, 'left')
    -- love.graphics.printf(tostring(self.suit), x, y-20, 50, 'left')
    love.graphics.draw(gCardCoverSheet,self.skin,x,y)
    love.graphics.draw(gCardSheet,self.front,x,y)
  end
  love.graphics.setColor(1, 1, 1, 1)
end

function Card:render_info(x,y)
  if self.state==CARD_PLAYED then
    love.graphics.setColor(0.75, 0.75, 0.75, 1)
  else
    love.graphics.setColor(1, 1, 1, 1)
  end
  if self.fold then
    love.graphics.draw(gCardCoverSheet,self.back,x,y)
  else
    -- love.graphics.printf(tostring(self.rank), x, y-40, 50, 'left')
    -- love.graphics.printf(tostring(self.suit), x, y-20, 50, 'left')
    love.graphics.draw(gCardCoverSheet,self.skin,x,y)
    love.graphics.draw(gCardSheet,self.front,x,y)
  end
  love.graphics.setColor(1, 1, 1, 1)
end