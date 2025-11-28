RunState = Class{__includes = BaseState}

function RunState:init()
  self.ante       = 1
  self.blind      = BLIND_SMALL
  self.money      = 4
  self.hand       = 5
  self.discard    = 3
  self.round      = 1
  self.base       = 0
  self.mult       = 0
  self.score      = 0
  self.tg_score   = 300

  -- Menu pallete
  self.background = TextBox({
      x = 10
    , y = 0
    , w = 256
    , h = VH
    , c1 = {r=0, g=129, b=211}
    , c2 = {r=51, g=68, b=97}
    , c3 = {r=245, g=166, b=0}
    , size = 'large'
    , dx = 8
    , dy = 8
  })

  -- target score box
  self.target_score_box  = ShadowTextBox({
      x = 24
    , y = 180
    , w = 220
    , h = 80
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=90, g=171, b=220}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 12
    , dy = 2
  })
  self.target_score_txt  = TextBox({
      x = 40
    , y = 200
    , w = 180
    , h = 40
    , c1 = {r=90, g=171, b=220}
    , c2 = {r=90, g=171, b=220}
    , c3 = {r=51, g=68, b=97}
    , size = 'xlarge'
    , dx = 10
    , dy = 2
  })


  -- Score
  self.score_box1  = TextBox({
      x = 24
    , y = 272
    , w = 224
    , h = 56
    , c1 = {r=0, g=129, b=211}
    , c2 = {r=0, g=129, b=211}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 10
  })
  self.score_box2  = TextBox({
      x = 84
    , y = 280
    , w = 156
    , h = 40
    , c1 = {r=51, g=68, b=97}
    , c2 = {r=51, g=68, b=97}
    , c3 = {r=255, g=255, b=255}
    , size = 'large'
    , dx = 12
    , dy = 4
  })



  -- Hand type
  self.type_box   = TextBox({
      x = 24
    , y = 334
    , w = 224
    , h = 128
    , c1 = {r=0, g=0, b=0}
    , c2 = {r=0, g=0, b=0}
    , c3 = {r=255, g=255, b=255}
    , size = 'large'
    , dx = 6
    , dy = 6
  })
  self.base_box   = TextBox({
      x = 32
    , y = 400
    , w = 96
    , h = 56
    , c1 = {r=0, g=156, b=253}
    , c2 = {r=0, g=156, b=253}
    , c3 = {r=255, g=255, b=255}
    , size = 'large'
    , dx = 6
    , dy = 6
  })
  self.mult_box   = TextBox({
      x = 136
    , y = 400
    , w = 96
    , h = 56
    , c1 = {r=236, g=45, b=51}
    , c2 = {r=236, g=45, b=51}
    , c3 = {r=255, g=255, b=255}
    , size = 'large'
    , dx = 6
    , dy = 6
  })


  -- Hand box
  self.hand_box1  = TextBox({
      x = 112
    , y = 470
    , w = 64
    , h = 64
    , c1 = {r=0, g=129, b=211}
    , c2 = {r=0, g=129, b=211}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 2
    , dy = 2
  })
  self.hand_box2  = TextBox({
      x = 116
    , y = 490
    , w = 56
    , h = 40
    , c1 = {r=51, g=68, b=97}
    , c2 = {r=51, g=68, b=97}
    , c3 = {r=0, g=156, b=253}
    , size = 'large'
    , dx = 5
    , dy = 2
  })

  -- Discards box
  self.discard_box1  = TextBox({
      x = 180
    , y = 470
    , w = 64
    , h = 64
    , c1 = {r=0, g=129, b=211}
    , c2 = {r=0, g=129, b=211}
    , c3 = {r=255, g=255, b=255}
    , size = 'medium'
    , dx = 1
    , dy = 2
  })
  self.discard_box2  = TextBox({
      x = 184
    , y = 490
    , w = 56
    , h = 40
    , c1 = {r=51, g=68, b=97}
    , c2 = {r=51, g=68, b=97}
    , c3 = {r=236, g=45, b=51}
    , size = 'large'
    , dx = 5
    , dy = 2
  })

  -- Money box
  self.money_box  = TextBox({
      x = 112
    , y = 542
    , w = 130
    , h = 68
    , c1 = {r=0, g=129, b=211}
    , c2 = {r=51, g=68, b=97}
    , c3 = {r=245, g=166, b=0}
    , size = 'xlarge'
    , dx = 6
    , dy = 6
  })

  -- Ante box
  self.ante_box1  = TextBox({
    x = 112
  , y = 620
  , w = 64
  , h = 64
  , c1 = {r=0, g=129, b=211}
  , c2 = {r=0, g=129, b=211}
  , c3 = {r=255, g=255, b=255}
  , size = 'medium'
  , dx = 2
  , dy = 2
})
self.ante_box2  = TextBox({
    x = 116
  , y = 640
  , w = 56
  , h = 40
  , c1 = {r=51, g=68, b=97}
  , c2 = {r=51, g=68, b=97}
  , c3 = {r=245, g=166, b=0}
  , size = 'large'
  , dx = 5
  , dy = 2
})

-- Discards box
self.round_box1  = TextBox({
    x = 180
  , y = 620
  , w = 64
  , h = 64
  , c1 = {r=0, g=129, b=211}
  , c2 = {r=0, g=129, b=211}
  , c3 = {r=255, g=255, b=255}
  , size = 'medium'
  , dx = 1
  , dy = 2
})
self.round_box2  = TextBox({
    x = 184
  , y = 640
  , w = 56
  , h = 40
  , c1 = {r=51, g=68, b=97}
  , c2 = {r=51, g=68, b=97}
  , c3 = {r=245, g=166, b=0}
  , size = 'large'
  , dx = 5
  , dy = 2
})

  -- Run info
  self.run_box  = ShadowTextBox({
    x = 28
  , y = 474
  , w = 72
  , h = 80
  , c1 = {r=25, g=25, b=25}
  , c2 = {r=253, g=95, b=85}
  , c3 = {r=255, g=255, b=255}
  , size = 'medium'
  , dx = 4
  , dy = 8
})

  -- Run info
  self.opt_box  = ShadowTextBox({
    x = 28
  , y = 570
  , w = 72
  , h = 80
  , c1 = {r=25, g=25, b=25}
  , c2 = {r=234, g=150, b=0}
  , c3 = {r=255, g=255, b=255}
  , size = 'medium'
  , dx = 2
  , dy = 12
})
end

function RunState:update(dt)
end

function RunState:render()
  -- render menu background
  self.background:render(nil)

  -- render round score
  self.target_score_box:render('Score at least')
  self.target_score_txt:render(tostring(self.tg_score))
  self.score_box1:render('score')
  self.score_box2:render(tostring(self.score))

  -- render score board
  self.type_box:render('Hand type')
  self.base_box:render(tostring(self.base))
  self.mult_box:render(tostring(self.mult))

  -- render hands and discards
  self.hand_box1:render('Hands')
  self.hand_box2:render(tostring(self.hand))
  self.discard_box1:render('Discards')
  self.discard_box2:render(tostring(self.discard))

  -- render ante and round
  self.ante_box1:render('Ante')
  self.ante_box2:render(tostring(self.ante))
  self.round_box1:render('Round')
  self.round_box2:render(tostring(self.round))

  -- render money
  self.money_box:render('$' .. tostring(self.money))

  -- render run info
  self.run_box:render('Run Info (Q)')
  self.opt_box:render('Deck Info (E)')
end
