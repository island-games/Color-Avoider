Score ={}

function Score:New()
  score = {}
  setmetatable(score, self)
  self.__index = self
  return score
end

function Score:Draw()

  for i, value in ipairs(gameControllerObj) do
    -- Prints the score on the top of the screen
    Font.print(TextFont, 420, 10, "Score  " .. tostring(gameControllerObj[i].points), Color.new(255,255,255))
  end


end

