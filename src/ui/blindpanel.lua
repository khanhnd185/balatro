BlindPanel = Class{__includes = BaseState}

STAT_CREATED = 0
STAT_POINTED = 1
STAT_SKIPPED = 2

function BlindPanel:init(def)
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
  self.r    = 8
  self.stat = def.stat
  self.score = def.score


  local box_w = 128
  local box_h = 40
  self.skip_box = ShadowTextBox({
      x = self.x+(self.w-box_w)/2
    , y = self.y+self.h-box_h-10
    , w = box_w
    , h = 40
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=236, g=45, b=51}
    , c3 = {r=255, g=255, b=255}
    , size = 'xmedium'
    , dx = 4
    , dy = 4
  })
  self.play_box = ShadowTextBox({
      x = self.x+(self.w-box_w)/2
    , y = self.y+self.h-2*box_h-18
    , w = box_w
    , h = 40
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=0, g=156, b=253}
    , c3 = {r=255, g=255, b=255}
    , size = 'xmedium'
    , dx = 4
    , dy = 4
  })
end

function BlindPanel:render()
  love.graphics.setColor(self.c1.r/255,self.c1.g/255,self.c1.b/255,1)
  love.graphics.rectangle("fill",self.x+4,self.y+4,self.w,self.h,self.r,self.r)
  love.graphics.setColor(self.c2.r/255,self.c2.g/255,self.c2.b/255,1)
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h,self.r,self.r)

  love.graphics.setColor(1,1,1,1)
  love.graphics.setFont(gFonts[self.size])
  love.graphics.printf('Score at least', self.x+self.dx*4, self.y+self.dy*2,self.w-2*self.dx,'left')

  love.graphics.setColor(self.c3.r/255,self.c3.g/255,self.c3.b/255,1)
  love.graphics.setFont(gFonts['xlarge'])
  love.graphics.printf(tostring(self.score), self.x+72, self.y+40,self.w-64,'left')

  self.play_box:render('Play (z)')
  self.skip_box:render('Skip (x)')
end