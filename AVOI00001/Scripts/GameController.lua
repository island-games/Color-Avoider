GameController = {}

function GameController:New()
  gameController = {}
  setmetatable(gameController, self)
  self.__index = self
  gameController.timer = 0
  gameController.points = 0
  gameController.timeLimit = 240

  return gameController

end

-- Increases the total score by 1 point
function GameController:AddToScore()

  self.points = self.points + 1

end

-- Adds an enemy to the screen
function GameController:AddEnemy()
  -- We use a random number generator to decide what will be the color of our enemy and the direction they will start in. These 2 variables will hold the number value.
  h, m, s = System.getTime()
  math.randomseed(s)
  self.colorNum = math.random(1,4)
  self.directionNum = math.random(1,4)

  -- These two variables will hold the string values of the direction and color our enemies
  self.colorString = ""
  self.directionString = ""

  -- these 4 condition statements will decide the color of the enemy
  if(self.colorNum == 1) then
    self.colorString = "red"
  end

  if(self.colorNum == 2) then
    self.colorString = "yellow"
  end

  if(self.colorNum == 3) then
    self.colorString = "green"
  end

  if(self.colorNum == 4) then
    self.colorString = "blue"
  end

  -- These 4 condition statements will decide the enemy direction
  if(self.directionNum == 1) then

    self.directionString = "left"
  end

  if(self.directionNum == 2) then

    self.directionString = "right"
  end

  if(self.directionNum == 3) then

    self.directionString = "up"
  end

  if(self.directionNum == 4) then

    self.directionString = "down"
  end


  --[[We use these 4 statements to draw our enemy objects based off of their starting direction.
      We use 4 seperate statements instead of one universial statement because the staring position is based off the direction they are going to move, and I figured 4 condition statements would look a bit cleaner here, instead of in the New function of our enemy class. Though, you could easily put the directionString varible in place of the "up", "down", "left", and "right" string in the function. Then handle the placement in the New function of the Enemy Class.
  ]]--
  if(self.directionString == "up") then
    table.insert(enemyObj,#enemyObj + 1,Enemy:New(0,-48,960,48,"up",self.colorString))
  end

  if(self.directionString == "down") then
    table.insert(enemyObj,#enemyObj + 1,Enemy:New(0,544,960,48,"down",self.colorString))
  end

  if(self.directionString == "left") then
    table.insert(enemyObj,#enemyObj + 1,Enemy:New(-48,0,48,544,"left",self.colorString))
  end

  if(self.directionString == "right") then
    table.insert(enemyObj,#enemyObj + 1,Enemy:New(960,0,48,544,"right",self.colorString))
  end

end

-- Resets the game
function GameController:ResetGame()
  -- Resets the timer counter, the time limit, the score, and players position. It also removes all of the enemies on the screen.
  self.timer = 0
  self.points = 0
  self.timeLimit = 240
  table.insert(playerObj, #playerObj + 1, Player:New(450,300))




end

-- Creates the Gameover screen
function GameController:GameOverScreen()

  for i = #playerObj, 1, -1 do
    table.remove(playerObj, i)
  end


  for i = #enemyObj, 1, -1 do

    table.remove(enemyObj, i)

  end

  table.insert(gameOverObj, #gameOverObj + 1, GameOver:New())

end



function GameController:Update()

  -- Increases the enemy add timer by 1
  self.timer = self.timer + 1

  -- Checks if the enemy add timer is equal too or over the limit
  if(self.timer >= self.timeLimit) then
    -- Adds the enemy to the screen
    self:AddEnemy()
    -- Resets the timer
    self.timer = 0
    -- Checks if the time limit is over 40
    if(self.timeLimit >40 ) then
      -- Decreases the time limit by 5
      self.timeLimit = self.timeLimit - 5  
    end

  end

end