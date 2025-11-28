TextBox = Class{}

function TextBox:init(def)
  self.x    = def.x
  self.y    = def.y
  self.w    = def.w
  self.h    = def.h
  self.c1   = def.c1
  self.c2   = def.c2
  self.c3   = def.c3
  self.size = def.size
  self.dx   = def.dx
  self.dy   = def.dy
  self.r    = 4
end

function TextBox:render(s)
  love.graphics.setColor(self.c1.r/255,self.c1.g/255,self.c1.b/255,1)
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h,self.r,self.r)
  love.graphics.setColor(self.c2.r/255,self.c2.g/255,self.c2.b/255,1)
  love.graphics.rectangle("fill",self.x+self.dx,self.y+self.dy,self.w-2*self.dx,self.h-2*self.dy,self.r,self.r)
  if s then
    love.graphics.setColor(self.c3.r/255,self.c3.g/255,self.c3.b/255,1)
    love.graphics.setFont(gFonts[self.size])
    love.graphics.printf(s, self.x+self.dx*4, self.y+self.dy*2,self.w-2*self.dx,'left')
  end
end

ShadowTextBox = Class{}

function ShadowTextBox:init(def)
  self.x    = def.x
  self.y    = def.y
  self.w    = def.w
  self.h    = def.h
  self.c1   = def.c1
  self.c2   = def.c2
  self.c3   = def.c3
  self.size = def.size
  self.dx   = def.dx
  self.dy   = def.dy
  self.r    = 4
end

function ShadowTextBox:render(s)
  love.graphics.setColor(self.c1.r/255,self.c1.g/255,self.c1.b/255,1)
  love.graphics.rectangle("fill",self.x+4,self.y+4,self.w,self.h,self.r,self.r)
  love.graphics.setColor(self.c2.r/255,self.c2.g/255,self.c2.b/255,1)
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h,self.r,self.r)
  if s then
    love.graphics.setColor(self.c3.r/255,self.c3.g/255,self.c3.b/255,1)
    love.graphics.setFont(gFonts[self.size])
    love.graphics.printf(s, self.x+self.dx*4, self.y+self.dy*2,self.w-2*self.dx,'left')
  end
end

