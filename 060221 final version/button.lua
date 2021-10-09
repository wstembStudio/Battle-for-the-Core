function newMenuButton(text, fn)
  return {
    text = text,
    fn = fn,
    
    last = false,
    now = false
  }
end
function newSettingsButton(text, fn)
  return {
    text = text,
    fn = fn,
    
    last = false,
    now = false
  }
end
function newDifficultyButton(text, fn)
  return {
    text = text,
    fn = fn,
    
    last = false,
    now = false
  }
end
function newPlayerButton(text, fn)
  return {
    text = text,
    fn = fn,
    
    last = false,
    now = false,
    last2 = false,
    now2 = false
  }
end
function newPopulationButton(text, fn)
  return {
    text = text,
    fn = fn,
    
    last = false,
    now = false
  }
end
function newBatimentButton(text, fn)
  return {
    text = text,
    fn = fn,
    
    last = false,
    now = false
  }
end
function newBonusButton(text, fn)
  return {
    text = text,
    fn = fn,
    
    last = false,
    now = false
  }
end
function newMoveButton(text, fn)
  return {
    text = text,
    fn = fn,
    
    last = false,
    now = false,
    last2 = false,
    now2 = false
  }
end
function ButtonMenu()
  table.insert(menuButton, newMenuButton(
    "START GAME", 
    function()
      menuSound:stop()
      menuSound:play()
      g_display.currentStage = DIFFICULTY_STAGE
    end))
  table.insert(menuButton, newMenuButton(
    "SETTINGS", 
    function()
      menuSound:stop()
      menuSound:play()
      bipSound:play()
      g_display.currentStage = SETTING_STAGE
    end))
  table.insert(menuButton, newMenuButton(
    "CONTROLS", 
    function()
      menuSound:stop()
      menuSound:play()
      g_display.currentStage = CONTROLS_STAGE
    end))
  table.insert(menuButton, newMenuButton(
    "RULES", 
    function()
      menuSound:stop()
      menuSound:play()
      g_display.currentStage = RULES_STAGE
    end))
  table.insert(menuButton, newMenuButton(
    "EXIT", 
    function()
      menuSound:stop()
      menuSound:play()
      love.event.quit()
    end))
end
function ButtonSettings()
  table.insert(settingsButton, newSettingsButton(
    "Background", 
    function()
      settingSound:play()
      if g_display.backGround == false then
        g_display.backGround = true
      elseif g_display.backGround == true then
        g_display.backGround = false
      end
    end))
  table.insert(settingsButton, newSettingsButton(
    "Meteorite", 
    function()
      settingSound:play()
      if g_display.meteorite == false then
        g_display.meteorite = true
      elseif g_display.meteorite == true then
        g_display.meteorite = false
      end
    end))
  table.insert(settingsButton, newSettingsButton(
    "BlackHole", 
    function()
      settingSound:play()
      if g_display.blackHole == false then
        g_display.blackHole = true
      elseif g_display.blackHole == true then
        g_display.blackHole = false
      end
    end))
  table.insert(settingsButton, newSettingsButton(
    "StarKiller", 
    function()
      settingSound:play()
      if g_display.starKiller == false then
        g_display.starKiller = true
      elseif g_display.starKiller == true then
        g_display.starKiller = false
      end
    end))
  table.insert(settingsButton, newSettingsButton(
    "Bonus", 
    function()
      settingSound:play()
      if g_display.bonus == false then
        g_display.bonus = true
      elseif g_display.bonus == true then
        g_display.bonus = false
      end
    end))
end
function ButtonDifficulty()
  table.insert(difficultyButton, newDifficultyButton(
    "EASY", 
    function()
      menuSound:stop()
      menuSound:play()
      g_display.currentDifficulty = EASY_DIFFICULTY
      g_display.currentStage = ADMIRAL_STAGE
      updateBotTimer()
    end))
  table.insert(difficultyButton, newDifficultyButton(
    "MEDIUM", 
    function()
      menuSound:stop()
      menuSound:play()
      g_display.currentDifficulty = MEDIUM_DIFFICULTY
      g_display.currentStage = ADMIRAL_STAGE
      updateBotTimer()
    end))
  table.insert(difficultyButton, newDifficultyButton(
    "DIFFICULT", 
    function()
      menuSound:stop()
      menuSound:play()
      g_display.currentDifficulty = DIFFICULT_DIFFICULTY
      g_display.currentStage = ADMIRAL_STAGE
      updateBotTimer()
    end))
  table.insert(difficultyButton, newDifficultyButton(
    "HARD", 
    function()
      menuSound:stop()
      menuSound:play()
      g_display.currentDifficulty = HARD_DIFFICULTY
      g_display.currentStage = ADMIRAL_STAGE
      updateBotTimer()
    end))
end
function ButtonPlayer()
  table.insert(playerButton, newPlayerButton(
      "Admiral Wullf Yularen", 
      function(admiral)
        if admiral == "Yularen1" then
          player1.team = player1.team + 1
          if player1.team > 4 then
            player1.team = 0
          end
        elseif admiral == "Yularen2" then
          if player1.you == false then
            player1.you = true
          elseif player1.you == true then
            player1.you = false
          end
        end
      end))
  table.insert(playerButton, newPlayerButton(
      "Admiral Trench", 
        function(admiral)
        if admiral == "Trench1" then
          player2.team = player2.team + 1
          if player2.team > 4 then
            player2.team = 0
          end
        elseif admiral == "Trench2" then
          if player2.you == false then
            player2.you = true
          elseif player2.you == true then
            player2.you = false
          end
        end
      end))
  table.insert(playerButton, newPlayerButton(
      "Admiral Gial Ackbar", 
      function(admiral)
        if admiral == "Ackbar1" then
          player3.team = player3.team + 1
          if player3.team > 4 then
            player3.team = 0
          end
        elseif admiral == "Ackbar2" then
          if player3.you == false then
            player3.you = true
          elseif player3.you == true then
            player3.you = false
          end
        end
      end))
  table.insert(playerButton, newPlayerButton(
      "Grand Admiral Thrawn", 
      function(admiral)
        if admiral == "Thrawn1" then
          player4.team = player4.team + 1
          if player4.team > 4 then
            player4.team = 0
          end
        elseif admiral == "Thrawn2" then
          if player4.you == false then
            player4.you = true
          elseif player4.you == true then
            player4.you = false
          end
        end
      end))
end
function ButtonPopulation()
  table.insert(populationButton, newPopulationButton(
      "Colon :X", 
      function()
        if g_selectedPlanet.nbInhabitant >= 1 then
          g_selectedPlanet.nbInhabitant = g_selectedPlanet.nbInhabitant - 1
          g_selectedPlanet.nbColon = g_selectedPlanet.nbColon + 1
        end
      end))
  table.insert(populationButton, newPopulationButton(
      "Worker :C", 
      function()
        if g_selectedPlanet.nbInhabitant >= 1 then
          g_selectedPlanet.nbInhabitant = g_selectedPlanet.nbInhabitant - 1
          g_selectedPlanet.nbWorker = g_selectedPlanet.nbWorker + 1
        end
      end))
  table.insert(populationButton, newPopulationButton(
      "Scientist :V", 
      function()
        if g_selectedPlanet.nbInhabitant >= 1 then
          g_selectedPlanet.nbInhabitant = g_selectedPlanet.nbInhabitant - 1
          g_selectedPlanet.nbScientist = g_selectedPlanet.nbScientist + 1
        end
      end))
  table.insert(populationButton, newPopulationButton(
      "Soldier :B", 
      function()
        if g_selectedPlanet.nbInhabitant >= 1 then
          g_selectedPlanet.nbInhabitant = g_selectedPlanet.nbInhabitant - 1
          g_selectedPlanet.nbSoldier = g_selectedPlanet.nbSoldier + 1
        end
      end))
end
function ButtonBatiment()
  table.insert(batimentButton, newBatimentButton(
      "City", 
      function()
        cityUpgrade(g_selectedPlanet, youPlayer("player"))
      end))
  table.insert(batimentButton, newBatimentButton(
      "Mine", 
      function()
        mineUpgrade(g_selectedPlanet, youPlayer("player"))
      end))
  table.insert(batimentButton, newBatimentButton(
      "Laboratory", 
      function()
        laboratoryUpgrade(g_selectedPlanet, youPlayer("player"))
      end))
  table.insert(batimentButton, newBatimentButton(
      "War Base", 
      function()
        warBaseUpgrade(g_selectedPlanet, youPlayer("player"))
      end))
end
function ButtonBonus()
  table.insert(bonusButton, newBonusButton(
      "HyperSpace", 
      function()
        hyperSpaceBonus(youPlayer("player"))
      end))
  table.insert(bonusButton, newBonusButton(
      "Virus", 
      function()
        virusBonus(youPlayer("player"))
      end))
  table.insert(bonusButton, newBonusButton(
      "Destroyer", 
      function()
        destroyerBonus(youPlayer("player"))
      end))
  table.insert(bonusButton, newBonusButton(
      "SpaceJump", 
      function()
        spaceJumpBonus(youPlayer("player"))
      end))
  table.insert(bonusButton, newBonusButton(
      "Shield", 
      function()
        shieldBonus(youPlayer("player"))
      end))
end
function ButtonMove()
  table.insert(moveButton, newMoveButton(
      "Inhabitant :A", 
      function(nb)
        if nb == 1 then
          if g_selectedPlanet.nbInhabitant >= 1 then
            g_selectedPlanet.nbInhabitant = g_selectedPlanet.nbInhabitant - 1
            g_selectedPlanet.moveInhabitant = g_selectedPlanet.moveInhabitant + 1
          end
        elseif nb == -1 then
          if g_selectedPlanet.moveInhabitant >= 1 then
            g_selectedPlanet.moveInhabitant = g_selectedPlanet.moveInhabitant - 1
            g_selectedPlanet.nbInhabitant = g_selectedPlanet.nbInhabitant + 1
          end
        end
      end))
  table.insert(moveButton, newMoveButton(
      "Colon :Z", 
      function(nb)
        if nb == 1 then
          if g_selectedPlanet.nbColon >= 1 then
            g_selectedPlanet.nbColon = g_selectedPlanet.nbColon - 1
            g_selectedPlanet.moveColon = g_selectedPlanet.moveColon + 1
          end
        elseif nb == -1 then
          if g_selectedPlanet.moveColon >= 1 then
            g_selectedPlanet.moveColon = g_selectedPlanet.moveColon - 1
            g_selectedPlanet.nbColon = g_selectedPlanet.nbColon + 1
          end
        end
      end))
  table.insert(moveButton, newMoveButton(
      "Worker :E", 
      function(nb)
        if nb == 1 then
          if g_selectedPlanet.nbWorker >= 1 then
            g_selectedPlanet.nbWorker = g_selectedPlanet.nbWorker - 1
            g_selectedPlanet.moveWorker = g_selectedPlanet.moveWorker + 1
          end
        elseif nb == -1 then
          if g_selectedPlanet.moveWorker >= 1 then
            g_selectedPlanet.moveWorker = g_selectedPlanet.moveWorker - 1
            g_selectedPlanet.nbWorker = g_selectedPlanet.nbWorker + 1
          end
        end
      end))
  table.insert(moveButton, newMoveButton(
      "Scientist :R", 
      function(nb)
        if nb == 1 then
          if g_selectedPlanet.nbScientist >= 1 then
            g_selectedPlanet.nbScientist = g_selectedPlanet.nbScientist - 1
            g_selectedPlanet.moveScientist = g_selectedPlanet.moveScientist + 1
          end
        elseif nb == -1 then
          if g_selectedPlanet.moveScientist >= 1 then
            g_selectedPlanet.moveScientist = g_selectedPlanet.moveScientist - 1
            g_selectedPlanet.nbScientist = g_selectedPlanet.nbScientist + 1
          end
        end
      end))
  table.insert(moveButton, newMoveButton(
      "Soldier :T", 
      function(nb)
        if nb == 1 then
          if g_selectedPlanet.nbSoldier >= 1 then
            g_selectedPlanet.nbSoldier = g_selectedPlanet.nbSoldier - 1
            g_selectedPlanet.moveSoldier = g_selectedPlanet.moveSoldier + 1
          end
        elseif nb == -1 then
          if g_selectedPlanet.moveSoldier >= 1 then
            g_selectedPlanet.moveSoldier = g_selectedPlanet.moveSoldier - 1
            g_selectedPlanet.nbSoldier = g_selectedPlanet.nbSoldier + 1
          end
        end
      end))
end
function buttonHot()
  local screenHeight = 200
  local screenWidth = 300
  local admiralHeight = 200
  local admiralWidth = 150
  local viewHeight = g_height/1.75
  local viewWidth = 200
  local moveHeight = 80
  local moveWidth = g_width
  local infoHeight = 40
  local infoWidth = g_width
  if g_selectedPlanet ~= nil and g_selectedPlanet.admiral == youPlayer("admiral") then
    if (mx >= 0 and mx <= infoWidth and my >= 0 and my <= infoHeight) or
    (mx >= 0 and mx <= admiralWidth and my >= 0 and my <= admiralHeight) or
    (mx >= g_width-admiralWidth and mx <= g_width and my >= 0 and my <= admiralHeight) or
    (mx >= 0 and mx <= viewWidth and my >= g_height-screenHeight-viewHeight and my <= g_height) or
    (mx >= g_width-viewWidth and mx <= g_width and my >= g_height-screenHeight-viewHeight and my <= g_height) or
    (mx >= 0 and mx <= screenWidth and my >= g_height-screenHeight and my <= g_height) or
    (mx >= g_width-screenWidth and mx <= g_width and my >= g_height-screenHeight and my <= g_height) or
    (mx >= 0 and mx <= moveWidth and my >= g_height-moveHeight and my <= g_height) then
      return true
    else
      return false
    end
  elseif g_selectedPlanet ~= nil and g_selectedPlanet.admiral ~= youPlayer("admiral") then
    if (mx >= 0 and mx <= infoWidth and my >= 0 and my <= infoHeight) or
    (mx >= 0 and mx <= admiralWidth and my >= 0 and my <= admiralHeight) or
    (mx >= g_width-admiralWidth and mx <= g_width and my >= 0 and my <= admiralHeight) or
    (mx >= 0 and mx <= viewWidth and my >= g_height-screenHeight-viewHeight and my <= g_height) or
    (mx >= 0 and mx <= screenWidth and my >= g_height-screenHeight and my <= g_height) or
    (mx >= g_width-screenWidth and mx <= g_width and my >= g_height-screenHeight and my <= g_height) or
    (mx >= 0 and mx <= moveWidth and my >= g_height-moveHeight and my <= g_height) then
      return true
    else
      return false
    end
  elseif g_selectedPlanet == nil then
     if (mx >= 0 and mx <= infoWidth and my >= 0 and my <= infoHeight) or
    (mx >= 0 and mx <= admiralWidth and my >= 0 and my <= admiralHeight) or
    (mx >= g_width-admiralWidth and mx <= g_width and my >= 0 and my <= admiralHeight) or
    (mx >= 0 and mx <= screenWidth and my >= g_height-screenHeight and my <= g_height) or
    (mx >= g_width-screenWidth and mx <= g_width and my >= g_height-screenHeight and my <= g_height) or
    (mx >= 0 and mx <= moveWidth and my >= g_height-moveHeight and my <= g_height) then
      return true
    else
      return false
    end
  end
end
function DrawMenuButton(button_width, button_height, margin, textOffset)
  local now = false
  local last = false
  
  local cursor_y = 0

  for i, button in ipairs(menuButton) do
    button.last = button.now
    local bx = 0
    local by = 550 + cursor_y
    local color = {0,0,0,0.3}
    local mx , my = love.mouse.getPosition()
    local hot = mx > bx  and mx < bx + button_width and my > by and my < by + button_height

    if hot then
      color = {0.5,0.5,0.5}
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, button_width, button_height)

    love.graphics.setColor(1,1,1)
    --love.graphics.rectangle("line", bx , by, button_width, button_height)
    love.graphics.print(button.text, bx + textOffset, by + 1/4*button_height, 0, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)

    cursor_y = cursor_y + margin + button_height
  end
end
function DrawSettingsButton(button_width, button_height, textOffset, marginY, marginX, button_Y)
  local now = false
  local last = false
  
  local cursor_y = 0

  for i, button in ipairs(settingsButton) do
    button.last = button.now
    local bx = g_width - marginX - button_width
    local by = button_Y + cursor_y
    local color = {0,0,0,0.3}
    local mx , my = love.mouse.getPosition()
    local hot = mx > bx  and mx < bx + button_width and my > by and my < by + button_height

    if hot then
      color = {0.5,0.5,0.5,0.5}
    elseif g_display.backGround == true and i == 1 then
      color = {1,1,1}
    elseif g_display.meteorite == true and i == 2 then
      color = {1,1,1}
    elseif g_display.blackHole == true and i == 3 then
      color = {1,1,1}
    elseif g_display.starKiller == true and i == 4 then
      color = {1,1,1}
    elseif g_display.bonus == true and i == 5 then
      color = {1,1,1}
    end
    
    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end
    
    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, button_width, button_height)

    love.graphics.setColor(1,1,0)
    love.graphics.rectangle("line", bx , by, button_width, button_height)
    love.graphics.print(button.text, bx, by - textOffset, 0, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)

    cursor_y = cursor_y + marginY + button_height
  end
end
function DrawDifficultyButton(button_width, button_height, margin, textOffset)
  local now = false
  local last = false
  
  local cursor_y = 0

  for i, button in ipairs(difficultyButton) do
    button.last = button.now
    local bx = g_width/2
    local by = 550 + cursor_y
    local color = {0,0,0,0.3}
    local mx , my = love.mouse.getPosition()
    local hot = mx > bx  and mx < bx + button_width and my > by and my < by + button_height

    if hot then
      color = {0.5,0.5,0.5}
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, button_width, button_height)

    love.graphics.setColor(1,1,1)
    --love.graphics.rectangle("line", bx , by, button_width, button_height)
    love.graphics.print(button.text, bx + textOffset, by + 1/4*button_height, 0, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)

    cursor_y = cursor_y + margin + button_height
  end
end
function DrawPlayerButton()
  local now1 = false
  local now2 = false
  local last1 = false
  local last2 = false

  local button_width = 400
  local button_height = g_height

  local margin = (g_width - 4*button_width) / 5
  local cursor_x = 0

  for i, button in ipairs(playerButton) do
    button.last1 = button.now1
    button.last2 = button.now2
    local bx = margin + cursor_x
    local by = 0
    local colorRepublic = { 30/255,144/255,255/255, 0.2}
    local colorCIS = { 0, 1, 0, 0.2}
    local colorRebel = { 1, 0.5, 0, 0.2}
    local colorEmpire = { 1, 0, 0, 0.2}
    local mx , my = love.mouse.getPosition()
    local hotRepublic = mx > margin  and mx < button_width + margin
    local hotCIS = mx > 1*button_width + 2*margin  and mx < 2*button_width + 2*margin
    local hotRebel = mx > 2*button_width + 3*margin  and mx < 3*button_width + 3*margin
    local hotEmpire = mx > 3*button_width + 4*margin  and mx < 4*button_width + 4*margin 
    
    
    if hotRepublic then
      colorRepublic = { 30/255,144/255,255/255, 1}
      
    elseif hotCIS then
      colorCIS = { 0, 1, 0, 1}
      
    elseif hotRebel then
      colorRebel = { 1, 0.5, 0, 1}
      
    elseif hotEmpire then
      colorEmpire = { 1, 0, 0, 1}
    end

    button.now1 = love.mouse.isDown(1)
    if button.now1 and not button.last1 and hotRepublic then
      button.fn("Yularen1")
    elseif button.now1 and not button.last1 and hotCIS then
      button.fn("Trench1")
    elseif button.now1 and not button.last1 and hotRebel then
      button.fn("Ackbar1")
    elseif button.now1 and not button.last1 and hotEmpire then
      button.fn("Thrawn1")
    end
    
    button.now2 = love.mouse.isDown(2)
    if button.now2 and not button.last2 and hotRepublic then
      button.fn("Yularen2")
    elseif button.now2 and not button.last2 and hotCIS then
      button.fn("Trench2")
    elseif button.now2 and not button.last2 and hotRebel then
      button.fn("Ackbar2")
    elseif button.now2 and not button.last2 and hotEmpire then
      button.fn("Thrawn2")
    end

    local team = nil
    local you = nil
    local color = nil
    if i == 1 then
      color = colorRepublic
      team = player1.team
      you = player1.you
    elseif i == 2 then
      color = colorCIS
      team = player2.team
      you = player2.you
    elseif i == 3 then
      color = colorRebel
      team = player3.team
      you = player3.you
    elseif i == 4 then
      color = colorEmpire
      team = player4.team
      you = player4.you
    end
    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, button_width, button_height)
    
    local textSize = 2
    local spaceX = 250
    local spaceY = 40
    
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", bx, 0, button_width, spaceY)
    love.graphics.rectangle("fill", bx, g_height-spaceY, button_width, button_height)
    
    love.graphics.setColor(unpack(color))
    love.graphics.print(button.text, bx, by , 0, textSize*5/4, textSize*5/4)
    love.graphics.print("Team :"..team, bx, g_height-spaceY, 0, textSize, textSize)
    if you == true then
      love.graphics.print("You", bx +spaceX, g_height-spaceY, 0, textSize, textSize)
    else
      love.graphics.print("Bot", bx + spaceX, g_height-spaceY, 0, textSize, textSize)
    end
    
    love.graphics.setColor(1, 1, 1)

    cursor_x = cursor_x + margin + button_width
  end
end
function DrawPopulationButton(hotColor, button_width, button_height, margin, offset, rectY)
  local now = false
  local last = false
  
  local cursor_y = 0

  for i, button in ipairs(populationButton) do
    button.last = button.now
    local bx = g_width - button_width - offset
    local by = rectY + margin + cursor_y
    local color = {0.8, 0.8, 0.8  , 1}
    local mx , my = love.mouse.getPosition()
    local hot = mx > bx  and mx < bx + button_width and my > by and my < by + button_height

    if hot then
      color = hotColor
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, button_width, button_height)

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", bx , by, button_width, button_height)
    love.graphics.print(button.text, bx + offset, by + 1/4*button_height, 0, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)

    cursor_y = cursor_y + margin + button_height
  end
end
function DrawBatimentButton( hotColor, button_width, button_height, margin, offset, rectY)
  local now = false
  local last = false

  local cursor_y = 0

  for i, button in ipairs(batimentButton) do
    button.last = button.now
    local bx = g_width - button_width - offset
    local by = rectY + margin + cursor_y
    local color = {0.8, 0.8, 0.8 , 1}
    local mx , my = love.mouse.getPosition()
    local hot = mx > bx  and mx < bx + button_width and my > by and my < by + button_height

    if hot then
      color = hotColor
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, button_width, button_height)

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", bx , by, button_width, button_height)
    love.graphics.print(button.text, bx + offset, by + 1/4*button_height, 0, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)

    cursor_y = cursor_y + margin + button_height
  end
end
function DrawBonusButton( hotColor, button_width, button_height, margin, offset, rectY)
  local now = false
  local last = false
  local cursor_y = 0

  for i, button in ipairs(bonusButton) do
    button.last = button.now
    local bx = g_width - button_width - offset
    local by = rectY + margin + cursor_y
    local color = {0.8, 0.8, 0.8 , 1}
    local mx , my = love.mouse.getPosition()
    local hot = mx > bx  and mx < bx + button_width and my > by and my < by + button_height

    if hot then
      color = hotColor
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, button_width, button_height)

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", bx , by, button_width, button_height)
    love.graphics.print(button.text, bx + offset, by + 1/4*button_height, 0, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)
    
    cursor_y = cursor_y + margin + button_height
  end
end
function DrawMoveButton(hotColor, moveButtonHeight, moveButtonWidth, screenSize, moveOffset, moveMargin, moveRectHeight, moveRectWidth)
  local now1 = false
  local now2 = false
  local last1 = false
  local last2 = false
  
  local cursor_x = 0

  for i, button in ipairs(moveButton) do
    button.last1 = button.now1
    button.last2 = button.now2
    local bx = screenSize + moveOffset + cursor_x 
    local by = g_height - 3/4*moveRectHeight
    local color = {0.8, 0.8, 0.8  , 1}
    local mx , my = love.mouse.getPosition()
    local hot = mx > bx  and mx < bx + moveButtonWidth and my > by and my < by + moveButtonHeight

    if hot then
      color = hotColor
    end

    button.now1 = love.mouse.isDown(1)
    if button.now1 and not button.last1 and hot then
      local nb = 1
      button.fn(nb)
    end
    button.now2 = love.mouse.isDown(2)
    if button.now2 and not button.last2 and hot then
      local nb = -1
      button.fn(nb)
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", bx, by, moveButtonWidth, moveButtonHeight)
    
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", bx, by, moveButtonWidth, moveButtonHeight)
    love.graphics.print(button.text, bx + moveOffset, by, 0, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)

    cursor_x = cursor_x + moveMargin + moveButtonWidth
  end
end