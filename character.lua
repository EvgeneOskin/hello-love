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


AnimatedCharacter = class(
   Character,
   function(ac, x, y, scale, velosities, sprite, frames_number, quads_builder)
      Character.init(ac, x, y, scale, velosities)
      ac.sprite = sprite
      ac.iteration = 1
      ac.max_iteration = frames_number
      ac.direction = 'left'
      ac.quads = {}
      ac.quads['right'] = {}
      ac.quads['left'] = {}
      ac.quads['up'] = {}
      ac.quads['down'] = {}
      for i = 1, ac.max_iteration do
         ac.quads['right'][i] = quads_builder:build((i-1), 0)
         ac.quads['left'][i] = quads_builder:build((i-1), 0)
         ac.quads['up'][i] = quads_builder:build(1, 0)
         ac.quads['down'][i] = quads_builder:build(1, 0)
         ac.quads.left[i]:flip(true, false) -- flip horizontally x=true, y=false
      end
   end
)

function AnimatedCharacter:updateIteration()
   self.iteration = self.iteration + 1
   if self.iteration > self.max_iteration then
      self:resetIteration()
   end
end

function AnimatedCharacter:resetIteration()
   self.iteration = 1
end

function AnimatedCharacter:setDirection(direction)
   if self.quads[direction] then
      self.direction = direction
      return true
   end
   return false
end

function AnimatedCharacter:getCurrentQuad()
   return self.quads[self.direction][self.iteration]
end
