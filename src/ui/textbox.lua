TextBox = Class{}

function TextBox:init(x, y, w, h, c)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.c = c
  self.mx = 10
  self.my = 10
  self.fontsize = 'medium'
end

function TextBox:render(s)
  love.graphics.setColor(self.c)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  love.graphics.setColor(1,1,1,1)
  love.graphics.setFont(gFonts[self.fontsize])
  love.graphics.print(s, self.x+self.mx, self.y+self.my)
end