
hyperSpace = {}
hyperSpace.price = 20
hyperSpace.on = false
table.insert(bonusTable, hyperSpace)

virus = {}
virus.price = 60
virus.on = false
virus.time = 30
table.insert(bonusTable, virus)

destroyer = {}
destroyer.price = 100
destroyer.on = false
table.insert(bonusTable, destroyer)

spaceJump = {}
spaceJump.price = 20
spaceJump.on = false
table.insert(bonusTable, spaceJump)

shield = {}
shield.price = 40
shield.on = false
shield.time = 30
table.insert(bonusTable, shield)

function hyperSpaceBonus(bonusPlayer)
  for i, player in ipairs(playerTable) do
    if player == bonusPlayer then
      if player.you == true then
        if player.experience >= hyperSpace.price then
          player.experience = player.experience - hyperSpace.price
          hyperSpace.on = true
        end
      elseif player.you == false then
        if player.experience >= hyperSpace.price then
          player.experience = player.experience - hyperSpace.price
          local hyperSpacePlanet = biggestPlanet(player.admiral)
          if hyperSpacePlanet ~= nil then
          hyperSpacePlanet.hyperSpace = true
          end
        end
      end
    end
  end
end

function virusBonus(bonusPlayer, planet)
  for i, player in ipairs(playerTable) do
    if player == bonusPlayer then
      if player.you == true then
        if player.experience >= virus.price then
          player.experience = player.experience - virus.price
          virus.on = true
        end
      elseif player.you == false then
        if player.experience >= virus.price then
          player.experience = player.experience - virus.price
          local virusPlanet = planet
          if virusPlanet ~= nil then
          virusPlanet.virus = virus.time
          end
        end
      end
    end
  end
end

function destroyerBonus(bonusPlayer, planet)
  for i, player in ipairs(playerTable) do
    if player == bonusPlayer then
      if player.you == true then
        if player.experience >= destroyer.price then
          player.experience = player.experience - destroyer.price
          destroyer.on = true
        end
      elseif player.you == false then
        if player.experience >= destroyer.price then
          player.experience = player.experience - destroyer.price
          local startPlanet = biggestPlanet(player.admiral)
          local endPlanet = planet
          createDestroyer(startPlanet, endPlanet)
        end
      end
    end
  end
end

function spaceJumpBonus(bonusPlayer)
  for i, player in ipairs(playerTable) do
    if player == bonusPlayer then
      if player.you == true then
        if player.experience >= spaceJump.price then
          player.experience = player.experience - spaceJump.price
          spaceJump.on = true
        end
      elseif player.you == false then
        if player.experience >= spaceJump.price then
          player.experience = player.experience - spaceJump.price
          local hyperSpacePlanet = biggestPlanet(player.admiral)
          if hyperSpacePlanet ~= nil then
          hyperSpacePlanet.hyperSpace = true
          end
        end
      end
    end
  end
end

function shieldBonus(bonusPlayer)
  for i, player in ipairs(playerTable) do
    if player == bonusPlayer then
      if player.you == true then
        if player.experience >= shield.price then
          player.experience = player.experience - shield.price
          shield.on = true
        end
      elseif player.you == false then
        if player.experience >= shield.price then
          player.experience = player.experience - shield.price
          local shieldPlanet = smallestPlanet(player.admiral)
          if shieldPlanet ~= nil then
          shieldPlanet.shield = shield.time
          end
        end
      end
    end
  end
end

