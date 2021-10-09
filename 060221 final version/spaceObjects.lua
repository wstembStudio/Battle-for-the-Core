local space = 1000

function moveMeteorite()
  for i, meteorite in ipairs(meteoriteTable) do
    meteorite.x = meteorite.x + meteorite.vx
    meteorite.y = meteorite.y + meteorite.vy
    if meteorite.x > g_width +space or meteorite.x < 0 -space or meteorite.y > g_height + space or meteorite.y < 0 - space then
      table.remove(meteoriteTable, i)
    end
  end
end

function createMeteorite(side)
  local meteorite = {}
  if side == 1 then -- up
    meteorite.x = love.math.random(-space, g_width +space)
    meteorite.y = - space
    meteorite.vx = love.math.random(-3, 3)
    meteorite.vy = love.math.random(1, 6)
  elseif side == 2 then -- right
    meteorite.x = g_width + space
    meteorite.y = love.math.random(-space, g_height +space)
    meteorite.vx = love.math.random(-1, -6)
    meteorite.vy = love.math.random(-3, 3)
  elseif side == 3 then -- down
    meteorite.x = love.math.random(-space, g_width +space)
    meteorite.y = g_height + space
     meteorite.vx = love.math.random(-3, 3)
    meteorite.vy = love.math.random(-1, -6)
  elseif side == 4 then -- left
    meteorite.x = - space
    meteorite.y = love.math.random(-space, g_height +space)
    meteorite.vx = love.math.random(1, 6)
    meteorite.vy = love.math.random(-3, 3)
  end
  meteorite.color = {70/255, 33/255, 0}
  meteorite.size = love.math.random(10, 20)
  table.insert(meteoriteTable, meteorite)
end

function createBlackHole()
  local Grid_width = 48
  local Grid_height = 27
  local blackHole = {}
  ::others_cl::
  local c = love.math.random(2,Grid_width-1)
  local l = love.math.random(2,Grid_height-1)
  for i, planet in ipairs(planetGridTable) do
    if c == planet.c and l == planet.l then
      goto others_cl
    end
  end
  for i, blackHole in ipairs(blackHoleTable) do
    if c == blackHole.c and l == blackHole.l then
      goto others_cl
    end
  end
  blackHole.c = c
  blackHole.l = l
  local x,y = getXY(l,c)
  blackHole.x = x
  blackHole.y = y
  blackHole.size = Grid.cellSize
  blackHole.hp = love.math.random(10, 40)
  blackHole.color = {0,0,0}
  table.insert(blackHoleTable, blackHole)
end

function deleteBlackHole(dt)
  for i, blackHole in ipairs(blackHoleTable) do
    blackHole.hp = blackHole.hp - dt
    if blackHole.hp <= 0 then
      table.remove(blackHoleTable, i)
    end
  end
end
function createStarKiller()
  starKiller = {}
  starKiller.x = 0
  starKiller.y = love.math.random(100, g_height-100)
  starKiller.vx = 2
  starKiller.vy = 0
  starKiller.img = love.graphics.newImage("Picture/Starkiller.png")
  table.insert(starKillerTable, starKiller)
end
function moveStarKiller()
  for i, starKiller in ipairs(starKillerTable) do
    starKiller.x = starKiller.x + starKiller.vx
    starKiller.y = starKiller.y + starKiller.vy
    if starKiller.x > g_width +space or starKiller.x < 0 -space or starKiller.y > g_height + space or starKiller.y < 0 - space then
      table.remove(starKillerTable, i)
    end
  end
end