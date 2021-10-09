function XYBetweenPlanet(l1, c1, l2, c2)
  local y = math.abs(l2 - l1)
  local x = math.abs(c2 - c1)
  return x, y
end

local speedX , speedY = XYBetweenPlanet(planet1.l, planet1.c ,planet2.l, planet2.c)
    local totalSpeed = speedX + speedY
    speedX = speedX/totalSpeed*2
    speedY = speedY/totalSpeed*2
    if planet1.hyperSpace == true then
      speedX = speedX*10
      speedY = speedY*10
    end
    
    function botCreateAppropriateUnit()
  for i, planet in ipairs(planetGridTable) do
    if planet.team == "Ennemie" then
      if planet.nbInhabitant > 0 then
        local total = planet.max
        local colon = planet.colonisablePlanet
        local worker = planet.mineralResources + colon
        local scientist = planet.scientificResearchs + worker
        local soldier = planet.colonisablePlanet + scientist
        local unit = love.math.random(1,total)
        planet.nbInhabitant = planet.nbInhabitant - 1
        if unit >= 1 and unit <= colon then
          planet.nbColon = planet.nbColon + 1
        elseif unit > colon and unit <= worker then
          planet.nbWorker = planet.nbWorker + 1
        elseif unit > worker and unit <= scientist then
          planet.nbScientist = planet.nbScientist + 1
        elseif unit > scientist and unit <= soldier then
          planet.nbSoldier = planet.nbSoldier + 1
        end
      end
    end
  end
end

function resetShipPosition()
  for i, ship in ipairs(shipGridTable) do
    if ship.x == ship.endX - 2 or ship.x == ship.endX + 2 or ship.y == ship.endY - 2 or ship.y == ship.endY + 2 then
      ship.position = 0
    end
  end
end

function reacheablePlanet(startPlanet)
  local planet1 = startPlanet
  local index = 0
  for i, planet in ipairs(planetGridTable) do
    if planet.team ~= "Ennemie" then
      local planet2 = planet
      if distanceAttack(planet1.l, planet1.c, planet2.l, planet2.c, planet1.spaceJump) == true then
        index = i 
      end
    end
  end
  return planetGridTable[index]
end


function unfavorablePlanet(team, feature)
  local index = 0
  local percentage = 10000
  for i, planet in ipairs(planetGridTable) do
    if planet.team == team then
      if feature == "total" then
        if planet.total <= percentage then
          index = i
          percentage = planet.total
        end
      elseif feature == "city" then
        if planet.colonisablePlanet <= percentage then
          index = i
          percentage = planet.colonisablePlanet
        end
      elseif feature == "mine" then
        if planet.mineralResources <= percentage then
          index = i
          percentage = planet.mineralResources
        end
      elseif feature == "laboratory" then
        if planet.scientificResearchs <= percentage then
          index = i
          percentage = planet.scientificResearchs
        end
      elseif feature == "warBase" then
        if planet.warIndustry <= percentage then
          index = i
          percentage = planet.warIndustry
        end
      end
    end
  end
  return planetGridTable[index]
end

function furtherPlanet(planet1, team)
  local index = 0
  local distance = 0
  for i, planet in ipairs(planetGridTable) do
    if planet1 ~= nil and planet.team == team then
      local planetDistance = distanceBetweenPlanet(planet1.l, planet1.c , planet.l, planet.c)
      if planetDistance >= distance then
        index = i
        distance = planetDistance
      end
    end
  end
  return planetGridTable[index]
end
function furtherReachablePlanet(planet1)
  local index = 0
  local distanceMin = 0
  local distanceMax = 20
  if planet1.spaceJump == true then
    distanceMax = 40
  end
  for i, planet in ipairs(planetGridTable) do
    local planet2 = planet 
    if planet1 ~= nil and planet2 ~= nil and planet1 ~= planet2  and planet2.team ~= planet1.team then
      local distance = distanceBetweenPlanet(planet1.l, planet1.c , planet2.l, planet2.c)
      if distance >= distanceMin and distance <= distanceMax then
        index = i
        distanceMin = distance
      end
    end
  end
  return planetGridTable[index]
end
function transitionPlanet(startPlanet, endPlanet)
  local index = 0
  local distanceMin = 0
  local distanceMax = 20
  local distance = 10000
  local distaceTotal = 0
  if startPlanet.spaceJump == true then
    distanceMax = 40
  end
  for i, planet in ipairs(planetGridTable) do
    local midPlanet = planet
    if startPlanet ~= nil and midPlanet ~= nil and startPlanet ~= midPlanet then
      local distance1 = distanceBetweenPlanet(startPlanet.l, startPlanet.c , midPlanet.l, midPlanet.c)
      if distance1 <= distanceMax then
        distaceTotal = distance1
        if midPlanet ~= nil and endPlanet ~= nil and midPlanet ~= endPlanet and startPlanet ~= endPlanet then
          local distance2 = distanceBetweenPlanet(midPlanet.l, midPlanet.c , endPlanet.l, endPlanet.c)
          distaceTotal = distance1 + distance2
          if distaceTotal <= distance then
            distaceTotal = distance
            index = i
          end
        end
      end
    end
  end
  return planetGridTable[index]
end
function findSmallPlanet(startPlanet, feature)
  local index = 0
  local population = 10000
  for i, planet in ipairs(planetGridTable) do
    local smallPlanet = planet
    if startPlanet ~= smallPlanet and smallPlanet.team ~= "Ennemie" then
      if distanceAttack(startPlanet.l, startPlanet.c, smallPlanet.l, smallPlanet.c, startPlanet.spaceJump) == true then
        if feature == "population" then
          if smallPlanet.population <= population then
            index = i
            population = smallPlanet.population
          end
        end
      end
    end
  end
  return planetGridTable[index]
end
function findFrofitablePlanet(startPlanet, feature)
  local index = 0
  local percentage = 0
  for i, planet in ipairs(planetGridTable) do
    local frofitablePlanet = planet
    if frofitablePlanet ~= startPlanet and frofitablePlanet.team ~= "Ennemie" then
      if distanceAttack(startPlanet.l, startPlanet.c, frofitablePlanet.l, frofitablePlanet.c, startPlanet.spaceJump) == true then
        if feature == "total" then
          if planet.total >= percentage then
            index = i
            percentage = planet.total
          end
        end
      end
    end
  end
  return planetGridTable[index]
end
function findCloserPlanet(startPlanet)
  local index = 0
  local distance = 10000
  for i, planet in ipairs(planetGridTable) do
    local closerPlanet = planet
    if startPlanet ~= nil and closerPlanet.team ~= "Ennemie" then
      local planetDistance = distanceBetweenPlanet(startPlanet.l, startPlanet.c , closerPlanet.l, closerPlanet.c)
      if planetDistance <= distance then
        index = i
        distance = planetDistance
      end
    end
  end
  return planetGridTable[index]
end

love.graphics.print("A HyperSpace that increase\r\nyour ships' speed by 10.\r\n(1time)", rectX + textX, textY + margin + button_height)
            love.graphics.print("A Virus that drops the births\r\nof a planet to 0 .(60s )", rectX + textX, textY + 2*margin + 2*button_height)
            love.graphics.print("A Destroyer that has 100att,\r\nhe starts from your\r\nmost populated planet. ", rectX + textX, textY + 3*margin + 3*button_height)
            love.graphics.print("A SpaceJump that allowed\r\nyou to move 2 time further.\r\n(1time)", rectX + textX, textY + 4*margin + 4*button_height)
            love.graphics.print("A Shield that stop all ennemies\r\nto attack the planet(30s)", rectX + textX, textY + 5*margin + 5*button_height)
            
             distanceX = math.abs(laser.endX - laser.startX)
    distanceY = math.abs(laser.endY - laser.startY)
    local speed = 1--laser.speed
    speedX = distanceX/distanceY*speed
    speedY = distanceY/distanceX*speed
    if laser.moveX < laser.endX then
      laser.moveX = laser.moveX + speedX
    end
    if laser.moveX > laser.endX then
      laser.moveX = laser.moveX - speedX
    end
    if laser.moveY < laser.endY then
      laser.moveY = laser.moveY + speedY
    end
    if laser.moveY > laser.endY then
      laser.moveY = laser.moveY - speedY
    end
            

 