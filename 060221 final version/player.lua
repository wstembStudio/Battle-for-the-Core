REPUBLIC_ADMIRAL = "Admiral Wullf Yularen"
CIS_ADMIRAL = "Admiral Trench"
REBEL_ADMIRAL = "Admiral Gial Ackbar"
EMPIRE_ADMIRAL = "Grand Admiral Thrawn"

REPUBLIC_COLOR = {30/255,144/255,255/255,1}
CIS_COLOR = { 0, 1, 0, 1}
REBEL_COLOR = { 1, 0.5, 0, 1}
EMPIRE_COLOR = { 1, 0, 0, 1}

player1 = {}
player1.admiral = REPUBLIC_ADMIRAL
player1.team = 0
player1.you = false
player1.color = REPUBLIC_COLOR
player1.population = 0
player1.ressource = 0
player1.experience = 0
player1.planet = 0
player1.music = yularenMusic
player1.img = imgYularenHead
player1.populationT = 3
player1.ressourceT = 0
player1.experienceT = 0
table.insert(playerTable, player1)

player2 = {}
player2.admiral = CIS_ADMIRAL
player2.team = 0
player2.you = false
player2.color = CIS_COLOR
player2.population = 0
player2.ressource = 0
player2.experience = 0
player2.planet = 0
player2.music = trenchMusic
player2.img = imgTrenchHead
player2.populationT = 3
player2.ressourceT = 0
player2.experienceT = 0
table.insert(playerTable, player2)

player3 = {}
player3.admiral = REBEL_ADMIRAL
player3.team = 0
player3.you = false
player3.color = REBEL_COLOR
player3.population = 0
player3.ressource = 0
player3.experience = 0
player3.planet = 0
player3.music = ackbarMusic
player3.img = imgAckbarHead
player3.populationT = 3
player3.ressourceT = 0
player3.experienceT = 0
table.insert(playerTable, player3)

player4 = {}
player4.admiral = EMPIRE_ADMIRAL
player4.team = 0
player4.you = false
player4.color = EMPIRE_COLOR
player4.population = 0
player4.ressource = 0
player4.experience = 0
player4.planet = 0
player4.music = thrawnMusic
player4.img = imgThrawnHead
player4.populationT = 3
player4.ressourceT = 0
player4.experienceT = 0
table.insert(playerTable, player4)