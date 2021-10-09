local botBonusTimer = 0
local botBonusTimeOver = 15

function botCreateAppropriateUnit()
  for i, planet in ipairs(planetGridTable) do
    if planet.admiral ~= youPlayer("admiral") and planet.admiral ~= nil then
      if planet.nbInhabitant > 0 and planet.population < planet.max then
        local worker = planet.mineralResources
        local scientist = planet.scientificResearchs + worker
        local unit = math.random(1,scientist)
        if unit >= 1 and unit <= worker and math.floor(planet.nbWorker/planet.max*100) < 10 then
          planet.nbInhabitant = planet.nbInhabitant - 1
          planet.nbWorker = planet.nbWorker + 1
        elseif unit > worker and unit <= scientist and math.floor(planet.nbScientist/planet.max*100) < 10 then
          planet.nbInhabitant = planet.nbInhabitant - 1
          planet.nbScientist = planet.nbScientist + 1
        end
      end
    end
  end
end
function botCreateSpecificUnit(job, percentage)
  for i, planet in ipairs(planetGridTable) do
    if planet.admiral ~= youPlayer("admiral") and planet.admiral ~= nil then
      local nb = planet.nbInhabitant
      if nb > 0 then
        if job == "colon" then 
          if math.floor(planet.nbColon /planet.max*100) <= percentage then 
            planet.nbColon = planet.nbColon + nb
            planet.nbInhabitant = planet.nbInhabitant - nb
--          elseif math.floor(planet.nbColon /planet.max*100) > percentage then
--            nb =  math.floor(percentage/100*planet.max - planet.nbColon/100*planet.max)
--            if nb <= 0 or planet.population + nb > planet.max then
--              return
--            else
--              planet.nbColon = planet.nbColon + nb
--              planet.nbInhabitant = planet.nbInhabitant - nb
            --end
          end
        elseif job == "worker" then 
          if math.floor(planet.nbWorker /planet.max*100) <= percentage then
            planet.nbWorker = planet.nbWorker + nb
            planet.nbInhabitant = planet.nbInhabitant - nb
--          elseif math.floor(planet.nbWorker /planet.max*100) > percentage then
--            nb =  math.floor(percentage/100*planet.max - planet.nbWorker/100*planet.max)
--            if nb < 0 or planet.population + nb > planet.max then
--              return
--            else
--              planet.nbWorker = planet.nbWorker + nb
--              planet.nbInhabitant = planet.nbInhabitant - nb
--            end
          end
        elseif job == "scientist" then 
          if math.floor(planet.nbScientist /planet.max*100) <= percentage then
            planet.nbScientist = planet.nbScientist + nb
            planet.nbInhabitant = planet.nbInhabitant - nb
--          elseif math.floor(planet.nbScientist /planet.max*100) > percentage then
--            nb =  math.floor(percentage/100*planet.max - planet.nbScientist/100*planet.max)
--            if nb < 0 or planet.population + nb > planet.max then
--              return
--            else
--              planet.nbScientist = planet.nbScientist + nb
--              planet.nbInhabitant = planet.nbInhabitant - nb
--            end
          end
        elseif job == "soldier" then 
          if math.floor(planet.nbSoldier/planet.max*100) <= percentage then
            planet.nbSoldier = planet.nbSoldier + nb
            planet.nbInhabitant = planet.nbInhabitant - nb
--          elseif math.floor(planet.nbSoldier/planet.max*100) > percentage then
--            nb =  math.floor(percentage/100*planet.max - planet.nbSoldier/100*planet.max)
--            if nb < 0 or planet.population + nb > planet.max then
--              return
--            else
--              planet.nbSoldier = planet.nbSoldier + nb
--              planet.nbInhabitant = planet.nbInhabitant - nb
--            end
          end
        end
      end
    end
  end
end
function biggestPlanet(admiral)
  local index = 0
  local population = 0
  for i, planet in ipairs(planetGridTable) do
    if planet.admiral == admiral then
      if planet.population >= population then
        index = i
        population = planet.population
      end
    end
  end
  return planetGridTable[index]
end
function smallestPlanet(admiral)
  local index = 0
  local population = 10000
  for i, planet in ipairs(planetGridTable) do
    if planet.admiral == admiral then
      if planet.population <= population then
        index = i
        population = planet.population
      end
    end
  end
  return planetGridTable[index]
end
function botFindUpgradePlanet(admiral)
  local index = 0
  local population = 0
  for i, planet in ipairs(planetGridTable) do
    if planet.admiral == admiral then
      if planet.population >= population then
        if planet.cityLvl <= 4 or planet.mineLvl <= 4 or planet.laboratoryLvl <= 4 or planet.warBaseLvl <= 4 then
          index = i
          population = planet.population
        end
      end
    end
  end
  return planetGridTable[index]
end
function botFindHelpPlanet(startPlanet)
  local index = 0
  local population = 10000
  for i, planet in ipairs(planetGridTable) do
    local smallPlanet = planet
    if startPlanet ~= smallPlanet and smallPlanet.team == startPlanet.team and smallPlanet.population < smallPlanet.max then
      if distanceAttack(startPlanet.l, startPlanet.c, smallPlanet.l, smallPlanet.c, startPlanet.spaceJump) == true then
        if smallPlanet.population <= population then
          index = i
          population = smallPlanet.population
        end
      end
    end
  end
  return planetGridTable[index]
end
function botFindTarget(startPlanet)

  -- planet qui attaque
  local l = startPlanet.l
  local c = startPlanet.c

  local ranking = {}
  for i,planet in ipairs(planetGridTable) do 
    if distanceAttack(l,c, planet.l,planet.c, startPlanet.spaceJump) and planet.team ~= startPlanet.team and planet.shield == 0 then
      table.insert(ranking, planet)
    end
  end

  table.sort(ranking, 
    function(planet1, planet2)
      local d1 = distanceBetweenPlanet(l, c, planet1.l, planet1.c)
      local d2 = distanceBetweenPlanet(l, c, planet2.l, planet2.c)

      c1 = planet1.population < planet2.population
      c2 = planet1.population == planet2.population and planet1.total > planet2.total
      c3 = planet1.population == planet2.population and planet1.total == planet2.total and d1<d2

--      c1 = d1<d2
--      c2 = d1==d2 and planet1.population<planet2.population

      return c1 or c2 or c3

    end)
--  for i,v in ipairs(ranking) do 
--    local d = distanceBetweenPlanet(l, c, v.l, v.c)
--    print(">>>"..v.name..">>>population="..v.population..">>>total="..v.total..">>>distance="..d)
--  end

  return ranking[1]
end
function botAttack(startPlanet, targetPlanet)
  local nbr = 0
  if startPlanet.nbInhabitant >= 45 then
    nbr = 45
  elseif startPlanet.nbInhabitant >= 30 then
    nbr = 30
  elseif startPlanet.nbInhabitant >= 20 then
    nbr = 20
  elseif startPlanet.nbInhabitant >= 15 then
    nbr = 15
  elseif startPlanet.nbInhabitant >= 10 then
    nbr = 10
  else
    nbr = startPlanet.nbInhabitant
  end
  startPlanet.moveSoldier = startPlanet.moveSoldier + nbr
  startPlanet.nbInhabitant = startPlanet.nbInhabitant - nbr
  outAllShip(startPlanet, targetPlanet)
end
function botHelp(startPlanet, targetPlanet)
  local nbr = 0
  if startPlanet.nbInhabitant >= 10 then
    nbr = 10
  elseif startPlanet.nbInhabitant >= 5 then
    nbr = 5
  else
    nbr = startPlanet.nbInhabitant
  end
  startPlanet.moveInhabitant = startPlanet.moveInhabitant + nbr
  startPlanet.nbInhabitant = startPlanet.nbInhabitant - nbr
  outAllShip(startPlanet, targetPlanet)
end
function botUpgrade()
  for i, player in ipairs(playerTable) do
    if player.you == false then
      if player.ressource >= 10 then
        local upgradePlanet = botFindUpgradePlanet(player.admiral)
        if upgradePlanet ~= nil then
          warBaseUpgrade(upgradePlanet, player)
          cityUpgrade(upgradePlanet, player)
          laboratoryUpgrade(upgradePlanet, player)
          mineUpgrade(upgradePlanet, player)
        end
      end
    end
  end
end
function botBonus(dt)
  for i, planet in ipairs(planetGridTable) do
    for i, player in ipairs(playerTable) do
      if player.admiral ~= youPlayer("admiral") then
        if planet.team ~= player.team and planet.team ~= 0 and planet.population > 40 then
          if player.experience >= destroyer.price then
            destroyerBonus(player, planet)
          end
        elseif planet.team ~= player.team and planet.team ~= 0 and planet.population > 20 and planet.virus == 0 then
          if player.experience >= virus.price then
            virusBonus(player, planet)
          end
        elseif player.you == false and planet.admiral == player.admiral and planet.population < 10 and planet.shield == 0 then
          if player.experience >= shield.price then
            shieldBonus(player)
          end
        end
      end
    end
  end
  botBonusTimer = botBonusTimer + dt
  if botBonusTimer >= botBonusTimeOver then
    for i, player in ipairs(playerTable) do
      if player.you == false then
        local bonus = love.math.random(2)
        if bonus == 1 then
          if player.experience >= spaceJump.price then
            spaceJumpBonus(player)
          end
        elseif bonus == 2 then
          if player.experience >= hyperSpace.price then
            hyperSpaceBonus(player)
          end
        end
      end
    end
  end
end