Controller = {}

function Controller:New()
  controller = {}
  setmetatable(controller, self)
  self.__index = self

  controller.leftIsPressed = false
  controller.rightIsPressed = false
  controller.upIsPressed = false
  controller.downIsPressed = false
  controller.squareIsPressed = false
  controller.triangleIsPressed = false
  controller.circleIsPressed = false
  controller.crossIsPressed = false
  controller.startIsPressed = false

  controller.squareCanBePressed = false
  controller.crossCanBePressed = false
  controller.circleCanBePressed = false
  controller.triangleCanBePressed = false
  controller.startCanBePressed = false

  return controller
end

function Controller:GetButtonPresses()

  -- Check if buttons are pressed if they are then it sets the boolean to true, if buttons are released it sets the boolean to false

  if(Controls.check(Controls.read(),SCE_CTRL_UP)) then
    self.upIsPressed = true
  else
    self.upIsPressed = false
  end

  if(Controls.check(Controls.read(),SCE_CTRL_DOWN)) then
    self.downIsPressed = true
  else
    self.downIsPressed = false
  end

  if(Controls.check(Controls.read(),SCE_CTRL_LEFT)) then
    self.leftIsPressed = true
  else
    self.leftIsPressed = false
  end

  if(Controls.check(Controls.read(),SCE_CTRL_RIGHT)) then
    self.rightIsPressed = true
  else
    self.rightIsPressed = false
  end

  if(Controls.check(Controls.read(),SCE_CTRL_CROSS)) then
    self.crossIsPressed = true
  else
    self.crossIsPressed = false
  end

  if(Controls.check(Controls.read(),SCE_CTRL_TRIANGLE)) then
    self.triangleIsPressed = true
  else
    self.triangleIsPressed = false
  end

  if(Controls.check(Controls.read(),SCE_CTRL_SQUARE)) then
    self.squareIsPressed = true
  else
    self.squareIsPressed = false
  end
  if(Controls.check(Controls.read(),SCE_CTRL_CIRCLE)) then
    self.circleIsPressed = true
  else
    self.circleIsPressed = false
  end  

  if(Controls.check(Controls.read(),SCE_CTRL_START)) then
    self.startIsPressed = true
  else
    self.startIsPressed = false
  end  

end

function Controller:GetCanPresses()

  -- The can be pressed ensures that an action is only done once per button press, instead of each frame the button is pressed.
  -- In some cases you will want an action to be executed each frame of a button press such as in movement, which is why we are not checking for those button presses.

  if(self.squareIsPressed == false) then
    self.squareCanBePressed = true
  else
    self.squareCanBePressed = false
  end

  if(self.crossIsPressed == false) then
    self.crossCanBePressed = true
  else
    self.crossCanBePressed = false
  end

  if(self.circleIsPressed == false) then
    self.circleCanBePressed = true
  else
    self.circleCanBePressed = false
  end

  if(self.triangleIsPressed == false) then
    self.triangleCanBePressed = true
  else
    self.triangleCanBePressed = false
  end


  if(self.startIsPressed == false) then
    self.startCanBePressed = true
  else
    self.startCanBePressed = false
  end


end
