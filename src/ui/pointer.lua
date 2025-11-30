Pointer = Class{}

DIRECTION_UP    = 0
DIRECTION_DOWN  = 1
DIRECTION_LEFT  = 2
DIRECTION_RIGHT = 3

function VerticalPointer:init(def)
  self.init_x = def.x
  self.init_y = def.y
  self.dx     = def.dx
  self.dy     = def.dy
  self.size   = def.size
  self.c      = def.color
  self:reset()
end

function VerticalPointer:reset()
  self.x = self.init_x
  self.y = self.init_y
  self.pos = 1

  self.vertices = {
    -- point A
      self.x
    , self.y

    -- point B
    , self.x-self.size
    , self.y-self.size/2

    -- point C
    , self.x-self.size
    , self.y+self.size/2
  }
end

function VerticalPointer:up()
  self.vertices[2] = self.vertices[2]-self.dy
  self.vertices[4] = self.vertices[4]-self.dy
  self.vertices[6] = self.vertices[6]-self.dy
  self.pos = self.pos-1
end

function VerticalPointer:down()
  self.vertices[2] = self.vertices[2]+self.dy
  self.vertices[4] = self.vertices[4]+self.dy
  self.vertices[6] = self.vertices[6]+self.dy
  self.pos = self.pos+1
end

function VerticalPointer:render()
  love.graphics.setColor(self.c.r/255,self.c.g/255,self.c.b/255,1)
  love.graphics.polygon("fill",self.vertices)
end
