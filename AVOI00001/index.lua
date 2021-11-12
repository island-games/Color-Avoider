-- Loads all Lua files that requried to play our game
require("app0:/scripts/Player")
require("app0:/scripts/Enemy")
require("app0:/scripts/Controller")
require("app0:/scripts/GameController")
require("app0:/scripts/Score")
require("app0:/scripts/Pause")
require("app0:/scripts/GameOver")

-- Sets the CPU speed of our game to the max clock speed
System.setCpuSpeed(444) 

-- initializes our sound engine
Sound.init() 
-- loads our song
song = Sound.openMp3("app0:/CityLights.mp3")
-- plays the song and loops it forever
Sound.play(song,LOOP) 

-- Loads our font
TextFont = Font.load("app0:/Fonts/6809chargen.ttf")

-- A list of tables, each one will hold specific game objects
playerObj = {}
enemyObj = {}
pauseObj = {}
gameOverObj = {}
gameControllerObj = {}
controllerObj = {}
scoreObj = {}

-- Our timer which will control our framerate
timerObj = Timer.new()





function StartGame()
  -- Creates our controller, player, game controller, and score game objects and adds each to their table
   table.insert(controllerObj,#controllerObj + 1,Controller:New())
  table.insert(playerObj,#playerObj + 1,Player:New(450,300))
  table.insert(gameControllerObj, #gameControllerObj + 1, GameController:New())
  table.insert(scoreObj, #scoreObj + 1, Score:New())
end


function UpdateGame()
  --Updates for all game logic
  for i, value in ipairs(pauseObj) do
  isDead = pauseObj[i]:Update()
  
  -- Checks if our pause screen should close
  if(isDead == true) then
    -- Removes the pause screen
  table.remove(pauseObj,i)  

  end
  
    return
  end
  
  
  for i, value in ipairs(gameOverObj) do
    isDead = gameOverObj[i]:Update()  
    
    if(isDead == true) then
      
    table.remove(gameOverObj, i)  
    
     for y, value in ipairs(gameControllerObj) do
     gameControllerObj[y]:ResetGame()  
     end
     
    end
    
    return
  end
  
  
   for i, value in ipairs(playerObj) do
     -- The Update for all player objects
    playerObj[i]:Update()
  end
  
  for i = #enemyObj, 1, -1 do
    -- Update for all enemy objects, it also returns the alive state of the object. If the returned value is true, it removes the object.
   isDead = enemyObj[i]:Update()
   if(isDead == true) then
     for y, value in ipairs(gameControllerObj) do
        gameControllerObj[y]:AddToScore()
       end
      table.remove(enemyObj, i)
   end
  end
  
   for i, value in ipairs(gameControllerObj) do
     -- Updates our game logic controller.
    gameControllerObj[i]:Update()
  end
  
  
  
  for i, value in ipairs(controllerObj) do
    -- Gets the "was the button was pressed on the current frame" boolean value
    controllerObj[i]:GetCanPresses()
  end
end

  -- Draws all of the objects on screen.
function Draw()  
  --  Starts the drawing process. This function must be called to draw anything to the screen
  Graphics.initBlend() 
  
  -- Clears the screen of anything drawn from the last cycle.
  Screen.clear()
   
   -- Draws the player
  for i, value in ipairs(playerObj) do
    playerObj[i]:Draw()
  end
  
  -- Draws the enemies
  for i, value in ipairs(enemyObj) do
    enemyObj[i]:Draw()
  end
  
  -- Draws the score keeping object
  for i, value in ipairs(scoreObj) do
    scoreObj[i]:Draw()
  end
  
  
  -- Draws the pause screen
  for i, value in ipairs(pauseObj) do
    pauseObj[i]:Draw()
  end
  
  -- Draws the gameover screen
  for i, value in ipairs(gameOverObj) do
    gameOverObj[i]:Draw()  
  end
  

  Screen.flip()
  -- Ends the draw the process for the current cycle
  Graphics.termBlend()
  
end
StartGame()

while(true) do
  for i, value in ipairs(controllerObj) do
    -- Gets button presses and releases
    controllerObj[i]:GetButtonPresses()
  end
  
  Draw()
  -- Checks if enough time has passed to update game logic
  if(Timer.getTime(timerObj) >= 16.7) then
      -- Resets the logic timer
    Timer.reset(timerObj)
    
    -- Executes the game logic update loop
    UpdateGame()
  
  end
  
end
