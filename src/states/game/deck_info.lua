DeckInfoState = Class{__includes = BaseState}

function DeckInfoState:init(play)
  self.cards = play.deck.cards
  self.x = 384
  self.y = 40
  self.w = 720
  self.h = 640
  self.window  = ShadowTextBox({
      x = self.x
    , y = self.y
    , w = self.w
    , h = self.h
    , c1 = COLOR.SHADOW
    , c2 = COLOR.THEME4
    , c3 = COLOR.ABSWHITE
    , size = 'large'
    , dx = 80
    , dy = 8
  })
  self.back_box = ShadowTextBox({
      x = self.x+320
    , y = self.y+self.h-60
    , w = 128
    , h = 40
    , c1 = COLOR.SHADOW
    , c2 = COLOR.ORANGE
    , c3 = COLOR.ABSWHITE
    , size = 'xmedium'
    , dx = 4
    , dy = 4
  })
end

function DeckInfoState:update(dt)
  if love.keyboard.wasPressed('x') then
    gStateStack:pop()
  end
end

function DeckInfoState:render()
  local x = self.x+34
  local y = self.y-38

  self.window:render('Deck Info')

  for i=1,52 do
    if i%13==1 then
      y = y+112
      x = self.x+36
    end
    self.cards[i]:render_info(x,y)
    x = x+32
  end


  self.back_box:render('Back (x)')
end
