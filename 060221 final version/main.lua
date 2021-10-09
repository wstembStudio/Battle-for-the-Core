io.stdout:setvbuf('no') --console output at run
--love.graphics.setDefaultFilter("nearest") --no anti aliasing
if arg[#arg] == "-debug" then require("mobdebug").start() end

-- full screen
love.window.setMode(1920, 1080)

--VARIABLES________________________________________________________

-- images
local imgLogo = love.graphics.newImage("Picture/logo.png")
local imgStarWars = love.graphics.newImage("Picture/starWars.png")
local imgMenu = love.graphics.newImage("Picture/menuImg.jpg")
local imgWilliamStudio = love.graphics.newImage("Picture/logoWilliamStudio.png")

local imgSetting = love.graphics.newImage("Picture/settings.png")
local imgRules = love.graphics.newImage("Picture/rules.png")
local imgControls = love.graphics.newImage("Picture/controls.png")
local imgDifficulty = love.graphics.newImage("Picture/difficulty.png")
local imgLose = love.graphics.newImage("Picture/lose.png")
local imgWin = love.graphics.newImage("Picture/win.png")

local imgGalaxy = love.graphics.newImage("Picture/galaxy.png")
local imgSpace = love.graphics.newImage("Picture/space.png")

local imgYularen = love.graphics.newImage("Picture/AdmiralYularen.jpg")
local imgTrench = love.graphics.newImage("Picture/AdmiralTrench.jpg")
local imgAckbar = love.graphics.newImage("Picture/AdmiralAckbar.jpg")
local imgThrawn = love.graphics.newImage("Picture/AdmiralThrawn.jpg")

local imgGalacticRepublic = love.graphics.newImage("Picture/galacticRepublic.png")
local imgCIS = love.graphics.newImage("Picture/CIS.png")
local imgRebelAlliance = love.graphics.newImage("Picture/rebelAlliance.png")
local imgGalacticEmpire = love.graphics.newImage("Picture/galacticEmpire.png")

imgYularenHead = love.graphics.newImage("Picture/Yularen.jpg")
imgTrenchHead = love.graphics.newImage("Picture/Trench.png")
imgAckbarHead = love.graphics.newImage("Picture/Ackbar.png")
imgThrawnHead = love.graphics.newImage("Picture/Thrawn.png")

local imgScreen1 = love.graphics.newImage("Picture/screen1.jpg")
local imgScreen2 = love.graphics.newImage("Picture/screen2.jpg")
local imgScreenSettings = love.graphics.newImage("Picture/screenSetting.jpg")

local imgEndLeft = love.graphics.newImage("Picture/left.jpeg")
local imgEndRight = love.graphics.newImage("Picture/right.jpg")

local bonusCursor = love.graphics.newImage("Picture/bonusCursor.png")

-- music
local menuMusic = love.audio.newSource("Music/battleCoruscant.mp3", "stream")

yularenMusic = love.audio.newSource("Music/siegeMandalore.mp3", "stream")
trenchMusic = love.audio.newSource("Music/duelOfTheFates.mp3", "stream")
ackbarMusic = love.audio.newSource("Music/battleEndor.mp3", "stream")
thrawnMusic = love.audio.newSource("Music/thawnTheme.mp3", "stream")

local winMusic =  love.audio.newSource("Music/win.mp3", "stream")
local loseMusic = love.audio.newSource("Music/lose.mp3", "stream")

local starKillerMusic = love.audio.newSource("Music/starKiller.mp3", "stream")

-- sounds

settingSound = love.audio.newSource("Sound/buttonSetting.mp3", "static")
menuSound = love.audio.newSource("Sound/buttonMenu.mp3", "static")
bipSound = love.audio.newSource("Sound/bip.mp3", "static")
local gameStartSound = love.audio.newSource("Sound/gameStart.mp3", "static")
local bonusSound = love.audio.newSource("Sound/bonus.mp3", "static")
collisionSound = love.audio.newSource("Sound/collision.mp3", "static")
local switchSound = love.audio.newSource("Sound/switch.mp3", "static")
local explosionSound = love.audio.newSource("Sound/explosion.mp3", "static")


local musicVolume = 0.20
local soundVolume = 0.50

g_width = love.graphics.getWidth()
g_height = love.graphics.getHeight()

-- Table
shipGridTable = {}
planetTable = {}
planetGridTable = {}
shortcutTable = {}

bonusTable = {}
colorTable = {}
playerTable = {}
meteoriteTable = {}
blackHoleTable = {}
starKillerTable = {}
laserTable = {}

menuButton = {}
settingsButton = {}
difficultyButton = {}
playerButton = {}
populationButton = {}
batimentButton = {}
bonusButton = {}
moveButton = {}

g_selectedPlanet = nil
g_endPlanet = nil

local offsetX = 0 -- screen to map offset
local offsetY = 0

mx = 0
my = 0

local startMoveX = 0
local startMoveY = 0

local mouseMapBeforeZoomX = 0
local mouseMapBeforeZoomY = 0
local mouseMapAfterZoomX = 0
local mouseMapAfterZoomY = 0

local zoomX = 1.0 -- zoom default value
local zoomY = 1.0

g_display = {}

local POPULATION_VIEW = 1
local BATIMENT_VIEW = 2
local BONUS_VIEW = 3
g_display.currentView = POPULATION_VIEW

INTRO_STAGE = 1
MENU_STAGE = 2
SETTING_STAGE = 3
CONTROLS_STAGE = 4
RULES_STAGE = 5
DIFFICULTY_STAGE = 6
ADMIRAL_STAGE = 7
GAME_STAGE = 8
WIN_STAGE = 9
LOSE_STAGE = 10
g_display.currentStage = MENU_STAGE

EASY_DIFFICULTY = 1
MEDIUM_DIFFICULTY = 2
DIFFICULT_DIFFICULTY = 3
HARD_DIFFICULTY = 4
g_display.currentDifficulty = MEDIUM_DIFFICULTY

YULAREN_VIEW = 1
TRENCH_VIEW = 2
ACKBAR_VIEW = 3
THRAWN_VIEW = 4
g_display.currentAdmiral = YULAREN_VIEW

g_display.settings = false

g_display.starKiller = true
g_display.blackHole = true
g_display.meteorite = true
g_display.backGround = true
g_display.bonus = true

--TIMER____________________________________________________________

local populationTimer = 0
local populationTimeOver = 3

local timerMeteorite = 0
local timeOverMeteorite = 4

local timerBlackHole = 0
local timeOverBlackHole = 20

local timerStarKiller = 0
local timeOverStarKiller = 60

local timerShoot = 0
local timeOverShoot = 8

local botCreateTimer = 0
local botCreateTimeOver = nil

local botAttackTimer = 0
local botAttackTimeOver = nil

local botHelpTimer = 0
local botHelpTimeOver = nil

local gameTimer = 0

--OBJECTS_______________________________________________________________

local screen = {}
screen.x = 0 -- screen pos (= window's up left corner)
screen.y = 0

local MAP_SPACE = 0
local MAP_DEEP_WORLD = 1
local MAP_CORE_WORLDS = 2
local MAP_COLONIES = 3
local MAP_INNER_RIM = 4
local MAP_EXPANSION_REGION = 5
local MAP_MID_RIM = 6
local MAP_OUTER_RIM = 7
local MAP_PLANET = 8
local MAP_BLACKHOLE = 9

local Map = {}
Map = { 
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
} 

Grid = {}
Grid.width = 48
Grid.height = 27
Grid.cellSize = 0
Grid.cells = {}
--______________________________________________________________________

dofile("player.lua")
dofile("planet.lua")
dofile("spaceObjects.lua")
dofile("bonus.lua")
dofile("bot.lua")
dofile("button.lua")
dofile("upgrade.lua")

function InitGrid()
  local h = g_height / Grid.height
  Grid.cellSize = h
  Grid.cells = {}
  for l=1, Grid.height do
    Grid.cells[l] = {}
    for c=1, Grid.width do 
      Grid.cells[l][c] = 0
    end
  end
end
function InitPlanet()
  for i, objects in ipairs(planetTable) do ::others_cl::
    local c = love.math.random(2,Grid.width-1)
    local l = love.math.random(2,Grid.height-1)
    for i, planet in ipairs(planetGridTable) do
      if c == planet.c and l == planet.l then
        goto others_cl
      end
    end
    local mR = love.math.random(10,100)
    local sR = love.math.random(10,100)
    local wI = love.math.random(10,100)
    local cP = love.math.random(10,100)
    local planet = objects
    planet.c = c
    planet.l = l
    planet.you = false
    planet.team = 0
    planet.color = {0.5,0.5,0.5}
    planet.admiral = nil
    planet.mineralResources = mR
    planet.scientificResearchs = sR
    planet.warIndustry = wI
    planet.colonisablePlanet = cP
    planet.total = planet.mineralResources + planet.scientificResearchs + planet.warIndustry + planet.colonisablePlanet
    --
    planet.nbColon = 0
    planet.nbWorker = 0
    planet.nbScientist = 0
    planet.nbSoldier = 0
    planet.nbInhabitant = 1
    --
    planet.cityLvl = 0
    planet.mineLvl = 0
    planet.laboratoryLvl = 0
    planet.warBaseLvl = 0
    --
    planet.moveColon = 0
    planet.moveWorker = 0
    planet.moveScientist = 0
    planet.moveSoldier = 0
    planet.moveInhabitant = 0
    planet.move = 0
    planet.planet = 0
    --
    planet.population = 0
    planet.inhabitant = 0
    planet.colon = 0
    planet.woker = 0
    planet.scientist = 0
    planet.soldier = 0
    --
    planet.max = 0
    planet.ressource = 0
    planet.experience = 0
    planet.birth = 1
    --
    planet.virus = 0
    planet.shield = 0
    planet.destroyer = false
    planet.spaceJump = false
    planet.hyperSpace = false

    planet.selected = false

    table.insert(planetGridTable, planet) 
    Map[l][c] = MAP_PLANET 
  end
end
-- screen space will be converted to map space then divided by the zoom factor and add the screen to map offset
function screenToMap(screenX, screenY) 
  mapX = (screenX / zoomX)  + offsetX
  mapY = (screenY / zoomY) + offsetY
  return mapX, mapY
end

function catchMousePosBeforeMove() --happens only once when btn is pressed
  startMoveX = mx -- capture mouse pos when clicking before moving
  startMoveY = my
end
function findClickedCell(mx, my)
  local h = Grid.cellSize
  local w = h 
  for l=1,Grid.height do
    for c=1,Grid.width do
      x = (c-1)*w
      y = (l-1)*h
      x = x + offsetX 
      y = y + offsetY 
      if mx>x * zoomX and mx<(x+w) * zoomX and my>y * zoomX and my<(y+h) * zoomX then
        -- ATTENTION l or c can be nil
        return l, c
      end
    end
  end
end
function getXY(l,c)
  if c ~= nil and l ~= nil then
    local h = Grid.cellSize
    local w = h
    local x,y
    x = (c-1)*w
    y = (l-1)*h
    return x, y
  end
end
function getNbPlanet(admiral)
  local nb = 0
  for i, planet in ipairs(planetGridTable) do
    if planet.admiral == admiral then
      nb = nb + 1
    end
  end
  return nb
end
function getPopulation(admiral)
  local nb = 0
  for i, ship in ipairs(shipGridTable) do
    if ship.admiral == admiral then
      nb = nb + 1
    end
  end
  for i, planet in ipairs(planetGridTable) do 
    if planet.admiral == admiral then
      nb = nb + planet.population
    end
  end
  return nb
end
function createShip(bl,bc,el,ec, time, team, feature, hp, att, speed, position, color, admiral, size)
  local bx,by = getXY(bl,bc)
  local ex,ey = getXY(el,ec)
  ship = {}
  ship.position = position
  ship.x = bx 
  ship.y = by 
  ship.endX = ex
  ship.endY = ey
  ship.size = size
  ship.team = team 
  ship.feature = feature
  ship.hp = hp
  ship.att = att
  ship.time = time
  ship.speed = speed
  ship.color = color
  ship.admiral = admiral
  table.insert(shipGridTable, ship)
end


function distanceAttack(l1, c1, l2, c2, bonus)
  local distance = 20
  if bonus == true then
    distance = 40
  end
  if math.abs(l2 - l1) + math.abs(c2 - c1) > distance then
    return false
  else
    return true
  end
end
function distanceBetweenPlanet(l1, c1, l2, c2)
  local distance = math.abs(l2 - l1) + math.abs(c2 - c1)
  return distance
end
--function initDistanceMove()
--  for i, a in ipairs(planetGridTable) do
--    local planet1 = a
--    for i, b in ipairs(planetGridTable) do
--      local planet2 = b
--      local distance = distanceBetweenPlanet(planet1.l, planet1.c, planet2.l, planet2.c)

--    end
--  end
--end
function updatePopulation()
  for i, player in ipairs(playerTable) do
    player.population = getPopulation(player.admiral)
  end
end
function updateBotTimer()
  if g_display.currentDifficulty == EASY_DIFFICULTY then
    botCreateTimeOver = love.math.random(30,40)
    botAttackTimeOver = love.math.random(20,25)
    botHelpTimeOver = love.math.random(20,25)
  elseif g_display.currentDifficulty == MEDIUM_DIFFICULTY then
    botCreateTimeOver = love.math.random(25,35)
    botAttackTimeOver = love.math.random(15,20)
    botHelpTimeOver = love.math.random(15,20)
  elseif g_display.currentDifficulty == DIFFICULT_DIFFICULTY then
    botCreateTimeOver = love.math.random(20,25)
    botAttackTimeOver = love.math.random(10,15)
    botHelpTimeOver = love.math.random(10,15)
  elseif g_display.currentDifficulty == HARD_DIFFICULTY then
    botCreateTimeOver = love.math.random(15,20)
    botAttackTimeOver = love.math.random(5,10)
    botHelpTimeOver = love.math.random(5,10)
  end
end
function updatePlanet(dt)
  for i, planet in ipairs(planetGridTable) do
    if planet.color ~= nil then
      if planet.color == REPUBLIC_COLOR then
        planet.admiral = "Admiral Wullf Yularen"
      elseif planet.color == CIS_COLOR then
        planet.admiral = "Admiral Trench"
      elseif planet.color == REBEL_COLOR then
        planet.admiral = "Admiral Gial Ackbar"
      elseif planet.color == EMPIRE_COLOR then
        planet.admiral = "Grand Admiral Thrawn"
      end
    end

    planet.inhabitant = planet.nbInhabitant + planet.moveInhabitant
    planet.colon = planet.nbColon + planet.moveColon
    planet.worker = planet.nbWorker + planet.moveWorker
    planet.scientist = planet.nbScientist + planet.moveScientist
    planet.soldier = planet.nbSoldier + planet.moveSoldier
    planet.total = planet.mineralResources + planet.scientificResearchs + planet.warIndustry + planet.colonisablePlanet
    planet.move = planet.moveColon + planet.moveWorker + planet.moveScientist + planet.moveSoldier + planet.moveInhabitant
    planet.population = planet.inhabitant + planet.colon + planet.worker + planet.scientist + planet.soldier 
    planet.planet = planet.population - planet.move
    planet.max = math.ceil(planet.total/2)
  end
  populationTimer = populationTimer + dt
  if populationTimer >= populationTimeOver then
    populationTimer = 0
    for i, planet in ipairs(planetGridTable) do

      local mineralProduction = math.ceil(planet.nbWorker * 0.01 * planet.mineralResources)
      planet.ressource = mineralProduction
      for i, player in ipairs(playerTable) do
        if planet.admiral == player.admiral then
          player.ressource = player.ressource + mineralProduction
          player.ressourceT = player.ressourceT + mineralProduction
        end
      end

      local scientistProduction = math.ceil(planet.nbScientist * 0.01 * planet.scientificResearchs)
      planet.experience = scientistProduction
      for i, player in ipairs(playerTable) do
        if planet.admiral == player.admiral then
          player.experience = player.experience + scientistProduction
          player.experienceT = player.experienceT + scientistProduction
        end
      end

      if planet.virus == 0 then
        local inhabitantIncreasment = math.ceil(planet.nbColon * 0.001 * planet.colonisablePlanet + 1)
        if planet.population + inhabitantIncreasment <= planet.max then
          --
        else
          inhabitantIncreasment = planet.max - planet.population
        end
        if inhabitantIncreasment >= 0 then 
          planet.nbInhabitant = planet.nbInhabitant + inhabitantIncreasment
          planet.birth = inhabitantIncreasment
          for i, player in ipairs(playerTable) do
            if planet.admiral == player.admiral then
              player.populationT = player.populationT + inhabitantIncreasment
            end
          end
        end
      end
    end
  end
end
function updateMusic()
  settingSound:setVolume(soundVolume)
  menuSound:setVolume(soundVolume)
  bipSound:setVolume(soundVolume)
  gameStartSound:setVolume(soundVolume)
  collisionSound:setVolume(soundVolume/3)
  bonusSound:setVolume(soundVolume/2)
  switchSound:setVolume(soundVolume/2)
  explosionSound:setVolume(soundVolume)
  
  menuMusic:setVolume(musicVolume)
  local gameMusic = youPlayer("music")
  
  if g_display.currentStage == MENU_STAGE then
    if gameMusic ~= nil then
      gameMusic:stop()
    end
    loseMusic:stop()
    winMusic:stop()
    
    menuMusic:setLooping(true)
    menuMusic:play()
  
  elseif g_display.currentStage == GAME_STAGE then
    if table.getn(starKillerTable) == 0 and gameMusic ~= nil then
      starKillerMusic:setVolume(0)
      menuMusic:stop()
      gameMusic:setVolume(musicVolume)
      gameMusic:setLooping(true)
      gameMusic:play()
    elseif table.getn(starKillerTable) > 0 and gameMusic ~= nil then
      gameMusic:setVolume(0)
      starKillerMusic:setVolume(musicVolume)
      starKillerMusic:play()
      starKillerMusic:setLooping(true)
    end
  elseif g_display.currentStage == LOSE_STAGE then
    gameMusic:stop()
    loseMusic:setVolume(musicVolume)
    loseMusic:setLooping(true)
    loseMusic:play()
  elseif g_display.currentStage == WIN_STAGE then
    starKillerMusic:stop()
    gameMusic:stop()
    winMusic:setVolume(musicVolume)
    winMusic:setLooping(true)
    winMusic:play()
  end
  
end
function bonusPlanet(dt)
  -- BONUS
  for i, planet in ipairs(planetGridTable) do
    -- virus
    if planet.virus > 0 then
      planet.birth = 0
      planet.virus = planet.virus - dt
    elseif planet.virus <= 0 then
      planet.virus = 0
    end
    -- shield
    if planet.shield > 0 then
      planet.shield = planet.shield - dt
    elseif planet.shield <= 0 then
      planet.shield = 0
    end
  end
end
function createDestroyer(startPlanet, endPlanet)
  local feature = "Destroyer"
  local hp = 1
  local att = 50
  local time = 0
  local speed = 1
  local position = 0
  local size = Grid.cellSize
  local color = startPlanet.color
  local admiral = startPlanet.admiral
  local team = startPlanet.team
  createShip(startPlanet.l,startPlanet.c,endPlanet.l,endPlanet.c, time, team, feature, hp, att, speed, position, color, admiral, size)
end
function resetBonus(resetPlanet)
  for i, planet in ipairs(planetGridTable) do 
    if planet == resetPlanet then
      planet.spaceJump = false
      planet.hyperSpace = false
      planet.viruss = 0
      planet.shield = 0
    end
  end
end
function reward(defeatPlanet, winnerAdmiral)
  local ressourceGain = math.ceil(defeatPlanet.mineralResources/10)
  local experienceGain = math.ceil(defeatPlanet.scientificResearchs/10)
  for i, player in ipairs(playerTable) do
    if winnerAdmiral == player.admiral then
      player.ressource = player.ressource + ressourceGain
      player.experience = player.experience + experienceGain
      player.ressourceT = player.ressourceT + ressourceGain
      player.experienceT = player.experienceT + experienceGain
    end
  end
end
function lose()
  local allié = 0
  local death = 0
  for i, player in ipairs(playerTable) do
    if player.team == youPlayer("team") then
      allié = allié + 1
      if player.population <= 0 then
        death = death + 1
      end
    end
  end
  if death == allié then
    g_display.currentStage = LOSE_STAGE
  end
end
function win()
  local ennemie = 0
  local death = 0
  for i, player in ipairs(playerTable) do
    if player.team ~= youPlayer("team") then
      ennemie = ennemie + 1
      if player.population <= 0 then
        death = death + 1
      end
    end
  end
  if death == ennemie then
    g_display.currentStage = WIN_STAGE
  end
end
function collision()
  for i, blackHole in ipairs(blackHoleTable) do
    for j, meteorite in ipairs(meteoriteTable) do
      for k, ship in ipairs(shipGridTable) do
        local offset = 0
        if ship.feature == "Colon" or ship.feature == "Inhabitant" then
          offset = Grid.cellSize/2
        elseif ship.feature == "Worker" or ship.feature == "Scientist" then
          offset = Grid.cellSize/8
        elseif ship.feature == "Soldier" then
          offset = Grid.cellSize - 20
        elseif ship.feature == "Destroyer" then
          offset = 0
        end
        local position = ship.position + offset
        if (math.abs(ship.x + position - meteorite.x) <= meteorite.size and math.abs(ship.y + position - meteorite.y) <= meteorite.size) or (math.abs(ship.x + position - blackHole.x) <= blackHole.size and math.abs(ship.y + position - blackHole.y) <= blackHole.size) then
          table.remove(shipGridTable, k)
        end
      end
    end
  end
  for i, planet in ipairs(planetGridTable) do
    for j, laser in ipairs(laserTable) do
      local l, c = findClickedCell(laser.x + offsetX, laser.y + offsetY)
      if planet.c == c and planet.l == l then
        table.remove(planetGridTable, i)
        explosionSound:play()
      end
    end
  end
end
function createPlanet()
  for i, player in ipairs(playerTable) do 
    local nbPlanet = 3
    if player.team ~= 0 then
      for i, planet in ipairs(planetTable) do
        if planet.team == 0 and nbPlanet > 0 then
          planet.you = player.you
          planet.team = player.team
          planet.admiral = player.admiral
          planet.color = player.color
          nbPlanet = nbPlanet - 1
        end
      end
    end
  end
end
function createLaser()
  for i, starKiller in ipairs(starKillerTable) do
    local laser = {}
    laser.x = starKiller.x
    laser.y = starKiller.y
    laser.moveX = love.math.random(-200,600)/100
    laser.moveY = love.math.random(-200,600)/100
    laser.color = {1,0,0}
    laser.starKiller = starKiller
    laser.max = love.math.random(100,500)
    table.insert(laserTable, laser)
  end
end
function moveLaser()
  for i, laser in ipairs(laserTable) do
    local distanceX = math.abs(laser.x - laser.starKiller.x)  
    local distanceY = math.abs(laser.y - laser.starKiller.y)
    if distanceX > laser.max or distanceY > laser.max then
      table.remove(laserTable, i)
    end
    laser.x = laser.x + laser.moveX
    laser.y = laser.y + laser.moveY
  end
end
function youPlayer(info)
  for i, player in ipairs(playerTable) do 
    if player.you == true then
      if info == "admiral" then
        return player.admiral
      elseif info == "team" then
        return player.team
      elseif info == "color" then
        return player.color
      elseif info == "music" then
        return player.music
      elseif info == "player" then
        return player
      elseif info == "img" then
        return player.img
      end
    end
  end
end
function botPlayer(info)
  local player = nil
  if g_display.currentAdmiral == YULAREN_VIEW then
    player = player1
  elseif g_display.currentAdmiral == TRENCH_VIEW then
    player = player2
  elseif g_display.currentAdmiral == ACKBAR_VIEW then
    player = player3
  elseif g_display.currentAdmiral == THRAWN_VIEW then
    player = player4
  end
  if info == "admiral" then
    return player.admiral
  elseif info == "team" then
    return player.team
  elseif info == "color" then
    return player.color
  elseif info == "population" then
    return player.population
  elseif info == "player" then
    return player
  end
end
function love.load()
  InitGrid()
  InitPlanet()
  ButtonMenu()
  ButtonSettings()
  ButtonDifficulty()
  ButtonPlayer()
  ButtonPopulation()
  ButtonBatiment()
  ButtonBonus()
  ButtonMove()
end
function love.update(dt)
  updateMusic()
  
  mx = love.mouse.getX()
  my = love.mouse.getY()

  if g_display.currentStage == GAME_STAGE then
    
    if love.mouse.isDown(2) then
      offsetX = offsetX + (mx - startMoveX) / zoomX -- modify the offset while moving
      offsetY = offsetY + (my - startMoveY) / zoomY
      startMoveX = mx -- capture the mouse until the end of moving
      startMoveY = my
    end
    if love.mouse.isDown(1) then
      g_drawArrow = true
    else
      g_drawArrow = false
    end

    outAllShip(g_selectedPlanet, g_endPlanet)
    g_endPlanet = nil
    moveAttAllShip(dt)
    --resetShipPosition()

    botCreateTimer = botCreateTimer + dt
    if botCreateTimer >= botCreateTimeOver then
      botCreateSpecificUnit("colon", 30) -- create colon
      botCreateAppropriateUnit() -- create worker, scientist
      botCreateSpecificUnit("soldier", 30) -- create soldier
      botCreateTimer = 0
    end

    botAttackTimer = botAttackTimer + dt
    if botAttackTimer >= botAttackTimeOver then
      for i, planet in ipairs(planetGridTable) do
        if planet.admiral ~= youPlayer("admiral") and planet.admiral ~= nil then--and planet.nbSoldier > 0 then
          local targetPlanet = botFindTarget(planet)
          if targetPlanet ~= nil then
            botAttack(planet, targetPlanet)
            botAttackTimer = 0
            updateBotTimer()
          end
        end
      end
    end

    botHelpTimer = botHelpTimer + dt
    if botHelpTimer >= botHelpTimeOver then
      for i, planet in ipairs(planetGridTable) do
        if planet.admiral ~= youPlayer("admiral") and planet.admiral ~= nil then
          local helpPlanet = botFindHelpPlanet(planet)
          if helpPlanet ~= nil and (planet.population > helpPlanet.population +10 or planet.population >= planet.max) then
            botHelp(planet, helpPlanet)
            botHelpTimer = 0
          end
        end
      end
    end

    botUpgrade()
    if g_display.bonus == true then
      botBonus(dt)
    end
    
    updatePlanet(dt)
    updatePopulation()
    bonusPlanet(dt)
    lose()
    win()
    collision()
    
    
    if g_display.meteorite == true then
      timerMeteorite = timerMeteorite + dt
      if timerMeteorite >= timeOverMeteorite then
        timerMeteorite = 0
        local side = love.math.random(4)
        createMeteorite(side)
      end
    else
      meteoriteTable = {}
    end
    moveMeteorite()
    
    if g_display.blackHole == true then
      timerBlackHole = timerBlackHole + dt
      if timerBlackHole >= timeOverBlackHole then
        timerBlackHole = 0
        createBlackHole()
      end
    else
      blackHoleTable = {}
    end
    deleteBlackHole(dt)
    
    if g_display.starKiller == true then
      timerStarKiller = timerStarKiller + dt
      if timerStarKiller >= timeOverStarKiller then
        timerStarKiller = 0
        createStarKiller()
      end
    else
      starKillerTable = {}
    end
    moveStarKiller()
    
    timerShoot = timerShoot + dt
    if timerShoot >= timeOverShoot then
      timerShoot = 0
      createLaser()
    end
    moveLaser()
    
    gameTimer = gameTimer + dt
    
  end
end
function outAllShip(planet1, planet2)
  if planet1 ~= nil and planet2 ~= nil then

    local team = planet1.team
    local color = planet1.color
    local admiral = planet1.admiral
    local size = 10
    local speed = 1
    if planet1.hyperSpace == true then
      speed = 10
    end
    local delayI = 0
    local delayJ = planet1.moveInhabitant
    local delayK = delayJ + planet1.moveColon
    local delayL = delayK + planet1.moveWorker
    local delayM = delayL + planet1.moveScientist

    for i = 1, planet1.moveInhabitant  do
      local feature = "Inhabitant"
      local hp = 1
      local att = 0
      local time = delayI + i -1
      local position = (i % 5) - 2
      createShip(planet1.l,planet1.c,planet2.l,planet2.c, time, team, feature, hp, att, speed, position, color, admiral, size)
      planet1.moveInhabitant = planet1.moveInhabitant - 1
    end

    for j = 1, planet1.moveColon  do
      local feature = "Colon"
      local hp = 1
      local att = 0
      local time = delayJ + j -1
      local position = (j % 5) - 2
      createShip(planet1.l,planet1.c,planet2.l,planet2.c, time, team, feature, hp, att, speed, position, color, admiral, size)
      planet1.moveColon = planet1.moveColon - 1
    end

    for k = 1, planet1.moveWorker  do
      local feature = "Worker"
      local hp = 1
      local att = 0
      local time = delayK + k -1
      local position = (k % 5) - 2
      createShip(planet1.l,planet1.c,planet2.l,planet2.c, time, team, feature, hp, att, speed, position, color, admiral, size)
      planet1.moveWorker = planet1.moveWorker - 1
    end

    for l = 1, planet1.moveScientist do
      local feature = "Scientist"
      local hp = 1
      local att = 0
      local time = delayL + l -1
      local position = (l % 5) - 2
      createShip(planet1.l,planet1.c,planet2.l,planet2.c, time, team, feature, hp, att, speed, position, color, admiral, size)
      planet1.moveScientist = planet1.moveScientist - 1
    end

    for m = 1, planet1.moveSoldier do
      local feature = "Soldier"
      local hp = 1 
      local att = 1 + math.floor(planet1.warIndustry/100*3)
      local time = delayM + m -1
      local position = (m % 5) - 2
      createShip(planet1.l,planet1.c,planet2.l,planet2.c, time, team, feature, hp, att, speed, position, color, admiral, size)
      planet1.moveSoldier = planet1.moveSoldier - 1
    end

    planet1.spaceJump = false
    planet1.hyperSpace = false
  end
end

function moveAttAllShip(dt)
  for i, ship in ipairs(shipGridTable) do
    ship.time = ship.time - dt*10
    if ship.time <= 0 then
      local speed = ship.speed
      if ship.x < ship.endX then
        ship.x = ship.x + speed
      end
      if ship.x > ship.endX then
        ship.x = ship.x - speed
      end
      if ship.y < ship.endY then
        ship.y = ship.y + speed
      end
      if ship.y > ship.endY then
        ship.y = ship.y - speed
      end
      if ship.x == ship.endX and ship.y == ship.endY then
        for i, planet in ipairs(planetGridTable) do
          local planetX, planetY = getXY(planet.l,planet.c)
          if planetX == ship.x and planetY == ship.y then
            collisionSound:stop()
            collisionSound:play()
            if planet.team ~= ship.team then
              local att = 0
              planet.nbInhabitant = planet.nbInhabitant - ship.att
              if planet.nbInhabitant < 0 then
                att = math.abs(planet.nbInhabitant)
                planet.moveInhabitant = planet.moveInhabitant - att
                planet.nbInhabitant = 0
                if planet.moveInhabitant < 0 then
                  att = math.abs(planet.moveInhabitant)
                  planet.nbColon = planet.nbColon - att
                  planet.moveInhabitant = 0
                  if planet.nbColon < 0 then
                    att = math.abs(planet.nbColon)
                    planet.moveColon = planet.moveColon - att
                    planet.nbColon = 0
                    if planet.moveColon < 0 then
                      att = math.abs(planet.moveColon)
                      planet.nbWorker = planet.nbWorker - att
                      planet.moveColon = 0
                      if planet.nbWorker < 0 then
                        att = math.abs(planet.nbWorker)
                        planet.moveWorker = planet.moveWorker - att
                        planet.nbWorker = 0
                        if planet.moveWorker < 0 then
                          att = math.abs(planet.moveWorker)
                          planet.nbScientist = planet.nbScientist - att
                          planet.moveWorker = 0
                          if planet.nbScientist < 0 then
                            att = math.abs(planet.nbScientist)
                            planet.moveScientist = planet.moveScientist - att
                            planet.nbScientist = 0
                            if planet.moveScientist < 0 then
                              att = math.abs(planet.moveScientist)
                              planet.nbSoldier = planet.nbSoldier - att
                              planet.moveScientist = 0
                              if planet.nbSoldier < 0 then
                                att = math.abs(planet.nbSoldier)
                                planet.moveSoldier = planet.moveSoldier - att
                                planet.nbSoldier = 0
                                if planet.moveSoldier <= 0 then
                                  resetBonus(planet)
                                  reward(planet, ship.admiral)
                                  planet.team = ship.team
                                  planet.admiral = ship.admiral
                                  planet.color = ship.color
                                  planet.nbSoldier = math.abs(planet.moveSoldier)
                                  planet.moveSoldier = 0
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            elseif planet.team == ship.team then
              planet.nbInhabitant = planet.nbInhabitant + ship.hp
            end
          end
        end
        table.remove(shipGridTable, i)
      end
    end
  end
end 
function drawCursor()
  local mx, my = love.mouse.getPosition()
  if virus.on == true or destroyer.on == true or shield.on == true or spaceJump.on == true or hyperSpace.on == true then
    love.mouse.setVisible(false)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(bonusCursor, mx , my , 0, 0.075, 0.075, bonusCursor:getWidth()/2, bonusCursor:getHeight()/2)
  else
    love.mouse.setVisible(true)
  end
end
function drawArrow()
  if g_selectedPlanet ~= nil and g_selectedPlanet.admiral == youPlayer("admiral") and buttonHot() == false then
    local l, c = findClickedCell(mx, my)
    if l ~= nil and c ~= nil then
      if distanceAttack(g_selectedPlanet.l, g_selectedPlanet.c, l, c, g_selectedPlanet.spaceJump ) == true then
        if g_selectedPlanet.hyperSpace == true then
          love.graphics.setColor(0.2,0.4,0.8)
        else
          love.graphics.setColor(1,1,1)
        end
      else
        love.graphics.setColor(1,0,0)
      end
      local x,y = getXY(g_selectedPlanet.l,g_selectedPlanet.c)
      love.graphics.line(x + Grid.cellSize/ 2+ offsetX, y + Grid.cellSize/ 2 + offsetY,mx /zoomX,my/zoomX)
      love.graphics.circle("fill",mx /zoomX,my/zoomX,5)
    end
  end
end
function drawGameStats(place)
  local imgWidth = 300
  local imgHeight = 400
  local margin = (g_width - 4*imgWidth)/5
  local imgY = g_height/2 - imgHeight/2
  local textY = imgY + imgHeight
  local lineText = 30
  local scaleText = margin
  local titleScale = 10
  
  love.graphics.setColor(1,1,1)
  love.graphics.draw(imgEndLeft)
  love.graphics.draw(imgEndRight, g_width/2)
  
  love.graphics.setColor(0,0,0,0.6)
  love.graphics.rectangle("fill", margin, 0, g_width -2*margin, g_height)
  
  if place == lose then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(imgLose, g_width/2 - imgLose:getWidth()/2, titleScale)
    love.graphics.rectangle("line", g_width/2 - imgLose:getWidth()/2, titleScale, imgLose:getWidth(), imgLose:getHeight())
    
  elseif place == win then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(imgWin, g_width/2 - imgWin:getWidth()/2, titleScale)
    love.graphics.rectangle("line", g_width/2 - imgWin:getWidth()/2, titleScale, imgWin:getWidth(), imgWin:getHeight())
    
  end
  
  love.graphics.setColor(1,1,1)
  love.graphics.print("Game Time: "..math.floor(gameTimer/60).."min"..math.floor(gameTimer%60).."s", scaleText, lineText)
  local difficulty = g_display.currentDifficulty 
  if difficulty == EASY_DIFFICULTY then
    difficulty = "Easy"
  elseif difficulty == MEDIUM_DIFFICULTY then
    difficulty = "Medium"
  elseif difficulty == DIFFICULT_DIFFICULTY then
    difficulty = "Difficult"
  elseif difficulty == HARD_DIFFICULTY then
    difficulty = "Hard"
  end
  love.graphics.print("Game Difficulty: "..difficulty, scaleText, 2*lineText)
  
  for i, player in ipairs(playerTable) do
    local imgX = i*margin + (i-1)*imgWidth
    
    love.graphics.setColor(1,1,1)
    love.graphics.draw(player.img, imgX, imgY)
    
    love.graphics.setColor(unpack(player.color))
    if player.you == false then
      love.graphics.print("Bot", imgX, imgY - lineText)
    else
      love.graphics.print("You", imgX, imgY - lineText)
    end
    love.graphics.rectangle("line", imgX, imgY, imgWidth, imgHeight)
    love.graphics.print(player.admiral, imgX, textY + 0.5*lineText, 0, 1.5, 1.5)
    love.graphics.print("Team: "..player.team, imgX, textY + 2*lineText)
    if player.team == 0 then
      player.populationT = 0
    end
    love.graphics.print("Population: "..player.populationT.."P", imgX, textY + 3*lineText)
    love.graphics.print("Ressource: "..player.ressourceT.."R", imgX, textY + 4*lineText)
    love.graphics.print("Experience: "..player.experienceT.."XP", imgX, textY + 5*lineText)
    
  end
end
function drawMenu()
  local titleScale = 10
  love.graphics.setColor(1,1,1)
  love.graphics.draw(imgMenu, 0, 0, 0,g_width/imgMenu:getWidth(), g_height/imgMenu:getHeight())

  love.graphics.setColor(1,1,1,0.9)
  love.graphics.draw(imgLogo, g_width/2 - imgLogo:getWidth()/2, titleScale)
  love.graphics.rectangle("line", g_width/2 - imgLogo:getWidth()/2, titleScale, imgLogo:getWidth(), imgLogo:getHeight())

  love.graphics.draw(imgWilliamStudio, g_width - imgWilliamStudio:getWidth()/4, g_height-imgWilliamStudio:getHeight()/4, 0, 0.25,0.25)

  DrawMenuButton(g_width/2, 80, 10, 10)
end
function drawControls()
  local titleScale = 10
  local textLine = 40
  local textSize = 1.5

  love.graphics.setColor(1,1,1)
  love.graphics.draw(imgMenu, 0, 0, 0,g_width/imgMenu:getWidth(), g_height/imgMenu:getHeight())
  
  love.graphics.setColor(0,0,0,0.7)
  love.graphics.rectangle("fill", 0, 0, g_width, g_height)
  
  love.graphics.setColor(1,1,1)
  love.graphics.draw(imgControls, g_width/2 - imgControls:getWidth()/2, titleScale)
  love.graphics.rectangle("line", g_width/2 - imgControls:getWidth()/2, titleScale, imgControls:getWidth(), imgControls:getHeight())
  
  love.graphics.setColor(1,1,0)
  love.graphics.print("SPACE: Start the Game/Switch screen view in Game", 0, textLine, 0, textSize, textSize)
  love.graphics.print("TAB: Switch Admiral view in Game", 0, 2*textLine, 0, textSize, textSize)
  
  love.graphics.print("X: Transform all Inhabitant into Colon", 0, 4*textLine, 0, textSize, textSize)
  love.graphics.print("C: Transform all Inhabitant into Worker", 0, 5*textLine, 0, textSize, textSize)
  love.graphics.print("V: Transform all Inhabitant into Scientist", 0, 6*textLine, 0, textSize, textSize)
  love.graphics.print("B: Transform all Inhabitant into Soldier", 0, 7*textLine, 0, textSize, textSize)
  
  love.graphics.print("Q: Move all Inhabitant into MoveInhabitant", 0, 9*textLine, 0, textSize, textSize)
  love.graphics.print("S: Move all Inhabitant into MoveColon", 0, 10*textLine, 0, textSize, textSize)
  love.graphics.print("D: Move all Inhabitant into MoveWorker", 0, 11*textLine, 0, textSize, textSize)
  love.graphics.print("F: Move all Inhabitant into MoveScientist", 0,12*textLine, 0, textSize, textSize)
  love.graphics.print("G: Move all Inhabitant into MoveSoldier", 0, 13*textLine, 0, textSize, textSize)
  
  love.graphics.print("A: Move all Inhabitant into MoveInhabitant", 0, 15*textLine, 0, textSize, textSize)
  love.graphics.print("Z: Move all Colon into MoveColon", 0, 16*textLine, 0, textSize, textSize)
  love.graphics.print("E: Move all Worker into MoveWorker", 0, 17*textLine, 0, textSize, textSize)
  love.graphics.print("R: Move all Scientist into MoveScientist", 0, 18*textLine, 0, textSize, textSize)
  love.graphics.print("T: Move all Soldier into MoveSoldier", 0, 19*textLine, 0, textSize, textSize)
  
  love.graphics.print("1: Move all Inhabitant into MoveInhabitant", 0, 21*textLine, 0, textSize, textSize)
  love.graphics.print("2: Move all Inhabitant y all Colon into MoveColon", 0, 22*textLine, 0, textSize, textSize)
  love.graphics.print("3: Move all Inhabitant y all Worker into MoveWorker", 0, 23*textLine, 0, textSize, textSize)
  love.graphics.print("4: Move all Inhabitant y all Scientist into MoveScientist", 0, 24*textLine, 0, textSize, textSize)
  love.graphics.print("5: Move all Inhabitant y all Soldier into MoveSoldier", 0, 25*textLine, 0, textSize, textSize)
  
end
function drawRules()
  local titleScale = 10
  love.graphics.setColor(1,1,1)
  love.graphics.draw(imgRules, g_width/2 - imgRules:getWidth()/2, titleScale)
  love.graphics.rectangle("line", g_width/2 - imgRules:getWidth()/2, titleScale, imgRules:getWidth(), imgRules:getHeight())
end
function drawSettings()
  local openTimer = 0
  local openTimeOver = 2
  local windowHeight = 0

  love.graphics.setColor(1,1,1)
  love.graphics.draw(imgScreenSettings, g_width/2 - imgScreenSettings:getWidth()/2, 0)

  --local x = 150
  --love.graphics.draw(imgSetting, g_width/2 - imgSetting:getWidth()*0.7/2, x, 0, 0.7, 0.7)
  love.graphics.draw(imgSetting, g_width/2 - imgSetting:getWidth()/2, scale)

  -- volume
  local textMargin = 30

  local rectWidth = 60
  local rectHeight = 700
  local margin = (g_width/2 - imgScreenSettings:getWidth()/2 - 2 *rectWidth)/3
  local rectX1 = margin
  local rectX2 = 2*margin + rectWidth
  local rectY = g_height/2 - rectHeight/3

  love.graphics.setColor(1,1,1)
  local sV = math.floor(soundVolume*100)
  local mV = math.floor(musicVolume*100)
  love.graphics.print("Sound : "..sV.."%", rectX1, rectY - textMargin, 0, 1.6, 1.6)
  love.graphics.print("Music : "..mV.."%", rectX2, rectY - textMargin, 0, 1.6, 1.6)

  love.graphics.rectangle("fill", rectX1, rectY + rectHeight, rectWidth, - soundVolume * rectHeight)
  love.graphics.rectangle("fill", rectX2, rectY + rectHeight, rectWidth, - musicVolume * rectHeight)

  love.graphics.setColor(1,1,0)
  love.graphics.rectangle("line", rectX1, rectY, rectWidth, rectHeight)
  love.graphics.rectangle("line", rectX2, rectY, rectWidth, rectHeight)
  love.graphics.rectangle("line", 0, 0, g_width, g_height)
  love.graphics.rectangle("line", g_width/2 - imgScreenSettings:getWidth()/2, 0, imgScreenSettings:getWidth(), g_height)

  local mx, my = love.mouse.getPosition()
  local hot1 = mx > rectX1  and mx < rectX1 + rectWidth and my > rectY and my < rectY + rectHeight
  local hot2 = mx > rectX2  and mx < rectX2 + rectWidth and my > rectY and my < rectY + rectHeight

  if hot1 == true and love.mouse.isDown(1) then
    soundVolume = (g_height - my - g_height + rectHeight + rectY) / rectHeight 
  elseif hot2 == true and love.mouse.isDown(1) then
    musicVolume = (g_height - my - g_height + rectHeight + rectY) / rectHeight 
  end 

  -- button
  local button_width = 300
  local button_height = 60
  local textOffset = 30
  local marginX = (g_width/2 -imgScreenSettings:getWidth()/2 - button_width)/2
  local marginY = (rectHeight - 5*button_height)/4 

  DrawSettingsButton(button_width, button_height, textOffset, marginY, marginX, rectY)
end
function drawDifficulty()
  local titleScale = 10
  love.graphics.setColor(1,1,1)
  love.graphics.draw(imgMenu, 0, 0, 0,g_width/imgMenu:getWidth(), g_height/imgMenu:getHeight())

  love.graphics.setColor(1,1,1,0.9)
  love.graphics.draw(imgDifficulty, g_width/2 - imgDifficulty:getWidth()/2, titleScale)
  love.graphics.rectangle("line", g_width/2 - imgDifficulty:getWidth()/2, titleScale, imgDifficulty:getWidth(), imgDifficulty:getHeight())

  DrawDifficultyButton(g_width/2, 80, 10, 10)
end
function drawAdmiral()
  local imgWidth = 400 -- fixe
  local margin = (g_width - 4*imgWidth) / 5
  love.graphics.setColor(1,1,1)
  love.graphics.draw(imgSpace)
  DrawPlayerButton()
  --
  love.graphics.draw(imgYularen, margin , 50  )
  love.graphics.draw(imgTrench, 2*margin + imgWidth , 50 )
  love.graphics.draw(imgAckbar, 3*margin + 2*imgWidth , 50 )
  love.graphics.draw(imgThrawn, 4*margin + 3*imgWidth , 50 )
  --
  love.graphics.draw(imgGalacticRepublic, margin , 4/7*g_height)
  love.graphics.draw(imgCIS, 2*margin + imgWidth , 4/7*g_height)
  love.graphics.draw(imgRebelAlliance, 3*margin + 2*imgWidth , 4/7*g_height)
  love.graphics.draw(imgGalacticEmpire, 4*margin + 3*imgWidth , 4/7*g_height)
end
function drawGameInfo()
  local info_Height = 40
  local playerY = youPlayer("player")
  local colorY = youPlayer("color")
  local playerB = botPlayer("player")
  local colorB = botPlayer("color")

  love.graphics.setColor(0.2,0.2,0.2)
  love.graphics.rectangle("fill", 0, 0, g_width, info_Height)
  love.graphics.setColor(0.8,0.8,0.8)
  love.graphics.line( 0, info_Height, g_width, info_Height)
  love.graphics.setColor(unpack(colorY))
  love.graphics.print(" Team: "..youPlayer("team"), 175, 10)
  love.graphics.print(" Planet: "..getNbPlanet(youPlayer("admiral")), 250, 10)
  love.graphics.print(" Ressources: "..playerY.ressource.."R", 350, 10)
  love.graphics.print(" Experience: "..playerY.experience.."Xp", 500, 10)
  love.graphics.print(" Population: "..getPopulation(youPlayer("admiral")).."P", 650, 10)

  love.graphics.setColor(unpack(colorB))
  love.graphics.print(" Population: "..getPopulation(botPlayer("admiral")).."P", g_width-800, 10)
  love.graphics.print(" Experience: "..playerB.experience.."Xp",  g_width-650, 10)
  love.graphics.print(" Ressources: "..playerB.ressource.."R",  g_width-500 , 10)
  love.graphics.print(" Planet: "..getNbPlanet(botPlayer("admiral")),  g_width-350, 10)
  love.graphics.print(" Team: "..botPlayer("team"), g_width-250, 10)

  local populationTotale = player1.population + player2.population +  player3.population + player4.population
  local rectWidth = 300
  local rectHeight = 30
  local rectX = (g_width - rectWidth)/2
  local rectY = (info_Height - rectHeight)/2

  local widthP1 = player1.population/populationTotale*rectWidth
  local widthP2 = player2.population/populationTotale*rectWidth
  local widthP3 = player3.population/populationTotale*rectWidth
  local widthP4 = player4.population/populationTotale*rectWidth

  love.graphics.setColor(0.8,0.8,0.8)
  love.graphics.rectangle("line", rectX, rectY, rectWidth, rectHeight) -- contour

  love.graphics.setColor(unpack(REPUBLIC_COLOR))
  love.graphics.rectangle("fill", rectX, rectY, player1.population/populationTotale*rectWidth, rectHeight) --  population
  love.graphics.setColor(unpack(CIS_COLOR))
  love.graphics.rectangle("fill", rectX + widthP1, rectY, player2.population/populationTotale*rectWidth, rectHeight) -- botPopulation
  love.graphics.setColor(unpack(REBEL_COLOR))
  love.graphics.rectangle("fill", rectX + widthP1 + widthP2, rectY, player3.population/populationTotale*rectWidth, rectHeight) -- botPopulation
  love.graphics.setColor(unpack(EMPIRE_COLOR))
  love.graphics.rectangle("fill", rectX + widthP1 + widthP2 + widthP3, rectY, player4.population/populationTotale*rectWidth, rectHeight) -- botPopulation

  -- draw admiral head
  rectWidth = 150
  rectHeight = 200
  love.graphics.setColor(0.2,0.2,0.2)
  love.graphics.rectangle("fill", 0, 0,rectWidth,rectHeight)
  love.graphics.rectangle("fill", g_width-rectWidth, 0, rectWidth, rectHeight)

  love.graphics.setColor(0.8,0.8,0.8)
  love.graphics.rectangle("line", 0, 0,rectWidth,rectHeight)
  love.graphics.rectangle("line", g_width-rectWidth, 0, rectWidth, rectHeight)

  love.graphics.setColor(1,1,1,1)
  local admiral =youPlayer("admiral")
  if admiral == REPUBLIC_ADMIRAL then
    love.graphics.draw(imgYularenHead,0,0,0,0.5,0.5)
  elseif admiral == CIS_ADMIRAL then
    love.graphics.draw(imgTrenchHead,0,0,0,0.5,0.5)
  elseif admiral == REBEL_ADMIRAL then
    love.graphics.draw(imgAckbarHead,0,0,0,0.5,0.5)
  elseif admiral == EMPIRE_ADMIRAL then
    love.graphics.draw(imgThrawnHead,0,0,0,0.5,0.5)
  end

  if g_display.currentAdmiral == YULAREN_VIEW then
    love.graphics.draw(imgYularenHead,g_width-rectWidth,0,0,0.5,0.5)
  elseif g_display.currentAdmiral == TRENCH_VIEW then
    love.graphics.draw(imgTrenchHead,g_width-rectWidth,0,0,0.5,0.5)
  elseif g_display.currentAdmiral == ACKBAR_VIEW then
    love.graphics.draw(imgAckbarHead,g_width-rectWidth,0,0,0.5,0.5)
  elseif g_display.currentAdmiral == THRAWN_VIEW then
    love.graphics.draw(imgThrawnHead,g_width-rectWidth,0,0,0.5,0.5)
  end

  if botPlayer("population") <= 0 then
    love.graphics.setColor(1,0,0)
    love.graphics.line(g_width-rectWidth, 0, g_width-rectWidth + rectWidth, rectHeight)
    love.graphics.line(g_width-rectWidth, rectHeight, g_width-rectWidth + rectWidth, 0)
  end
end
function drawGameScreens()
  -- screen left
  local triHeight = 200
  local triWidth = 400
  local screenWidth = 300
  local screenHeight = 200

  love.graphics.setColor(0.2,0.2,0.2)
  love.graphics.polygon("fill", screenWidth, g_height-screenHeight, screenWidth + triWidth, g_height, screenWidth, g_height)
  love.graphics.polygon("fill", g_width-screenWidth-triWidth, g_height, g_width-screenWidth, g_height-screenHeight, g_width-screenWidth, g_height)

  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill", 0, g_height-screenHeight,screenWidth,screenHeight)
  love.graphics.rectangle("fill", g_width-screenWidth, g_height-screenHeight, screenWidth, screenHeight)

  love.graphics.setColor(1,1,1)
  if g_selectedPlanet == nil then
    love.graphics.draw(imgScreen1, 0, g_height-screenHeight, 0, 1/4, 1/4)
    love.graphics.draw(imgScreen2, g_width-screenWidth, g_height-screenHeight, 0, 1/4, 1/4)
  else
    local planet = g_selectedPlanet
    local imgSize = 200
    local imgOffset = 50
    love.graphics.setColor(1,1,1)
    love.graphics.draw(planet.img, imgOffset, g_height-imgSize, 0, imgSize/planet.img:getWidth(), imgSize/planet.img:getHeight())
  end

  love.graphics.setColor(0.8,0.8,0.8)
  love.graphics.rectangle("line", 0, g_height-screenHeight,screenWidth,screenHeight)
  love.graphics.rectangle("line", g_width-screenWidth, g_height-screenHeight, screenWidth, screenHeight)

  love.graphics.line(screenWidth, g_height-screenHeight, screenWidth + triWidth, g_height)
  love.graphics.line(g_width-screenWidth-triWidth, g_height, g_width-screenWidth, g_height-screenHeight)

  --screen right
  local line = 40
  local size = 30
  offset = 4
  local x = g_width-screenWidth + offset
  local y = g_height-screenHeight + offset
  local space  = 50
  
  if g_selectedPlanet ~= nil then
    local planet = g_selectedPlanet
    local color = planet.color
    love.graphics.setColor(unpack(color))
    love.graphics.circle("line", x + size/2, y + size/2, size/2)
    love.graphics.circle("fill", x + size/2, y + line + size/2, size/2)
    love.graphics.rectangle("fill", x, y + 2*line, size, size)
    love.graphics.rectangle("line", x, y + 3*line, size, size)
    love.graphics.polygon("fill", x, y + 4*line, x + size, y + 4*line, x + size/2, y + size + 4*line)
    
    local textSize = 2
    love.graphics.print(planet.inhabitant, x + space, y, 0, textSize, textSize)
    love.graphics.print(planet.colon, x + space, y + line, 0, textSize, textSize)
    love.graphics.print(planet.worker, x + space, y + 2*line, 0, textSize, textSize)
    love.graphics.print(planet.scientist, x + space, y + 3*line, 0, textSize, textSize)
    love.graphics.print(planet.soldier, x + space, y + 4*line, 0, textSize, textSize)
    --
    love.graphics.print("City Lvl: "..planet.cityLvl, x + 3*space, y + line, 0, textSize, textSize)
    love.graphics.print("Mine Lvl: "..planet.mineLvl, x + 3*space, y + 2*line, 0, textSize, textSize)
    love.graphics.print("Lab Lvl: "..planet.laboratoryLvl, x + 3*space, y + 3*line, 0, textSize, textSize)
    love.graphics.print("Base Lvl: "..planet.warBaseLvl, x + 3*space, y + 4*line, 0, textSize, textSize)
  end
end
function drawPlanetScreen()
  local colorY = youPlayer("color")
  
  for i, planet in ipairs(planetGridTable) do
    if g_selectedPlanet ~= nil and planet == g_selectedPlanet then
      local screenWidth = 300
      local screenHeight = 200
      local button_height = 60
      local button_width = 180
      local rectWidth = 200
      local rectHeight = g_height /1.75
      local margin = ((rectHeight) - (4*button_height))/5
      local rectX = g_width - rectWidth
      local rectY = g_height - rectHeight - screenHeight
      local textX = 10
      local textY = rectY
      local offset = 10

      if planet.admiral == youPlayer("admiral") then
        love.graphics.setColor(0.2,0.2,0.2)
        love.graphics.rectangle('fill', rectX , rectY , rectWidth, rectHeight)
        love.graphics.setColor(0.8,0.8,0.8)
        love.graphics.rectangle('line', rectX , rectY , rectWidth, rectHeight)

        if g_display.currentView == POPULATION_VIEW then
          love.graphics.setColor(unpack(colorY))
          love.graphics.print("POPULATION VIEW", rectX + textX, textY)
          --
          love.graphics.print("Free: "..planet.nbInhabitant.." Work: "..planet.nbColon, rectX + textX, textY + margin + button_height)
          love.graphics.print("Free: "..planet.nbInhabitant.." Work: "..planet.nbWorker, rectX + textX, textY + 2*margin + 2*button_height)
          love.graphics.print("Free: "..planet.nbInhabitant.." Work: "..planet.nbScientist, rectX + textX, textY + 3*margin + 3*button_height)
          love.graphics.print("Free: "..planet.nbInhabitant.." Work: "..planet.nbSoldier, rectX + textX, textY + 4*margin + 4*button_height)

          DrawPopulationButton( colorY, button_width, button_height, margin, offset, rectY)
        end

        if g_display.currentView == BATIMENT_VIEW then
          love.graphics.setColor(unpack(colorY))

          love.graphics.print("BATIMENT VIEW", rectX + textX, textY)
          --
          love.graphics.print("Lvl: "..planet.cityLvl.."\r\nNext Lvl: "..((planet.cityLvl + 1) * 24).."R", rectX + textX, textY + margin + button_height)
          love.graphics.print("Lvl: "..planet.mineLvl.."\r\nNext Lvl: "..((planet.mineLvl + 1) * 32).."R", rectX + textX, textY + 2*margin + 2*button_height)
          love.graphics.print("Lvl: "..planet.laboratoryLvl.."\r\nNext Lvl: "..((planet.laboratoryLvl + 1) * 28).."R", rectX + textX, textY + 3*margin + 3*button_height)
          love.graphics.print("Lvl: "..planet.warBaseLvl.."\r\nNext Lvl: "..((planet.warBaseLvl + 1) * 20).."R", rectX + textX, textY + 4*margin + 4*button_height)

          DrawBatimentButton( colorY, button_width, button_height, margin, offset, rectY)
        end

        if g_display.currentView == BONUS_VIEW and g_display.bonus == true then
          button_height = 60
          margin = ((rectHeight) - (5*button_height))/6

          love.graphics.setColor(unpack(colorY))

          love.graphics.print("BONUS VIEW", rectX + textX, textY)
          --
          love.graphics.print("Price: 20Xp", rectX + textX, textY + margin + button_height)
          love.graphics.print("Price: 60Xp", rectX + textX, textY + 2*margin + 2*button_height)
          love.graphics.print("Price: 200Xp", rectX + textX, textY + 3*margin + 3*button_height)
          love.graphics.print("Price: 20Xp", rectX + textX, textY + 4*margin + 4*button_height)
          love.graphics.print("Price: 40Xp", rectX + textX, textY + 5*margin + 5*button_height)

          DrawBonusButton( colorY, button_width, button_height, margin, offset, rectY)
        end
      end

      -- PLANET VIEW
      local lineHeight = 25

      love.graphics.setColor(0.4,0.4,0.4)
      love.graphics.rectangle('fill', 0 , textY , rectWidth, rectHeight)

      love.graphics.setColor(0.8,0.8,0.8)
      love.graphics.rectangle('line', 0 , textY , rectWidth, rectHeight)

      love.graphics.setColor(0.2,0.2,0.2)
      love.graphics.rectangle('fill', textX , textY + lineHeight , rectWidth - 2*offset, 4*lineHeight)
      love.graphics.rectangle('fill', textX , textY + 6*lineHeight , rectWidth - 2*offset, 5*lineHeight)
      love.graphics.rectangle('fill', textX , textY + 12*lineHeight , rectWidth - 2*offset, 3*lineHeight)
      love.graphics.rectangle('fill', textX , textY + 16*lineHeight , rectWidth - 2*offset, 4*lineHeight)
      love.graphics.rectangle('fill', textX, textY + 21*lineHeight , rectWidth - 2*offset, 3.7*lineHeight)

      love.graphics.setColor(0.8,0.8,0.8)
      love.graphics.rectangle('line', textX , textY + lineHeight , rectWidth - 2*offset, 4*lineHeight)
      love.graphics.rectangle('line', textX , textY + 6*lineHeight , rectWidth - 2*offset, 5*lineHeight)
      love.graphics.rectangle('line', textX , textY + 12*lineHeight , rectWidth - 2*offset, 3*lineHeight)
      love.graphics.rectangle('line', textX , textY + 16*lineHeight , rectWidth - 2*offset, 4*lineHeight)
      love.graphics.rectangle('line', textX, textY + 21*lineHeight , rectWidth - 2*offset, 3.7*lineHeight)


      love.graphics.setColor(unpack(planet.color))
      textX = 20
      love.graphics.print("PLANET VIEW", textX, textY)
      love.graphics.print("Name: "..planet.name, textX, textY + lineHeight)
      love.graphics.print("Region: "..planet.region, textX, textY + 2*lineHeight)
      love.graphics.print("Team: "..planet.team, textX, textY + 3*lineHeight)
      if planet.admiral ~= nil then
        love.graphics.print(planet.admiral, textX, textY + 4*lineHeight)
      else
        love.graphics.print("Neutral", textX, textY + 4*lineHeight)
      end
      --
      love.graphics.print("Mineral Resources: "..planet.mineralResources.."%", textX, textY + 6*lineHeight)
      love.graphics.print("Scientific Researchs: "..planet.scientificResearchs.."%", textX, textY + 7*lineHeight)
      love.graphics.print("War Industry: "..planet.warIndustry.."%", textX, textY + 8*lineHeight)
      love.graphics.print("Colonisable Planet: "..planet.colonisablePlanet.."%", textX, textY + 9*lineHeight)
      love.graphics.print("Total : "..planet.total.."%", textX, textY + 10*lineHeight)
      --
      love.graphics.print("Birth/5s : "..planet.birth, textX, textY + 12*lineHeight)
      love.graphics.print("Ressource/5s : "..planet.ressource, textX, textY + 13*lineHeight)
      love.graphics.print("Experience/5s : "..planet.experience, textX, textY + 14*lineHeight)
      --
      love.graphics.print("Population: "..planet.population.."/"..planet.max, textX, textY + 16*lineHeight)
      love.graphics.print("On Move: "..planet.move, textX, textY + 17*lineHeight)
      love.graphics.print("On the Planet: "..planet.planet, textX, textY + 18*lineHeight)
      love.graphics.print("Inhabitant: "..planet.nbInhabitant, textX, textY + 19*lineHeight)
      --
      if g_selectedPlanet.virus > 0 then
        love.graphics.print("Virus: "..math.ceil(planet.virus).."s", textX, textY + 21*lineHeight)
      else
        love.graphics.print("Virus: Off", textX, textY + 21*lineHeight)
      end
      if g_selectedPlanet.shield > 0 then
        love.graphics.print("Shield: "..math.ceil(planet.shield).."s", textX, textY + 22*lineHeight)
      else
        love.graphics.print("Shield: Off", textX, textY + 22*lineHeight)
      end
      if g_selectedPlanet.spaceJump == true then
        love.graphics.print("SpaceJump: On", textX, textY + 23*lineHeight)
      else
        love.graphics.print("SpaceJump: Off", textX, textY + 23*lineHeight)
      end
      if g_selectedPlanet.hyperSpace == true then
        love.graphics.print("HyperSpace: On", textX, textY + 24*lineHeight)
      else
        love.graphics.print("HyperSpace: Off", textX, textY + 24*lineHeight)
      end

      -- MOVE VIEW
      if planet.admiral == youPlayer("admiral") then
        local moveButtonHeight = 30
        local moveButtonWidth = 180
        local moveOffset = 10
        local moveMargin = ((g_width-2*screenWidth-2*moveOffset) - (5*moveButtonWidth))/4
        local moveRectHeight = 80
        local moveRectWidth = g_width-2*screenWidth

        love.graphics.setColor(0.2,0.2,0.2)
        love.graphics.rectangle('fill', screenWidth, g_height -moveRectHeight, moveRectWidth, moveRectHeight)
        love.graphics.setColor(0.8,0.8,0.8)
        love.graphics.rectangle('line', screenWidth, g_height -moveRectHeight, moveRectWidth, moveRectHeight)
        --
        love.graphics.setColor(unpack(colorY))

        love.graphics.print("MOVE VIEW" , screenWidth + moveOffset, g_height - moveRectHeight - 2*moveOffset)

        love.graphics.print("Planet: "..planet.nbInhabitant.." Move: "..planet.moveInhabitant, screenWidth + moveOffset, g_height - moveButtonHeight)
        love.graphics.print("Planet: "..planet.nbColon.." Move: "..planet.moveColon, screenWidth + moveOffset + moveMargin + moveButtonWidth, g_height - moveButtonHeight)
        love.graphics.print("Planet: "..planet.nbWorker.." Move: "..planet.moveWorker, screenWidth + moveOffset + 2*moveMargin + 2*moveButtonWidth, g_height - moveButtonHeight)
        love.graphics.print("Planet: "..planet.nbScientist.." Move: "..planet.moveScientist, screenWidth + moveOffset + 3*moveMargin + 3*moveButtonWidth, g_height - moveButtonHeight)
        love.graphics.print("Planet: "..planet.nbSoldier.." Move: "..planet.moveSoldier, screenWidth + moveOffset + 4*moveMargin + 4*moveButtonWidth, g_height - moveButtonHeight)

        DrawMoveButton(colorY, moveButtonHeight, moveButtonWidth, screenWidth, moveOffset, moveMargin, moveRectHeight, moveRectWidth)
      end
    end
  end
end
function drawMap()
  local colorN = {0.5,0.5,0.5}
  local gridColor = {1,1,1,1}
  love.graphics.setColor(1,1,1)
  if g_display.backGround == true then
    love.graphics.draw(imgSpace)
    love.graphics.draw(imgGalaxy, 0 + offsetX, 0 + offsetY)
    gridColor = {0,0,0,0}
  else
    love.graphics.rectangle("fill", 0, 0, g_width, g_height)
    gridColor = {0,0,0}
  end
  
  local h = Grid.cellSize
  local w = h
  local x,y
  for l=1,Grid.height do
    Grid.cells[l] = {}
    for c=1,Grid.width do
      x = (c-1)*w
      y = (l-1)*h
      x = x + offsetX
      y = y + offsetY
      if Map[l][c] == MAP_SPACE then
        love.graphics.setColor(unpack(gridColor))
        love.graphics.rectangle("fill", x, y, w-1, w-1)
      elseif Map[l][c] == MAP_PLANET then
        love.graphics.setColor(unpack(gridColor))
        love.graphics.rectangle("fill", x, y, w-1, w-1)
        for i, planet in ipairs(planetGridTable) do 
          if planet.c == c and planet.l == l then
            if planet.team ~= 0 then
              love.graphics.setColor(unpack(planet.color))
            else
              love.graphics.setColor(unpack(colorN))
            end
          end
        end
        love.graphics.circle("fill", x + w/2, y + w/2, (w)/2, (w)/2)
      elseif Map[l][c] == MAP_BLACKHOLE then
        love.graphics.setColor(unpack(gridColor))
        love.graphics.rectangle("fill", x, y, w-1, w-1)
        for i, blackHole in ipairs(blackHoleTable) do 
          if blackHole.c == c and blackHole.l == l then
            love.graphics.setColor(unpack(blackHole.color))
            love.graphics.circle("fill", x + w/2, y + w/2, (w)/2, (w)/2)
          end
        end
      end
    end
  end
end
function drawShip()
  for i, ship in ipairs(shipGridTable) do
    local position = ship.position *10
    if ship.time <= 0 then
      local color = ship.color
      love.graphics.setColor(unpack(color))
      if ship.feature == "Inhabitant"then
        love.graphics.circle('line', ship.x + position + Grid.cellSize/2 + offsetX , ship.y + position + Grid.cellSize/2 + offsetY, ship.size/2)

      elseif ship.feature == "Colon" then
        love.graphics.circle('fill', ship.x + position + Grid.cellSize/2 + offsetX , ship.y + position + Grid.cellSize/2 + offsetY, ship.size/2)

      elseif ship.feature == "Worker" then
        love.graphics.rectangle('line', ship.x + position +  Grid.cellSize/8 + offsetX , ship.y + position + Grid.cellSize/8 + offsetY, ship.size, ship.size)

      elseif ship.feature == "Scientist" then
        love.graphics.rectangle('fill', ship.x + position + Grid.cellSize/8 + offsetX , ship.y + position + Grid.cellSize/8 + offsetY, ship.size, ship.size)

      elseif ship.feature == "Soldier" then
        love.graphics.polygon('fill', ship.x + position + 10 + offsetX, ship.y + position + 10 + offsetY, ship.x + position +  Grid.cellSize - 10 + offsetX, ship.y + position + 10 + offsetY, ship.x + position + Grid.cellSize/2 + offsetX, ship.y + position + Grid.cellSize - 10 + offsetY)
        love.graphics.setColor(0,0,0)
        love.graphics.print(ship.att, ship.x + position + 15 + offsetX, ship.y + 10 + position + offsetY)

      elseif ship.feature == "Destroyer" then
        love.graphics.polygon('fill', ship.x + offsetX, ship.y + offsetY, ship.x + Grid.cellSize + offsetX, ship.y + offsetY, ship.x + Grid.cellSize/2 + offsetX, ship.y + Grid.cellSize + offsetY)
        love.graphics.setColor(0,0,0)
        love.graphics.print(ship.att, ship.x + 10 + offsetX, ship.y + 5 + offsetY)
      end
    end
  end
end
function drawPlanet()
  for i, planet in ipairs(planetGridTable) do
    local x,y = getXY(planet.l,planet.c)
    local w = Grid.cellSize
    love.graphics.setColor(0,0,0)
    love.graphics.print(planet.population, x + offsetX, y + w/4  + offsetY, 0, 1.2, 1.2)
    if planet.shield > 0 then
      love.graphics.setColor(0,0,1)
      love.graphics.circle("line", x + w/2 + offsetX, y + w/2 + offsetY, 50)
    end
    if planet.virus > 0 then
      love.graphics.setColor(1,0.5,0)
      love.graphics.circle("line", x + w/2 + offsetX, y + w/2 + offsetY, 40)
    end
    if g_selectedPlanet ~= nil and planet == g_selectedPlanet then
      love.graphics.setColor(1,1,1)
      love.graphics.circle("line", x + w/2 + offsetX, y + w/2 + offsetY, Grid.cellSize/2)
    end
  end
end
function drawBlackHole()
  for i, blackHole in ipairs(blackHoleTable) do
    Map[blackHole.l][blackHole.c] = MAP_BLACKHOLE
    local x,y = getXY(blackHole.l,blackHole.c)
    local w = Grid.cellSize
    love.graphics.setColor(1,1,1)
    love.graphics.print(math.ceil(blackHole.hp), x + offsetX, y + w/4  + offsetY, 0, 1.2, 1.2)
  end
end
function drawMeteorite()
  for i, meteorite in ipairs(meteoriteTable) do
    love.graphics.setColor(unpack(meteorite.color))
    love.graphics.circle("fill", meteorite.x + offsetX, meteorite.y + offsetY, meteorite.size)
  end
end
function drawStarKiller()
  for i, starKiller in ipairs(starKillerTable) do
    love.graphics.setColor(1,1,1)
    love.graphics.draw(starKiller.img, starKiller.x + offsetX, starKiller.y +offsetY, 0, 0.25, 0.25 ,starKiller.img:getWidth()/2, starKiller.img:getHeight()/2)
  end
end
function drawLaser()
  for i, laser in ipairs(laserTable) do
    love.graphics.setColor(unpack(laser.color))
    love.graphics.line(laser.starKiller.x + offsetX, laser.starKiller.y + offsetY, laser.x + offsetX, laser.y + offsetY)
  end
end
function love.draw()
  if g_display.currentStage == MENU_STAGE then
    drawMenu()
    
  elseif g_display.currentStage == RULES_STAGE then
    drawRules()
    
  elseif g_display.currentStage == CONTROLS_STAGE then
    drawControls()
    
  elseif g_display.currentStage == SETTING_STAGE or g_display.settings == true then
    drawSettings()
    
  elseif g_display.currentStage == DIFFICULTY_STAGE then
    drawDifficulty()
    
  elseif g_display.currentStage == GAME_STAGE then
    love.graphics.push() 
    love.graphics.scale(zoomX,zoomY)
    drawMap(colorN)
    drawShip()
    drawPlanet()
    drawBlackHole()
    drawMeteorite()
    drawStarKiller()
    drawLaser()
    if g_drawArrow == true then
      drawArrow()
    end
    drawCursor()

    love.graphics.pop()
    drawGameInfo()
    drawGameScreens()
    drawPlanetScreen()

  elseif g_display.currentStage == ADMIRAL_STAGE then  
    drawAdmiral()
    
  elseif g_display.currentStage == LOSE_STAGE then
    drawGameStats(lose)
    
  elseif g_display.currentStage == WIN_STAGE then
    drawGameStats(win)
  end
  
--  if speedX ~= nil and speedY ~= nil then
--    love.graphics.print(speedX, 10, 300)
--    love.graphics.print(speedY, 10, 320)
--  end
--  if distanceX ~= nil and distanceY ~= nil then
--    love.graphics.print(distanceX, 10, 260)
--    love.graphics.print(distanceY, 10, 280)
--  end
end

function love.wheelmoved(x, y)
  --zoom in and out
  mouseMapBeforeZoomX, mouseMapBeforeZoomY = screenToMap(mx, my) -- mouse to map transformation, before zoom
  if y > 0 then --wheelMouseUp
    zoomX = zoomX * 1.101  --odd float number to prevent by zero division (multiply scale, not add to)
    zoomY = zoomY * 1.101
  elseif y < 0 then --wheelMouseDown
    zoomX = zoomX * 0.901 --odd float number to prevent by zero division
    zoomY = zoomY * 0.901
    if zoomX < 1 and zoomY < 1 then -- empêche de trop dézoomer pour pas modifier les lignes entre les cases
      zoomX = 1
      zoomY = 1
    end
  end
  mouseMapAfterZoomX, mouseMapAfterZoomY = screenToMap(mx, my) -- mouse to map transformation, after zoom

  --correct offset while zooming
  offsetX = offsetX - (mouseMapBeforeZoomX - mouseMapAfterZoomX) -- minus correction
  offsetY = offsetY - (mouseMapBeforeZoomY - mouseMapAfterZoomY) 
end

-- callback functions
function love.mousepressed(x, y, button, istouch)
  if button == 2 then
    catchMousePosBeforeMove() --happens only once when btn is pressed

  elseif button == 1 then
    l, c = findClickedCell(mx, my)
    if l == nil or c == nil then
      if buttonHot() == false then
        g_selectedPlanet = nil
        return
      end
    end
    if g_display.settings == true then
      g_selectedPlanet = nil
      return
    end
    for i, planet in ipairs(planetGridTable) do
      if planet.c == c and planet.l == l and buttonHot() == false then 
        g_selectedPlanet = planet
        if virus.on == true then
          bonusSound:play()
          g_selectedPlanet.virus = virus.time
          virus.on = false
        end
        if destroyer.on == true then
          bonusSound:play()
          createDestroyer(biggestPlanet(youPlayer("admiral")), g_selectedPlanet)
          destroyer.on = false
        end
        if shield.on == true then
          bonusSound:play()
          g_selectedPlanet.shield = shield.time
          shield.on = false
        end
        if spaceJump.on == true then
          bonusSound:play()
          g_selectedPlanet.spaceJump = true
          spaceJump.on = false
        end
        if hyperSpace.on == true then
          bonusSound:play()
          g_selectedPlanet.hyperSpace = true
          hyperSpace.on = false
        end
      end
    end
  end
end
function love.mousereleased(x, y, button, istouch)
  if button == 1 then
    local l, c = findClickedCell(mx, my)
    if l == nil or c == nil or g_display.settings == true or buttonHot() == true then
      return
    end
    for i, planet in ipairs(planetGridTable) do
      if planet.c == c and planet.l == l then
        if g_selectedPlanet ~= nil and g_selectedPlanet ~= planet and g_selectedPlanet.team == youPlayer("team") and buttonHot() == false and distanceAttack(g_selectedPlanet.l, g_selectedPlanet.c, planet.l, planet.c, g_selectedPlanet.spaceJump) == true then
          if planet.shield == 0 or planet.team == g_selectedPlanet.team then
            g_endPlanet = planet
          end
        end
      end
    end
  end
end
function love.keypressed(key)
  if key == "escape" then
    if g_display.currentStage == DIFFICULTY_STAGE or g_display.currentStage == SETTING_STAGE or g_display.currentStage == CONTROLS_STAGE or g_display.currentStage == RULES_STAGE then
      g_display.currentStage = MENU_STAGE
    elseif g_display.currentStage == ADMIRAL_STAGE then
      g_display.currentStage = DIFFICULTY_STAGE
    elseif g_display.currentStage == GAME_STAGE and g_display.settings == true then
      g_display.settings = false
      bipSound:stop()
    elseif g_display.currentStage == GAME_STAGE and g_display.settings == false then
      g_display.settings = true
      bipSound:play()
    elseif g_display.currentStage == LOSE_STAGE or g_display.currentStage == WIN_STAGE then
      love.event.quit("restart")
    end
  end
  if key == "space" then
    if g_display.currentStage == ADMIRAL_STAGE then
      local nbr = 0
      for i, player in ipairs(playerTable) do
        if player.you == true then
          nbr = nbr + 1
        end
      end
      if nbr == 1 then
        createPlanet()
        g_display.currentStage = GAME_STAGE
        gameStartSound:play()
      end
    elseif g_display.currentStage == GAME_STAGE then
      if g_selectedPlanet ~= nil then-- and  g_display.settings == fasle then
        switchSound:stop()
        switchSound:play()
        if g_display.currentView == 3 then
          g_display.currentView = 1
        else
          g_display.currentView = g_display.currentView + 1
        end
      end
    end
  end
  if key == "tab" then
    switchSound:stop()
    switchSound:play()
    if g_display.currentAdmiral == 4 then
      g_display.currentAdmiral = 1
    else 
      g_display.currentAdmiral = g_display.currentAdmiral + 1
    end
  end
  if g_selectedPlanet ~= nil then
--    if love.keyboard.isDown("lctrl") then
--      for i, planet in ipairs(planetGridTable) do
--        if planet.admiral == youPlayer("admiral") then
--          table.insert(shortcutTable, planet)
--        end
--      end
--    else
--      table.insert(shortcutTable, g_selectedPlanet)
--    end
--    for i, planet in ipairs(shortcutTable) do
      if g_selectedPlanet.admiral == youPlayer("admiral") then
        if love.keyboard.isDown("1") then
          g_selectedPlanet.moveInhabitant = g_selectedPlanet.moveInhabitant + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("2") then
          g_selectedPlanet.moveColon = g_selectedPlanet.moveColon + g_selectedPlanet.nbColon + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbColon = 0
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("3") then
          g_selectedPlanet.moveWorker = g_selectedPlanet.moveWorker + g_selectedPlanet.nbWorker + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbWorker = 0
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("4") then
          g_selectedPlanet.moveScientist = g_selectedPlanet.moveScientist + g_selectedPlanet.nbScientist + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbScientist = 0
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("5") then
          g_selectedPlanet.moveSoldier = g_selectedPlanet.moveSoldier + g_selectedPlanet.nbSoldier + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbSoldier = 0
          g_selectedPlanet.nbInhabitant = 0
        end

        -- moveFeature = moveFeature + nbFeature
        if love.keyboard.isDown("a") or love.keyboard.isDown("insert") then
          g_selectedPlanet.moveInhabitant = g_selectedPlanet.moveInhabitant + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("z") or love.keyboard.isDown("insert") then
          g_selectedPlanet.moveColon = g_selectedPlanet.moveColon + g_selectedPlanet.nbColon 
          g_selectedPlanet.nbColon = 0
        end
        if love.keyboard.isDown("e") or love.keyboard.isDown("insert") then
          g_selectedPlanet.moveWorker = g_selectedPlanet.moveWorker + g_selectedPlanet.nbWorker 
          g_selectedPlanet.nbWorker = 0
        end
        if love.keyboard.isDown("r") or love.keyboard.isDown("insert") then
          g_selectedPlanet.moveScientist = g_selectedPlanet.moveScientist + g_selectedPlanet.nbScientist 
          g_selectedPlanet.nbScientist = 0
        end
        if love.keyboard.isDown("t") or love.keyboard.isDown("insert") then
          g_selectedPlanet.moveSoldier = g_selectedPlanet.moveSoldier + g_selectedPlanet.nbSoldier
          g_selectedPlanet.nbSoldier = 0
        end

        -- moveFeature = moveFeature + nbInhabitant
        if love.keyboard.isDown("q") then
          g_selectedPlanet.moveInhabitant = g_selectedPlanet.moveInhabitant + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("s") then
          g_selectedPlanet.moveColon = g_selectedPlanet.moveColon + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("d") then
          g_selectedPlanet.moveWorker = g_selectedPlanet.moveWorker + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("f") then
          g_selectedPlanet.moveScientist = g_selectedPlanet.moveScientist + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("g") then
          g_selectedPlanet.moveSoldier = g_selectedPlanet.moveSoldier + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end

        if love.keyboard.isDown("x") then
          g_selectedPlanet.nbColon = g_selectedPlanet.nbColon + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("c") then
          g_selectedPlanet.nbWorker = g_selectedPlanet.nbWorker + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("v") then
          g_selectedPlanet.nbScientist = g_selectedPlanet.nbScientist + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
        if love.keyboard.isDown("b") then
          g_selectedPlanet.nbSoldier = g_selectedPlanet.nbSoldier + g_selectedPlanet.nbInhabitant
          g_selectedPlanet.nbInhabitant = 0
        end
      end
    end
  --end
end