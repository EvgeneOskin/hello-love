-- character.lua

require 'class'


Point = class(
   function(p, x, y)
      p.x = x
      p.y = y
   end
)

function Point:getX()
  return self.x
end

function Point:getY()
  return self.y
end


VisualObject = class(
   Point,
   function(vo, x, y, scale)
      vo.x = x
      vo.y = y
      vo.scale = scale
   end
)


Character = class(
   VisualObject,
   function(c, x, y, scale, velosities)
      VisualObject.init(c, x, y)
      c.velosities = velosities
      c.size = 10
   end
)

function Character:moveLeft(dt, width)
   self.x = self.x - dt*self.velosities.x
   self:fixXPosition(width)
end

function Character:moveRight(dt, width)
   self.x = self.x + dt*self.velosities.x
   self:fixXPosition(width)
end

function Character:fixXPosition(width)
   if self.x + self.size > width then
      self.x = width - self.size
   elseif self.x - self.size < 0 then
      self.x = self.size
   end
end
