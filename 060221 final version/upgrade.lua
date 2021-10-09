function cityUpgrade(planet, player)
  local price = 24*(planet.cityLvl + 1)
  if planet.cityLvl <= 4 then
    if player.ressource >= price and planet.admiral == player.admiral then
      player.ressource = player.ressource - price
      planet.cityLvl = planet.cityLvl + 1
      planet.colonisablePlanet = planet.colonisablePlanet + 10
    end
  end
end
function mineUpgrade(planet, player)
  local price = 32*(planet.mineLvl + 1)
  if planet.mineLvl <= 4 then
    if player.ressource >= price and planet.admiral == player.admiral then
      player.ressource = player.ressource - price
      planet.mineLvl = planet.mineLvl + 1
      planet.mineralResources = planet.mineralResources + 10
    end
  end
end
function laboratoryUpgrade(planet, player)
  local price = 28*(planet.laboratoryLvl + 1)
  if planet.laboratoryLvl <= 4 then
    if player.ressource >= price and planet.admiral == player.admiral then
      player.ressource = player.ressource - price
      planet.laboratoryLvl = planet.laboratoryLvl + 1
      planet.scientificResearchs = planet.scientificResearchs + 10
    end
  end
end
function warBaseUpgrade(planet, player)
  local price = 20*(planet.warBaseLvl + 1)
  if planet.warBaseLvl <= 4 then
    if player.ressource >= price and planet.admiral == player.admiral then
      player.ressource = player.ressource - price
      planet.warBaseLvl = planet.warBaseLvl + 1
      planet.warIndustry = planet.warIndustry + 10
    end
  end
end