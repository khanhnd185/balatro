JokerSlot = Class{}

function JokerSlot:init(def)
  self.x = def.x
  self.y = def.y
  self.w = def.w
  self.h = def.h
  self.c = def.c
end

function JokerSlot:render(jokers)
  love.graphics.setColor(self.c.r/255,self.c.g/255,self.c.b/255,1)
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h,4,4)

  for i=1,#jokers do
    jokers[i]:render_at(self.x+8+i*64,self.y+8)
  end
end