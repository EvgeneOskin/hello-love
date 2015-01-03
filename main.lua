--main.lua

require "character"
require "sprite"

local character

local width = 0.0
local height = 0.0

local Quad = love.graphics.newQuad

function love.load()
   --load all assets here

   local myfont = love.graphics.newFont(45)

   love.graphics.setFont(myfont)

   love.graphics.setColor(0, 0, 0, 255)

   love.graphics.setBackgroundColor(255, 255, 0)

   width = love.graphics.getWidth( )
   height = love.graphics.getHeight( )

   timer = 0.5

   sprite = love.graphics.newImage("character_jump.png")
   local characterQuadBuilder = QuadBuilder(
      love.graphics.newQuad, 32, 32, 384, 32)
   character = AnimatedCharacter(
      0.0, height*2.0/3.0,
      1.0, Point(100.0, 1.0),
      sprite, 12, characterQuadBuilder)

end


function love.update(dt)
   --update events
   --calculate maths

   if idle == false then
      timer = timer + dt
      if timer > 0.6 then
         timer = 0.5
         character:updateIteration()
         if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
            character:moveRight(dt, width)
         elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then
            character:moveLeft(dt, width)
         end
      end
   end
end

function love.keypressed(key)
   if character:setDirection(key) then
      idle = false
   end
end

function love.keyreleased(key)
   if character.direction == key then
      idle = true
      character:resetIteration()
   end
end

function love.draw()
   --describe how you want to draw

   love.graphics.print("Hello World!", width/4, height/4)

   --Draw ground
   love.graphics.rectangle(
      "fill", 0, height*2.0/3.0, width, height*0.0/3.0
   )

   -- Draw person
   -- love.graphics.circle(
   --    "fill",
   --    character:getX(),
   --    character:getY(),
   --    character.size,
   --    50)

   --Draw sprite
   love.graphics.drawq(
      character.sprite, character:getCurrentQuad(),
      character:getX(), character:getY(), 0, 2, 2)

end
