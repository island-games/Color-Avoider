GameOver = {}

function GameOver:New()
  gameOver = {}
  setmetatable(gameOver, self)
  self.__index = self

  gameOver.shouldClose = false

  return gameOver

end


function GameOver:Draw()

  -- Draws a rectangle over the screen
  self.sprite =  Graphics.fillRect(0, 960, 0, 544, Color.new(0,0,0, 120)) 
  for i, value in ipairs(gameControllerObj) do
    -- Displays game over text and final score
    self.text1 = Font.print(TextFont, 400, 270, "Game Over Final Score: " .. tostring(gameControllerObj[i].points), Color.new(255,255,255))

    -- Displays the credits
    self.text2= Font.print(TextFont, 225, 520, "Game By: The Sucicidal Robot    Music By:8-BitWonder", Color.new(255,255,255))
  end


end

function GameOver:CheckClose()

  for i, value in ipairs(controllerObj) do
    -- Checks if start was pressed to close the gameOverScreen
    if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
      -- Sets the screen to close
      self.shouldClose = true


    end
    -- This function is not called in our index class because of the early return function, so we must call the function here to change the first frame button presses.
    controllerObj[i]:GetCanPresses()
  end

end


function GameOver:Update()
  self:CheckClose()
  return self.shouldClose
end
