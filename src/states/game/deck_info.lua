DeckInfoState = Class{__includes = BaseState}

function DeckInfoState:init(blind_state)
  self.cards = blind_state.deck.cards
  self.x = 384
  self.y = 40
  self.w = 720
  self.h = 640
  self.window  = ShadowTextBox({
      x = self.x
    , y = self.y
    , w = self.w
    , h = self.h
    , c1 = {r=25, g=25, b=25}
    -- , c2 = {r=94, g=121, b=119}
    , c2 = {r=113, g=141, b=191}
    , c3 = {r=255, g=255, b=255}
    , size = 'large'
    , dx = 80
    , dy = 8
  })
  self.back_box = ShadowTextBox({
      x = self.x+320
    , y = self.y+self.h-60
    , w = 128
    , h = 40
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=234, g=150, b=0}
    , c3 = {r=255, g=255, b=255}
    , size = 'mlarge'
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
