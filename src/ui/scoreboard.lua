ScoreBoard = Class{}

function ScoreBoard:init(x,y)
  self.x = x
  self.y = y
  self.w = 50
end

function ScoreBoard:render(type)
  local base = 0
  local mul  = 0
  if not type then
    base = '-'
    mul  = '-'
  elseif type>0 then
    base = SCORES[type].base
    mul  = SCORES[type].multiplier
  end
  love.graphics.setColor(1,1,1,1)
  love.graphics.setFont(gFonts['medium'])
  love.graphics.draw(gScoreBoard,self.x,self.y)
  love.graphics.printf(tostring(base), self.x+SCOREBOARD_W*0.1, self.y+8, self.w, 'right')
  love.graphics.printf(tostring(mul) , self.x+SCOREBOARD_W*0.6, self.y+8, self.w, 'left')
end