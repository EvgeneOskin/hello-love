--main.lua

require "character"

local character

local width = 0.0
local height = 0.0


function love.load()
   --load all assets here

   local myfont = love.graphics.newFont(45)

   love.graphics.setFont(myfont)

   love.graphics.setColor(0, 0, 0, 255)

   love.graphics.setBackgroundColor(255, 255, 0)

   width = love.graphics.getWidth( )
   height = love.graphics.getHeight( )

   character = Character(0.0, height*2.0/3.0, 1.0, Point(100.0, 1.0))

end


function love.update(dt)
   --update events
   --calculate maths

   if love.keyboard.isDown('d') then
      character:moveRight(dt, width)
   elseif love.keyboard.isDown('a') then
      character:moveLeft(dt, width)
   end

end

function love.draw()
   --describe how you want to draw

   love.graphics.print("Hello World!", width/4, height/4)

   --Draw ground
   love.graphics.rectangle(
      "fill", 0, height*2.0/3.0, width, height*1.0/3.0
   )

   --Draw person
   love.graphics.circle(
      "fill",
      character:getX(),
      character:getY(),
      character.size,
      50)
end
