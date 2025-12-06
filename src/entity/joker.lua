Joker = Class{}

JOKER_RED   = 1
JOKER_BLACK = 2
JOKER_PRICE = 6

JOKER_DESC  = {
  "Add 5 to MULT",
  "Add 20 to BASE"
}

function Joker:init(def)
  self.id   = def.id
  self.run  = def.run
  if def.x then self.x=def.x else self.x=0 end
  if def.y then self.y=def.y else self.y=0 end
  self.price = JOKER_PRICE
  self.desc = JOKER_DESC[self.id]
end

function Joker:render_at(x,y)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(gCardJokerSheet,gCardJoker[self.id],x,y)
end

function Joker:render()
  self:render_at(self.x,self.y)
end

function Joker:use()
  if self.id==JOKER_RED then
    self.run.mult = self.run.mult+5
  elseif self.id==JOKER_BLACK then
    self.run.base = self.run.base+20
  end
end