SelectState = Class{__includes = BaseState}

function SelectState:init(run)
  self.run = run

  local x = 320
  local y = 200

  self.small_blind = BlindPanel({
      x = x
    , y = y
    , w = 256
    , h = 384
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=137, g=154, b=209}
    , c3 = {r=51, g=68, b=97}
    , size = 'xmedium'
    , dx = 8
    , dy = 4
    , stat = STAT_CREATED
    , score = ANTE_BASE[self.run.ante]*BLIND_MULT[BLIND_SMALL]
  })

  x = x+280
  self.big_blind = BlindPanel({
      x = x
    , y = y
    , w = 256
    , h = 384
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=113, g=141, b=191}
    , c3 = {r=51, g=68, b=97}
    , size = 'xmedium'
    , dx = 8
    , dy = 4
    , stat = STAT_CREATED
    , score = ANTE_BASE[self.run.ante]*BLIND_MULT[BLIND_BIG]
  })

  x = x+280
  self.boss_blind = BlindPanel({
      x = x
    , y = y
    , w = 256
    , h = 384
    , c1 = {r=25, g=25, b=25}
    , c2 = {r=93, g=94, b=142}
    , c3 = {r=51, g=68, b=97}
    , size = 'xmedium'
    , dx = 8
    , dy = 4
    , stat = STAT_CREATED
    , score = ANTE_BASE[self.run.ante]*BLIND_MULT[BLIND_BOSS]
  })
  self:blind()
end

function SelectState:blind()
  if self.run.blind==BLIND_SMALL then
    self.small_blind.stat = STAT_POINTED
  elseif self.run.blind==BLIND_BIG then
    self.small_blind.stat = STAT_SKIPPED
    self.big_blind.stat   = STAT_POINTED
  else
    self.small_blind.stat = STAT_SKIPPED
    self.big_blind.stat   = STAT_SKIPPED
    self.boss_blind.stat  = STAT_POINTED
  end
end

function SelectState:update(dt)
  self:blind()
  if love.keyboard.wasPressed('z') then
    gStateStack:pop()
    gStateStack:push(PlayState(gStateStack.states[#gStateStack.states]))
  elseif love.keyboard.wasPressed('x') then
    self.run:skip()
    gStateStack:push(RunInfoState(gStateStack.states[#gStateStack.states],true))
  end
end

function SelectState:render()
  self.small_blind:render()
  self.big_blind:render()
  self.boss_blind:render()
end
