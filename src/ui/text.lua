Text = Class{}

function Text:init(def)
  self.x    = def.x
  self.y    = def.y
  self.c    = def.c
  self.size = def.size
end

function Text:render(s)
    love.graphics.setColor(self.c.r/255,self.c.g/255,self.c.b/255,1)
    love.graphics.setFont(gFonts[self.size])
    love.graphics.printf(s, self.x, self.y,100,'left')
end