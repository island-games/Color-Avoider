Enemy = {}

function Enemy:New(xPos,yPos,widths,heights,directions,colors)
  enemy = {}
  setmetatable (enemy, self)
  self.__index = self

  enemy.color = colors
  enemy.x = xPos
  enemy.y = yPos
  enemy.width = widths
  enemy.height = heights
  enemy.direction = directions
  enemy.isDead = false
  return enemy
end

function Enemy:Draw()
  -- Enemies are drawn using LPP rectangle function instead of using a sprite sheet

  -- Checks if the color type is red
  if(self.color == "red") then
    -- Draws a red enemy
    self.sprite =  Graphics.fillRect(self.x, self.x + self.width, self.y, self.height + self.y, Color.new(255,0,0)) 
  end


  -- Checks if the color type is yellow
  if(self.color == "yellow") then
    -- Draws a yellow enemy
    self.sprite =  Graphics.fillRect(self.x, self.x + self.width, self.y, self.height + self.y, Color.new(255,255,0)) 
  end


  -- Checks if the color type is green
  if(self.color == "green") then
    -- Draws a green enemy
    self.sprite =   Graphics.fillRect(self.x, self.x + self.width, self.y, self.height + self.y, Color.new(0,255,0)) 
  end


  -- Checks if the color type is blue
  if(self.color == "blue") then
    -- Draws a blue enemy
    self.sprite =  Graphics.fillRect(self.x, self.x + self.width, self.y, self.height + self.y, Color.new(0,0,255)) 
  end


end

function Enemy:Move()
  -- Moves the enemies based on their direction

  if(self.direction == "left") then
    self.x = self.x + 10
  end

  if(self.direction == "right") then
    self.x = self.x - 10
  end

  if(self.direction == "up") then
    self.y = self.y + 10
  end

  if(self.direction == "down") then
    self.y = self.y - 10
  end

end

function Enemy:CheckDeathPosition()
  -- Checks enemies current position, if the enemy is out of bounds it will be marked as dead
  if(self.x < - 50) then
    self.isDead = true
  end

  if(self.x > 1000) then
    self.isDead = true

  end


  if(self.y < - 50) then

    self.isDead = true
  end


  if(self.y > 630) then
    self.isDead = true
  end



end

function Enemy:GetDimensions()
  -- creates a table of the enemies dimensions, and color {left, right, top, bottom, enemy color}
  self.dim = {[1] = self.x, [2] = self.x + self.width, [3] = self.y, [4] = self.y + self.height, [5] = self.color}  
  -- returns the table
  return self.dim
end


function Enemy:Update()

  self:Move()
  self:CheckDeathPosition()
  return self.isDead
end
