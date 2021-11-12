Pause = {}

function Pause:New()
  pause = {}
  setmetatable(pause, self)
  self.__index = self

  pause.shouldClose = false

  return pause

end


function Pause:Draw()

-- Draws a rectangle over the screen.  
  self.sprite =  Graphics.fillRect(0, 960, 0, 544, Color.new(0,0,0, 120)) 

  -- Prints the word pause
  self.text1 = Font.print(TextFont, 430, 270, "Paused", Color.new(255,255,255))

  -- Displays credits 
  self.text2 = Font.print(TextFont, 225, 520, "Game By: The Sucicidal Robot    Music By:8-BitWonder", Color.new(255,255,255))
end


function Pause:CheckClose()

  for i, value in ipairs(controllerObj) do
    -- Checks if start was pressed to close the pause menu
    if(controllerObj[i].startIsPressed == true and controllerObj[i].startCanBePressed == true) then
      -- Sets the pause screen to close
      self.shouldClose = true



    end
    -- This function is not called in our index class because of the early return function, so we must call the function here to change the first frame button presses.
    controllerObj[i]:GetCanPresses()
  end



end


function Pause:Update()
  self:CheckClose()  
  return self.shouldClose 
end
