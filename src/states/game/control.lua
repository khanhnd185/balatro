ControlState = Class{__includes = BaseState}

function ControlState:init()
  self.run = run
  local X = 384
  local Y = 40
  local W = 720
  local H = 640
  self.window  = ShadowTextBox({
      x = X
    , y = Y
    , w = W
    , h = H
    , c1 = {r=25, g=25, b=25}
    -- , c2 = {r=94, g=121, b=119}
    , c2 = {r=113, g=141, b=191}
    , c3 = {r=255, g=255, b=255}
    , size = 'large'
    , dx = 80
    , dy = 8
  })

  local w = 140
  local h = 40
  self.back_box = ShadowTextBox({
      x = X+(W-w)/2
    , y = Y+H-h-8
    , w = w
    , h = h
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=234, g=150, b=0}
    , c3 = {r=255, g=255, b=255}
    , size = 'xmedium'
    , dx = 4
    , dy = 4
  })


  local x = X+32
  local y = Y+64
  self.but_q = ShadowTextBox({
      x = x
    , y = y
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_q = Text({
      x = x+40
    , y = y+8
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_e = ShadowTextBox({
      x = x
    , y = y+40
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_e = Text({
      x = x+40
    , y = y+48
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_w = ShadowTextBox({
      x = x
    , y = y+80
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_w = Text({
      x = x+40
    , y = y+88
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_a = ShadowTextBox({
      x = x
    , y = y+120
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_a = Text({
      x = x+40
    , y = y+128
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_s = ShadowTextBox({
      x = x
    , y = y+160
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_s = Text({
      x = x+40
    , y = y+168
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_d = ShadowTextBox({
      x = x
    , y = y+200
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_d = Text({
      x = x+40
    , y = y+208
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_z = ShadowTextBox({
      x = x
    , y = y+240
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_z = Text({
      x = x+40
    , y = y+248
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_x = ShadowTextBox({
      x = x
    , y = y+280
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_x = Text({
      x = x+40
    , y = y+288
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_c = ShadowTextBox({
      x = x
    , y = y+320
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_c = Text({
      x = x+40
    , y = y+328
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_m = ShadowTextBox({
      x = x
    , y = y+360
    , w = 32
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_m = Text({
      x = x+40
    , y = y+368
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

  self.but_esc = ShadowTextBox({
    x = x
  , y = y+400
  , w = 40
  , h = 32
  , c1 = {r=25, g=25, b=25}
  , c2 = {r=166, g=166, b=166}
  , c3 = {r=255, g=255, b=255}
  , size = 'medium'
  , dx = 2
  , dy = 2
})
self.desc_esc = Text({
    x = x+48
  , y = y+408
  , c = {r=25, g=25, b=25}
  , size = 'xmedium'
  , w = 400
})
  self.but_space = ShadowTextBox({
      x = x
    , y = y+440
    , w = 112
    , h = 32
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=166, g=166, b=166}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.desc_space = Text({
      x = x+120
    , y = y+448
    , c = {r=25, g=25, b=25}
    , size = 'xmedium'
    , w = 400
  })

end

function ControlState:update(dt)
  if love.keyboard.wasPressed('x') then
    gStateStack:pop()
  end
end

function ControlState:render()
  self.window:render('Control')

  -- render button
  self.but_q:render('q')
  self.but_w:render('w')
  self.but_e:render('e')
  self.but_a:render('a')
  self.but_s:render('s')
  self.but_d:render('d')
  self.but_z:render('z')
  self.but_x:render('x')
  self.but_c:render('c')
  self.but_m:render('m')
  self.but_esc:render('esc')
  self.but_space:render('space')

  -- render description
  self.desc_q:render(': Run info')
  self.desc_w:render(': Up')
  self.desc_e:render(': Deck info')
  self.desc_a:render(': Left')
  self.desc_s:render(': Down')
  self.desc_d:render(': Right')
  self.desc_z:render(': Yes/Confirm/Play')
  self.desc_x:render(': No/Cancel/Discard')
  self.desc_c:render(': Control pannel')
  self.desc_m:render(': Turn on/off music')
  self.desc_esc:render(': Quit game')
  self.desc_space:render(': Select card')



  self.back_box:render('Back (x)')
end