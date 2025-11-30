RunInfoState = Class{__includes = BaseState}

function RunInfoState:init(play, upgrade)
  self.run = play.run
  local x = 384
  local y = 40
  self.window  = ShadowTextBox({
      x = x
    , y = y
    , w = 720
    , h = 640
    , c1 = {r=25, g=25, b=25}
    -- , c2 = {r=94, g=121, b=119}
    , c2 = {r=113, g=141, b=191}
    , c3 = {r=255, g=255, b=255}
    , size = 'large'
    , dx = 80
    , dy = 8
  })

  x = x+96
  y = y+80

  if upgrade==true then
    self.pointer = VerticalPointer({
        x     = x-16
      , y     = y+16
      , dx    = 0
      , dy    = 48
      , size  = 32
      , color = {r=79, g=99, b=103}
    })
  end

  self.run_info_boxes = {}
  self.base_boxes = {}
  self.mult_boxes = {}
  self.lvl_boxes  = {}
  for i=1,#HAND_TYPE do
    table.insert(self.run_info_boxes, ShadowTextBox({
          x = x
        , y = y
        , w = 512
        , h = 40
        , c1 = {r=25, g=25, b=25}
        -- , c2 = {r=188, g=188, b=188}
        , c2 = {r=93, g=94, b=142}
        , c3 = {r=255, g=255, b=255}
        , size = 'xmedium'
        , dx = 32
        , dy = 4
      })
    )
    table.insert(self.base_boxes, TextBox({
          x = x+320
        , y = y+4
        , w = 64
        , h = 32
        , c1 = {r=25, g=25, b=25}
        , c2 = {r=0, g=156, b=253}
        , c3 = {r=255, g=255, b=255}
        , size = 'xmedium'
        , dx = 3
        , dy = 3
      })
    )
    table.insert(self.mult_boxes, TextBox({
          x = x+416
        , y = y+4
        , w = 64
        , h = 32
        , c1 = {r=25, g=25, b=25}
        , c2 = {r=236, g=45, b=51}
        , c3 = {r=255, g=255, b=255}
        , size = 'xmedium'
        , dx = 3
        , dy = 3
      })
    )
    table.insert(self.lvl_boxes, TextBox({
          x = x+8
        , y = y+4
        , w = 96
        , h = 32
        , c1 = {r=25, g=25, b=25}
        , c2 = {r=137, g=154, b=209}
        , c3 = {r=255, g=255, b=255}
        , size = 'xmedium'
        , dx = 3
        , dy = 3
      })
    )
    y = y+48
  end
  if upgrade then
    self.sel_box = ShadowTextBox({
        x = x+224
      , y = y+16
      , w = 140
      , h = 40
      , c1 = {r=25, g=25, b=25}
      , c2 = {r=234, g=150, b=0}
      , c3 = {r=255, g=255, b=255}
      , size = 'xmedium'
      , dx = 4
      , dy = 4
    })
  end
  self.back_box = ShadowTextBox({
      x = x+224
    , y = y+64
    , w = 140
    , h = 40
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=234, g=150, b=0}
    , c3 = {r=255, g=255, b=255}
    , size = 'xmedium'
    , dx = 4
    , dy = 4
  })
end

function RunInfoState:update(dt)
  if love.keyboard.wasPressed('x') then
    gStateStack:pop()
  elseif self.pointer and love.keyboard.wasPressed('w') then
    self.pointer:up()
  elseif self.pointer and love.keyboard.wasPressed('s') then
    self.pointer:down()
  elseif self.pointer and love.keyboard.wasPressed('z') then
    self.run:upgrade(self.pointer.pos)
    gStateStack:pop()
  end
end

function RunInfoState:render()
  if self.pointer then
    self.window:render('Upgrade Hand')
    self.pointer:render()
    self.sel_box:render('Select (z)')
  else
    self.window:render('Run Info')
  end
  for i=1,#HAND_TYPE do
    self.run_info_boxes[i]:render(HAND_TYPE[i])
    self.base_boxes[i]:render(self.run.scores[i].base)
    self.mult_boxes[i]:render(self.run.scores[i].mult)
    self.lvl_boxes[i]:render('lvl.' .. tostring(self.run.scores[i].level))
  end
  self.back_box:render('Back (x)')
end
