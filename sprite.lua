--sprite.lua

require "class"

QuadBuilder = class(
   function(qb, loveNewQuad, quadWidth, quadHiegth, spriteWidth, spriteHiegth)
      qb.newQuad = loveNewQuad
      qb.quadWidth = quadWidth
      qb.quadHiegth = quadHiegth
      qb.spriteWidth = spriteWidth
      qb.spriteHiegth = spriteHiegth
   end
)

function QuadBuilder:build(x_point, y_point)
   return self.newQuad(
      x_point*self.quadWidth, y_point*self.quadHiegth,
      self.quadWidth, self.quadHiegth, self.spriteWidth, self.spriteHiegth)
end
