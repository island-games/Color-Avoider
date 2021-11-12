Player = {}
PlayerSpriteSheet =  Graphics.loadImage("app0:/Sprites/Player.png")

function Player:New(xPos,yPos)
  player = {}
  setmetatable(player, self)
  self.__index = self

  player.x = xPos
  player.y = yPos
  player.isAlive = true
  player.currentColor = "red"
  return player
end

function Player:Move()
  -- Gets the list of controller objects
  for i, value in ipairs(controllerObj) do
    -- Checks if dpad buttons are pressed, if any are pressed it will change our x or y variable.
    if(controllerObj[i].upIsPressed == true) then
      self.y = self.y -4
    end

    if(controllerObj[i].leftIsPressed == true) then
      self.x = self.x - 4
    end

    if(controllerObj[i].rightIsPressed == true) then
      self.x = self.x + 4
    end

    if(controllerObj[i].downIsPressed == true) then
      self.y = self.y + 4
    end
    -- Check if player is off the screen to the left, if true keeps the player in bounds
    if(self.x < 0) then
      self.x = 0  
    end

    -- Check if the player if off the screen on the right, if true keeps the player in bounds
    if(self.x > 928) then

      self.x = 928
    end


    -- Check if the player is off the screen on the top, if true keeps the player in bounds
    if(self.y < 0) then
      self.y = 0  
    end

    -- Check if the player is off the screen on the bottom, if true keeps player in bounds
    if(self.y > 512) then

      self.y = 512  
    end


  end

end

function Player:ChangeColor()

  -- Changes the color of the player based off the button presses
  for i, value in ipairs(controllerObj) do

    -- If triangle is pressed the player will turn red
    if(controllerObj[i].triangleIsPressed == true and controllerObj[i].triangleCanBePressed == true) then
      self.currentColor = "red"
    end

    -- If circle is pressed the player will turn yellow
    if(controllerObj[i].circleIsPressed == true and controllerObj[i].circleCanBePressed == true) then
      self.currentColor = "yellow"
    end

    -- If cross is pressed the player will turn green
    if(controllerObj[i].crossIsPressed == true and controllerObj[i].crossCanBePressed == true) then
      self.currentColor = "green"
    end

    -- If square is pressed the player will turn blue
    if(controllerObj[i].squareIsPressed == true and controllerObj[i].squareCanBePressed == true) then
      self.currentColor = "blue"
    end


  end
end


function Player:CheckCollision()
  for i = #enemyObj, 1, -1 do

    -- Gets the dimension and color of the current enemy object and adds them to the array in this order left, right, top, bottom, and color
    self.dimensions =  enemyObj[i]:GetDimensions()
    -- compares the player right side to the enemies left side and then compares the players left side to the enemies right.
    if(self.x + 32 > self.dimensions[1] and self.x < self.dimensions[2]) then

      -- compares the players bottom side to the enemies top side and compares the players top side to the enemies bottom side
      if(self.y + 32 > self.dimensions[3] and self.y < self.dimensions[4]) then

        -- Compares the players current color to the color of the enemy, if the colors dont match it executes code
        if(self.currentColor ~= self.dimensions[5]) then

          for i, value in ipairs(gameControllerObj) do
            -- Ends the game
            gameControllerObj[i]:GameOverScreen()

          end
          -- breaks from the enemy do for statement, without this break it will throw can throw an error looking for objects that no longer exist.
          break
        end

      end


    end


  end

end

function Player:Draw()

  -- Checks the color of the player, and if the color of the player is equal to the value we are checking then it will the selected frame from the sprite sheet.

  if(self.currentColor == "red") then
    Graphics.drawImageExtended(self.x, self.y, 0, 0, 32, 32, 1, 1, PlayerSpriteSheet)
  end

  if(self.currentColor == "yellow") then
    Graphics.drawImageExtended(self.x, self.y, 31, 0, 32, 32, 1, 1, PlayerSpriteSheet)
  end

  if(self.currentColor == "green") then
    Graphics.drawImageExtended(self.x, self.y, 0, 31, 32, 32, 1, 1, PlayerSpriteSheet)
  end

  if(self.currentColor == "blue") then
    Graphics.drawImageExtended(self.x, self.y, 31, 31, 32, 32, 1, 1, PlayerSpriteSheet)
  end


end



function Player:PauseGame()
  -- Checks if a Pause screen already exist
  if(#pauseObj > 0) then
    return  
  end


  for i, value in ipairs(controllerObj) do

    -- Checks if the start button has been pressed
    if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
      -- Creates the pause screen
      table.insert(pauseObj, #pauseObj + 1, Pause:New())

    end

  end

end


function Player:Update()
  -- Players update function
  self:ChangeColor()
  self:Move()
  self:CheckCollision()
  self:PauseGame()
end
