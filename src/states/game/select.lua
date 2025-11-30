SelectState = Class{__includes = BaseState}

function SelectState:init(run_info)
  self.run_info = run_info

  local x = 320
  local y = 200
  local stat_small = STAT_CREATED
  local stat_big   = STAT_CREATED
  local stat_boss  = STAT_CREATED

  if self.run_info.blind==BLIND_SMALL then
    stat_small = STAT_POINTED
  elseif self.run_info.blind==BLIND_BIG then
    stat_small = STAT_SKIPPED
    stat_big   = STAT_POINTED
  else
    stat_small = STAT_SKIPPED
    stat_big   = STAT_SKIPPED
    stat_boss  = STAT_POINTED
  end

  self.small_blind = BlindPanel({
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
    , stat = stat_small
    , score = ANTE_BASE[self.run_info.ante]*BLIND_MULT[BLIND_SMALL]
  })

  x = x+280
  self.big_blind = BlindPanel({
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
    , stat = stat_big
    , score = ANTE_BASE[self.run_info.ante]*BLIND_MULT[BLIND_BIG]
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
    , stat = stat_boss
    , score = ANTE_BASE[self.run_info.ante]*BLIND_MULT[BLIND_BOSS]
  })
end

function SelectState:update(dt)
  if love.keyboard.wasPressed('z') then
    gStateStack:pop()
    gStateStack:push(PlayState(gStateStack.states[#gStateStack.states]))
  end
end

function SelectState:render()
  self.small_blind:render()
  self.big_blind:render()
  self.boss_blind:render()
end
