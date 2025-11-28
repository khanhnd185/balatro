RunState = Class{__includes = BaseState}

function RunState:init(deck_type)
  self.deck_type  = deck_type
  self.ante       = 1
  self.blind      = BLIND_SMALL
  self.money      = 4
  self.hand       = 5
  self.discard    = 3
  self.round      = 0
end

function RunState:update(dt)
end

function RunState:render()
  -- render money
  
end
