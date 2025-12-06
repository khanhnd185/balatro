SelectState = Class{__includes = BaseState}

function SelectState:init(run)
  self.run = run
  self.ante = run.ante

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
    , reward = run.rewards[BLIND_SMALL]
    , can_skip = true
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
    , reward = run.rewards[BLIND_BIG]
    , can_skip = true
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
    , reward = run.rewards[BLIND_BOSS]
    , can_skip = false
  })
  self:sync()
end

function SelectState:sync()
  if self.run.blind==BLIND_SMALL then
    self.small_blind.stat = STAT_POINTED
    self.big_blind.stat   = STAT_CREATED
    self.boss_blind.stat  = STAT_CREATED
  elseif self.run.blind==BLIND_BIG then
    self.small_blind.stat = STAT_SKIPPED
    self.big_blind.stat   = STAT_POINTED
    self.boss_blind.stat  = STAT_CREATED
  else
    self.small_blind.stat = STAT_SKIPPED
    self.big_blind.stat   = STAT_SKIPPED
    self.boss_blind.stat  = STAT_POINTED
  end
  self.boss_blind.score = ANTE_BASE[self.run.ante]*BLIND_MULT[BLIND_BOSS]
  self.big_blind.score = ANTE_BASE[self.run.ante]*BLIND_MULT[BLIND_BIG]
  self.small_blind.score = ANTE_BASE[self.run.ante]*BLIND_MULT[BLIND_SMALL]
  self.boss_blind.reward = self.run.rewards[BLIND_BOSS]
  self.big_blind.reward = self.run.rewards[BLIND_BIG]
  self.small_blind.reward = self.run.rewards[BLIND_SMALL]
end

function SelectState:update(dt)
  self:sync()
  if love.keyboard.wasPressed('z') then
    gStateStack:pop()
    gStateStack:push(PlayState(gStateStack.states[1]))
  elseif love.keyboard.wasPressed('q') then
    gStateStack:push(RunInfoState(gStateStack.states[1],false))
  elseif love.keyboard.wasPressed('c') then
    gStateStack:push(ControlState())
  elseif love.keyboard.wasPressed('x') and self.run.blind<BLIND_BOSS then
    local reward = self.small_blind.reward
    if self.run.blind==BLIND_BIG then
      reward = self.big_blind.reward
    end
    self.run:skip(reward)
    self:sync()
  end
end

function SelectState:render()
  self.small_blind:render()
  self.big_blind:render()
  self.boss_blind:render()
end
