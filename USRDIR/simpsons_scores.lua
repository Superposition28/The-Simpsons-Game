--About the ScoreKeeper: The Score Keeper system is a flexible and data driven way to store scores.
--It supports basic scores, which store values, as well as Score Events (collections of operations that
--may be issued as one) and Score Watchers (which trigger actions based on the values of scores).
--The syntax of this document is described in the function SetupTestScores.

--When using this document, please add your scores to the appropriate epsiode function. If you are unsure
--where to attach scores, please see Tom Wilson (tmwilson@ea.com) or Brad McKee (bmckee@ea.com). This will
--help keep the document readable and maintainable as the number of scores grows.

-- Accquire ScoreKeeper
sk = ScoreKeeper:GetScoreKeeper()

-- Versioning
ScoreKeeper:SetScoringVersion(6)

-- Global values
TRUE = 1
FALSE = 0

function SetupEpisodeScores()

	--The following Scores are used by the GameFlowManager.
	--Please do not rename them without updating the gameflowmanager lua script.

	-- Build the basic epsiode blocks
	EpisodeHelper("SPR_HUB", -1, 3, -1, -1, -1, 1)
	EpisodeHelper("LAND_OF_CHOCOLATE", ACHIEVEMENT_CHOCOLATE_VICTORY, 1, 180, ACHIEVEMENT_CHOCOLATE_HEAVEN, 90, 1)
	EpisodeHelper("BARTMAN_BEGINS", ACHIEVEMENT_HEIST_HIJINX, 2, 420, ACHIEVEMENT_UP_AND_ATOM, 60, 1)
	EpisodeHelper("EIGHTY_BITES", ACHIEVEMENT_BURGER_VICTORY, 2, 330, ACHIEVEMENT_TABLE_SMASHER_2000, 90, 1)
	EpisodeHelper("TREEHUGGER", ACHIEVEMENT_BURNS_BABY_BURNS, 2, 480, ACHIEVEMENT_WOOD_CHIPPIN, 30, 1)
	EpisodeHelper("MOB_RULES", ACHIEVEMENT_FIGHT_THE_POWER, 2, 660, ACHIEVEMENT_STEADY_MOBBIN, 120, 1)
	EpisodeHelper("CHEATER", ACHIEVEMENT_POWER_UP, 2, 900, ACHIEVEMENT_ENGINE_FUN, 180, 1)
	EpisodeHelper("DOLPHINS", ACHIEVEMENT_A_PASSIVE_FISH, 1, 390, ACHIEVEMENT_NICE_CANS, 150, 1)
	EpisodeHelper("COLOSSAL_DONUT", ACHIEVEMENT_MMM_DONUT, 1, 240, ACHIEVEMENT_CLOWN_AROUND, 360, 1)
	EpisodeHelper("SPRINGFIELD_STOOD_STILL", ACHIEVEMENT_THE_ALIENATOR, 1, 390, ACHIEVEMENT_MALL_RISING, 180, 1)
	EpisodeHelper("BARGAIN_BIN", ACHIEVEMENT_SAVE_THE_SIMPSONS, 2, 120, ACHIEVEMENT_SIM_SANDWICH, 185, 1)
	EpisodeHelper("GAME_HUB", -1, 2, -1, -1, -1, 1)
	EpisodeHelper("NEVERQUEST", ACHIEVEMENT_DRAGON_SLAYER, 1, 660, ACHIEVEMENT_MY_PRECIOUS, 120, 1)
	EpisodeHelper("GRAND_THEFT_SCRATCHY", ACHIEVEMENT_DOGGIE_DAZED, 1, 1050, ACHIEVEMENT_HOT_COFFEE, 240, 1)
	EpisodeHelper("MEDAL_OF_HOMER", ACHIEVEMENT_VICTORY_AT_SEA, 2, 750, ACHIEVEMENT_SHOOTERS_REJOICE, 270, 1)
	EpisodeHelper("BIG_SUPER", ACHIEVEMENT_SPARKLING_DEFEAT, 3, 1050, ACHIEVEMENT_MAKI_ROLL_MANIA, 120, 1)
	EpisodeHelper("RHYMES_WITH_COMPLAINING", ACHIEVEMENT_ON_THE_MATT, 1, 430, ACHIEVEMENT_BACK_TO_THE_FUTURAMA, 180, 1)
	EpisodeHelper("MEET_THY_PLAYER", ACHIEVEMENT_CLOUD_NINE, 1, 540, ACHIEVEMENT_HEAVENLY_JOY, 60, 1)

	-- Establish the gating structure
	sk:SetScore("SCORE_LAND_OF_CHOCOLATE_LOCKED", 0)

	-- Chapter 0
	CreateNotGate( sk:FindScore("SCORE_LAND_OF_CHOCOLATE_COMPLETE"), "SCORE_SPR_HUB_LOCKED" )
	sk:SetScore("SCORE_BARTMAN_BEGINS_LOCKED", 0)

	-- Chapter 1
	CreateNotGate( sk:FindScore("SCORE_BARTMAN_BEGINS_COMPLETE"), "SCORE_EIGHTY_BITES_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_EIGHTY_BITES_COMPLETE"), "SCORE_TREEHUGGER_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_TREEHUGGER_COMPLETE"), "SCORE_MOB_RULES_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_MOB_RULES_COMPLETE"), "SCORE_CHEATER_LOCKED" )

	-- Chapter 2
	CreateNotGate( sk:FindScore("SCORE_CHEATER_COMPLETE"), "SCORE_COLOSSAL_DONUT_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_CHEATER_COMPLETE"), "SCORE_SPRINGFIELD_STOOD_STILL_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_CHEATER_COMPLETE"), "SCORE_DOLPHINS_LOCKED" )

	input = { sk:FindScore("SCORE_COLOSSAL_DONUT_COMPLETE"),
		    sk:FindScore("SCORE_SPRINGFIELD_STOOD_STILL_COMPLETE"),
		    sk:FindScore("SCORE_DOLPHINS_COMPLETE") }
	CreateNandGate(input, "SCORE_BARGAIN_BIN_LOCKED")

	-- Chapter 3
	CreateNotGate( sk:FindScore("SCORE_BARGAIN_BIN_COMPLETE"), "SCORE_GAME_HUB_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_BARGAIN_BIN_COMPLETE"), "SCORE_NEVERQUEST_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_BARGAIN_BIN_COMPLETE"), "SCORE_MEDAL_OF_HOMER_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_BARGAIN_BIN_COMPLETE"), "SCORE_GRAND_THEFT_SCRATCHY_LOCKED" )

	CreateNotGate( sk:FindScore("SCORE_BARGAIN_BIN_COMPLETE"), "SCORE_BIG_SUPER_LOCKED" )

	input = { sk:FindScore("SCORE_NEVERQUEST_COMPLETE"),
 		    sk:FindScore("SCORE_MEDAL_OF_HOMER_COMPLETE"), 
		    sk:FindScore("SCORE_GRAND_THEFT_SCRATCHY_COMPLETE"),
		    sk:FindScore("SCORE_BIG_SUPER_COMPLETE") }
	CreateNandGate(input, "SCORE_RHYMES_WITH_COMPLAINING_LOCKED")

	-- Chapter 4
	CreateNotGate( sk:FindScore("SCORE_RHYMES_WITH_COMPLAINING_COMPLETE"), "SCORE_MEET_THY_PLAYER_LOCKED" )

	-- Create Cheat Events (as a cascade)
	
	CreateCheatEvent("LAND_OF_CHOCOLATE", "BARTMAN_BEGINS")
	CreateCheatEvent("BARTMAN_BEGINS", "EIGHTY_BITES")
	CreateCheatEvent("EIGHTY_BITES", "TREEHUGGER")
	CreateCheatEvent("TREEHUGGER", "MOB_RULES")
	CreateCheatEvent("MOB_RULES", "CHEATER")
	CreateCheatEvent("CHEATER", "COLOSSAL_DONUT")
	CreateCheatEvent("CHEATER", "SPRINGFIELD_STOOD_STILL")
	CreateCheatEvent("CHEATER", "DOLPHINS")
	CreateCheatEvent("COLOSSAL_DONUT", "BARGAIN_BIN")
	CreateCheatEvent("SPRINGFIELD_STOOD_STILL", "BARGAIN_BIN")
	CreateCheatEvent("DOLPHINS", "BARGAIN_BIN")
	CreateCheatEvent("BARGAIN_BIN", "GAME_HUB")
	CreateCheatEvent("GAME_HUB", "NEVERQUEST")
	CreateCheatEvent("GAME_HUB", "MEDAL_OF_HOMER")
	CreateCheatEvent("GAME_HUB", "BIG_SUPER")
	CreateCheatEvent("GAME_HUB", "GRAND_THEFT_SCRATCHY")
	CreateCheatEvent("NEVERQUEST", "RHYMES_WITH_COMPLAINING")
	CreateCheatEvent("MEDAL_OF_HOMER", "RHYMES_WITH_COMPLAINING")
	CreateCheatEvent("BIG_SUPER", "RHYMES_WITH_COMPLAINING")
	CreateCheatEvent("GRAND_THEFT_SCRATCHY", "RHYMES_WITH_COMPLAINING")
	CreateCheatEvent("RHYMES_WITH_COMPLAINING", "MEET_THY_PLAYER")

	--Costume unlock scores
	score = sk:CreateScore("SCORE_COSTUME_LISA_BIG_SUPER_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_BIG_SUPER_COMPLETE"), "SCORE_COSTUME_LISA_BIG_SUPER_LOCKED")
	score = sk:CreateScore("SCORE_COSTUME_HOMER_BIG_SUPER_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_BIG_SUPER_COMPLETE"), "SCORE_COSTUME_HOMER_BIG_SUPER_LOCKED")
	score = sk:CreateScore("SCORE_COSTUME_HOMER_MEDAL_OF_HOMER_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_MEDAL_OF_HOMER_COMPLETE"), "SCORE_COSTUME_HOMER_MEDAL_OF_HOMER_LOCKED")
	score = sk:CreateScore("SCORE_COSTUME_BART_MEDAL_OF_HOMER_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_MEDAL_OF_HOMER_COMPLETE"), "SCORE_COSTUME_BART_MEDAL_OF_HOMER_LOCKED")
	score = sk:CreateScore("SCORE_COSTUME_HOMER_NEVERQUEST_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_NEVERQUEST_COMPLETE"), "SCORE_COSTUME_HOMER_NEVERQUEST_LOCKED")
	score = sk:CreateScore("SCORE_COSTUME_MARGE_NEVERQUEST_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_NEVERQUEST_COMPLETE"), "SCORE_COSTUME_MARGE_NEVERQUEST_LOCKED")

	score = sk:CreateScore("SCORE_BIG_SUPER_COSTUME_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_BIG_SUPER_COMPLETE"), "SCORE_BIG_SUPER_COSTUME_LOCKED")
	score = sk:CreateScore("SCORE_MEDAL_OF_HOMER_COSTUME_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_MEDAL_OF_HOMER_COMPLETE"), "SCORE_MEDAL_OF_HOMER_COSTUME_LOCKED")
	score = sk:CreateScore("SCORE_NEVERQUEST_COSTUME_LOCKED", 1)
	score:SetStorage("session")
	CreateNotGate( sk:FindScore("SCORE_NEVERQUEST_COMPLETE"), "SCORE_NEVERQUEST_COSTUME_LOCKED")

end

function SetupPowerMax()

	local numTrophiesRequiredForIncrease = 6
	local incVal = 500
	local startAmt = 1000
	
	score = sk:CreateScore("SCORE_TROPHIES_NEEDED_BEFORE_POWER_UPGRADE", numTrophiesRequiredForIncrease )
	score:SetStorage("session")
	score:AddEventWatcher("SCORE_EVENT_POWER_INCREASE", 0, 1)

	score = sk:CreateScore("SCORE_POWER_LEVEL_BART", 0)
	score:SetStorage("global")

	score = sk:CreateScore("SCORE_POWER_LEVEL_MARGE", 0)
	score:SetStorage("global")
	
	score = sk:CreateScore("SCORE_POWER_LEVEL_LISA", 0)
	score:SetStorage("global")
	
	score = sk:CreateScore("SCORE_POWER_LEVEL_HOMER", 0)
	score:SetStorage("global")

	score = sk:CreateScore("SCORE_POWER_LEVEL_BART_SESSION", -1)
	score:SetStorage("session")

	score = sk:CreateScore("SCORE_POWER_LEVEL_MARGE_SESSION", -1)
	score:SetStorage("session")
	
	score = sk:CreateScore("SCORE_POWER_LEVEL_LISA_SESSION", -1)
	score:SetStorage("session")
	
	score = sk:CreateScore("SCORE_POWER_LEVEL_HOMER_SESSION", -1)
	score:SetStorage("session")
	
	event = sk:CreateScoreEvent("SCORE_EVENT_POWER_INCREASE")
	event:AddNumericOp("set", "SCORE_TROPHIES_NEEDED_BEFORE_POWER_UPGRADE", numTrophiesRequiredForIncrease )
	event:AddNumericOp("add", "SCORE_POWER_MAX_BART", incVal)
	event:AddMessageOp("iMsgBARTPowerIncreased")
	event:AddNumericOp("add", "SCORE_POWER_MAX_HOMER", incVal)
	event:AddMessageOp("iMsgHOMERPowerIncreased")
	event:AddNumericOp("add", "SCORE_POWER_MAX_MARGE", incVal)
	event:AddMessageOp("iMsgMARGEPowerIncreased")
	event:AddNumericOp("add", "SCORE_POWER_MAX_LISA", incVal)
	event:AddMessageOp("iMsgLISAPowerIncreased")
	event:AddMessageOp("iMsgShowPowerIncreaseScreen")

	score = sk:CreateScore("SCORE_POWER_INFINITE", 0)
	score:SetStorage("session")
	score:AddMessageWatcher("iMsgPowerInfinite", 1, 2)
	score:AddMessageWatcher("iMsgShowInfinitePowerScreen", 1, 2)

	score = sk:CreateScore("SCORE_POWER_MAX_DEFAULT", startAmt)
	score:SetConstraint("constant")

	-- Scores for Building out Power Max.
	-- syntax who, startAmt
	BuildPowerScores("BART", startAmt)
	BuildPowerScores("HOMER", startAmt)
	BuildPowerScores("MARGE", startAmt)
	BuildPowerScores("LISA", startAmt)

end

function SetupGenericTutorial( scoreName, message )
	score = sk:CreateScore( scoreName, 0 )
	score:SetStorage( "session" )
	score:AddMessageWatcher( message, 1, 2 )
end

function SetupTutorialScores()
	SetupGenericTutorial( "SCORE_TUTORIAL_PLAYER_DEATH", "iMsgTutorialPlayerDeath" )
	SetupGenericTutorial( "SCORE_TUTORIAL_REVIVE", "iMsgTutorialRevive" )
	SetupGenericTutorial( "SCORE_TUTORIAL_CHECKPOINT", "iMsgTutorialCheckpoint" )
end

function SetupGeneric()

	--Constants
        local numKoupons = 151
        local numBeercaps = 154
        local numDolls = 124
        local numProducts = 110
	local numCollectibles = numKoupons + numBeercaps + numDolls + numProducts
	local numCliches = 31
	local episodeCompleteAmount = 835450
	local challengeCompleteAmount = 167090
	local clicheCompleteAmount = 43120
	local collectibleCompleteAmount = 17360

	--Completion scores
	score = sk:CreateScore("SCORE_TOTAL_EPISODES_COMPLETE", 0)
	score:SetStorage("session")
	score:AddComparisonWatcher(EQUAL, 16, "SCORE_ALL_EPISODES_COMPLETE")
	score:AddDifferenceWatcher("SCORE_GAME_PERCENT_COMPLETE", episodeCompleteAmount)
	score = sk:CreateScore("SCORE_ALL_EPISODES_COMPLETE", 0)
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TASKS_COMPLETED")

	score = sk:CreateScore("SCORE_TOTAL_EPISODE_TARGET_TIMES_BEATEN", 0)
	score:SetStorage("session")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 16, ACHIEVEMENT_FAST_TIMES)

	score = sk:CreateScore("SCORE_TOTAL_CHALLENGES_COMPLETE", 0)
	score:SetStorage("session")
	score:SetConstraint("increasing")
	score:AddComparisonWatcher(EQUAL, 16, "SCORE_ALL_CHALLENGES_COMPLETE")
	score:AddDifferenceWatcher("SCORE_GAME_PERCENT_COMPLETE", challengeCompleteAmount)
	score = sk:CreateScore("SCORE_ALL_CHALLENGES_COMPLETE", 0)
	score:SetStorage("session")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 1, ACHIEVEMENT_CHALLENGER)

	score = sk:CreateScore("SCORE_TOTAL_PLAYER_DEATHS", 0)
	score:SetStorage("session")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 10, ACHIEVEMENT_PWND)
	
	--Collectible hooks
	score = sk:CreateScore("SCORE_TOTAL_KOUPON_COLLECTED", 0)
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TOTAL_COLLECTIBLES_COLLECTED")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, numKoupons, ACHIEVEMENT_POSTER_PASTER)
	score = sk:CreateScore("SCORE_MAX_KOUPON", numKoupons)
	score:SetConstraint("constant")

	score = sk:CreateScore("SCORE_TOTAL_BEERCAP_COLLECTED", 0)	
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TOTAL_COLLECTIBLES_COLLECTED")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, numBeercaps, ACHIEVEMENT_DUFFTACULAR_FINISH)
	score = sk:CreateScore("SCORE_MAX_BEERCAP", numBeercaps)
	score:SetConstraint("constant")

	score = sk:CreateScore("SCORE_TOTAL_DOLL_COLLECTED", 0)
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TOTAL_COLLECTIBLES_COLLECTED")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, numDolls, ACHIEVEMENT_DOLL_CRAZY)
	score = sk:CreateScore("SCORE_MAX_DOLL", numDolls)
	score:SetConstraint("constant")

	score = sk:CreateScore("SCORE_TOTAL_PRODUCT_COLLECTED", 0)
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TOTAL_COLLECTIBLES_COLLECTED")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, numProducts, ACHIEVEMENT_HAIRS_TO_YOU)
	score = sk:CreateScore("SCORE_MAX_PRODUCT", numProducts)
	score:SetConstraint("constant")

	score = sk:CreateScore("SCORE_TOTAL_COLLECTIBLES_COLLECTED", 0)
	score:SetStorage("session")
	score:AddComparisonWatcher(EQUAL, 0, "SCORE_ALL_COLLECTIBLES_COLLECTED", "SCORE_MAX_COLLECTIBLES")
	score:AddDifferenceWatcher("SCORE_GAME_PERCENT_COMPLETE", collectibleCompleteAmount)

	score = sk:CreateScore("SCORE_MAX_COLLECTIBLES", numCollectibles)
	score:SetStorage("session")
	score:SetConstraint("constant")
	
	score = sk:CreateScore("SCORE_ALL_COLLECTIBLES_COLLECTED", 0)
	score:AddComparisonWatcher(EQUAL, 1, "SCORE_POWER_INFINITE")
	score:AddDifferenceWatcher("SCORE_TASKS_COMPLETED")

	--Powerup score
	score = sk:CreateScore("SCORE_TOTAL_ROBOBART_COLLECTED", 0)
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TOTAL_POWERUPS_COLLECTED")
	score:SetBounds(0, 2)

	score = sk:CreateScore("SCORE_TOTAL_CLOBBERGIRL_COLLECTED", 0)
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TOTAL_POWERUPS_COLLECTED")
	score:SetBounds(0, 2)

	score = sk:CreateScore("SCORE_TOTAL_HOTHOMER_COLLECTED", 0)
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TOTAL_POWERUPS_COLLECTED")
	score:SetBounds(0, 2)

	score = sk:CreateScore("SCORE_TOTAL_MARGECOP_COLLECTED", 0)
	score:SetStorage("session")
	score:AddDifferenceWatcher("SCORE_TOTAL_POWERUPS_COLLECTED")
	score:SetBounds(0, 2)

	score = sk:CreateScore("SCORE_TOTAL_POWERUPS_COLLECTED", 0)
	score:SetStorage("session")

	--Setup cliches
	for i = 1, numCliches do
		score = sk:CreateScore("SCORE_CLICHE_"..i, 0, SCORE_CONTEXT_GLOBAL, 0)
		score:SetStorage("session")
		score:AddDifferenceWatcher("SCORE_CLICHE_COLLECTED")
	end

	score = sk:CreateScore("SCORE_CLICHE_TOTAL", numCliches)
	score:SetStorage("session")
	score:SetConstraint("constant")

	score = sk:CreateScore("SCORE_LAST_CLICHE_COLLECTED", 1)
	score:SetStorage("session")
	score:SetBounds(1, numCliches)

	score = sk:CreateScore("SCORE_CLICHE_COLLECTED", 0)
	score:SetStorage("session")
	score:SetBounds(0, numCliches)
	score:AddDifferenceWatcher("SCORE_GAME_PERCENT_COMPLETE", clicheCompleteAmount)

	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_WORST_CLICHE")
	event:AddNumericOp("set", "SCORE_CLICHE_31", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 31)

	score = sk:FindScore("SCORE_CLICHE_31")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 31)
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 1, ACHIEVEMENT_WORST_CLICHE_EVER)
	score:AddDifferenceWatcher("SCORE_TASKS_COMPLETED")

	--Game completion scores (tasks = episodes, collectibles, cliches)
	score = sk:CreateScore("SCORE_TASKS_COMPLETED", 0)
	score:SetStorage("session")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 3, ACHIEVEMENT_COMPLETE_PACKAGE)
	
	score = sk:CreateScore("SCORE_GAME_PERCENT_COMPLETE", 0)
	score:SetStorage("session")
	score = sk:CreateScore("SCORE_GAME_PERCENT_COMPLETE_SCALE", 26734400) --16*episodeComplete + 16*challengeComplete + 31*clicheComplete + 539*collectibleComplete
	score:SetConstraint("constant")

	score = sk:CreateScore("SCORE_GAME_START_TIME", 0)
	score:SetStorage("session")
	score = sk:CreateScore("SCORE_GAME_END_TIME", 0)
	score:SetStorage("session")
	score = sk:CreateScore("SCORE_TOTAL_GAME_TIME", 0)
	score:SetStorage("session")

	event = sk:CreateScoreEvent("SCORE_EVENT_RESTART_GAME_TIME")
	event:AddTimeOp("SCORE_GAME_START_TIME")

	event = sk:CreateScoreEvent("SCORE_EVENT_UPDATE_GAME_TIME")
	event:AddTimeOp("SCORE_GAME_END_TIME")
	event:AddNumericOp("add", "SCORE_TOTAL_GAME_TIME", 0, "SCORE_GAME_END_TIME")
	event:AddNumericOp("subtract", "SCORE_TOTAL_GAME_TIME", 0, "SCORE_GAME_START_TIME")
	event:AddTimeOp("SCORE_GAME_START_TIME")

	score = sk:CreateScore("SCORE_NUM_COMBOS_TO_DISPLAY", 0 )
	score:AddMessageWatcher("iMsgComboPerformed", 0, 0)
	score:SetStorage("session")

end

function SetupSprHub()

    BuildCollectibleBlock(75, "SPR_HUB", "BEERCAP")
    BuildCollectibleBlock(75, "SPR_HUB", "DOLL")
    BuildCollectibleBlock(75, "SPR_HUB", "KOUPON")
    BuildCollectibleBlock(75, "SPR_HUB", "PRODUCT")

	score = sk:FindScore("SCORE_SPR_HUB_BEERCAP_TROPHY_AWARDED")
	score:AddDifferenceWatcher("SCORE_SPR_HUB_TROPHIES_AWARDED")
	score = sk:FindScore("SCORE_SPR_HUB_KOUPON_TROPHY_AWARDED")
	score:AddDifferenceWatcher("SCORE_SPR_HUB_TROPHIES_AWARDED")
	score = sk:FindScore("SCORE_SPR_HUB_PRODUCT_TROPHY_AWARDED")
	score:AddDifferenceWatcher("SCORE_SPR_HUB_TROPHIES_AWARDED")
	score = sk:FindScore("SCORE_SPR_HUB_DOLL_TROPHY_AWARDED")
	score:AddDifferenceWatcher("SCORE_SPR_HUB_TROPHIES_AWARDED")

	--Achievement
	score = sk:CreateScore("SCORE_SPR_HUB_TROPHIES_AWARDED", 0)
	score:SetStorage("session")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 4, ACHIEVEMENT_GOES_TO_11)
	
	--HomerBall tutorial
	score = sk:CreateScore("SCORE_SPR_HUB_HB_TUTORIAL_COMPLETE", 0)
	score:SetStorage("session")
	event = sk:CreateScoreEvent("SCORE_EVENT_SPR_HUB_HB_TUTORIAL_COMPLETED")
	event:AddNumericOp("set", "SCORE_SPR_HUB_HB_TUTORIAL_COMPLETE", 1)

	--Bus Stop Selection locks
	score = sk:CreateScore("SCORE_BART_BUS_STOP_SELECTABLE", 1)
	score = sk:CreateScore("SCORE_HOMER_BUS_STOP_SELECTABLE", 1)
	score = sk:CreateScore("SCORE_MARGE_BUS_STOP_SELECTABLE", 1)
	score = sk:CreateScore("SCORE_LISA_BUS_STOP_SELECTABLE", 1)
	
	event = sk:FindEvent("SCORE_EVENT_LAND_OF_CHOCOLATE_COMPLETE")
	event:AddNumericOp("set", "SCORE_MARGE_BUS_STOP_SELECTABLE", 0)
	event:AddNumericOp("set", "SCORE_LISA_BUS_STOP_SELECTABLE", 0)

	event = sk:FindEvent("SCORE_EVENT_EIGHTY_BITES_COMPLETE")
	event:AddNumericOp("set", "SCORE_LISA_BUS_STOP_SELECTABLE", 1)

	event = sk:FindEvent("SCORE_EVENT_TREEHUGGER_COMPLETE")
	event:AddNumericOp("set", "SCORE_MARGE_BUS_STOP_SELECTABLE", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_28")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 28)
	score:AddDifferenceWatcher("SCORE_SPR_HUB_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_AI_WALLS")
	event:AddNumericOp("set", "SCORE_CLICHE_28", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 28)

	score = sk:FindScore("SCORE_CLICHE_29")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 29)
	score:AddDifferenceWatcher("SCORE_SPR_HUB_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_STEEP_SLOPE_BARRIER")
	event:AddNumericOp("set", "SCORE_CLICHE_29", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 29)

	score = sk:FindScore("SCORE_CLICHE_30")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 30)
	score:AddDifferenceWatcher("SCORE_SPR_HUB_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_THE_DOORS")
	event:AddNumericOp("set", "SCORE_CLICHE_30", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 30)

end

function SetupWhiteBoxes()

	BuildCollectibleBlock(3, nil, "KOUPON")
	BuildCollectibleBlock(1, nil, "BEERCAP")
	BuildCollectibleBlock(1, nil, "PRODUCT")
	BuildCollectibleBlock(1, nil, "DOLL")

end

function SetupLandOfChocolate()

	--Collectibles
    BuildCollectibleBlock(5, "LAND_OF_CHOCOLATE", "BEERCAP")

	--Challenge mode
	score = sk:CreateScore("SCORE_LAND_OF_CHOCOLATE_CHALLENGE_BUNNIES_KILLED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_LAND_OF_CHOCOLATE_CHALLENGE_BUNNIES_MAX", 100)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_LAND_OF_CHOCOLATE_BUNNY_KILLED")
	event:AddNumericOp("add", "SCORE_LAND_OF_CHOCOLATE_CHALLENGE_BUNNIES_KILLED", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_1")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 1)
	score:AddDifferenceWatcher("SCORE_LAND_OF_CHOCOLATE_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_DOUBLE_JUMP")
	event:AddNumericOp("set", "SCORE_CLICHE_1", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 1)
	
end

function SetupBartmanBegins()

	--Collectibles
    BuildCollectibleBlock(6, "BARTMAN_BEGINS", "BEERCAP")
    BuildCollectibleBlock(6, "BARTMAN_BEGINS", "KOUPON")

	--Challenge mode scores
	sk:CreateScore("SCORE_BARTMAN_BEGINS_CHALLENGE_TOTAL", 7)
	sk:CreateScore("SCORE_BARTMAN_BEGINS_CHALLENGE_COLLECTED", 0)
	
	--Cliches
	score = sk:FindScore("SCORE_CLICHE_2")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 2)
	score:AddDifferenceWatcher("SCORE_BARTMAN_BEGINS_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_CRATE")
	event:AddNumericOp("set", "SCORE_CLICHE_2", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 2)

	score = sk:FindScore("SCORE_CLICHE_3")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 3)
	score:AddDifferenceWatcher("SCORE_BARTMAN_BEGINS_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_PRESSURE_PADS")
	event:AddNumericOp("set", "SCORE_CLICHE_3", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 3)
end

function SetupEightyBites()

	--Collectibles
    BuildCollectibleBlock(6, "EIGHTY_BITES", "BEERCAP")
    BuildCollectibleBlock(6, "EIGHTY_BITES", "KOUPON")
	
	--Time scores
	score = sk:CreateScore("SCORE_EIGHTY_BITES_BONUS_TIME", 120)
	event = sk:CreateScoreEvent("SCORE_EVENT_ENTERED_AUSTRALIA")
	event:AddNumericOp("set", "SCORE_EIGHTY_BITES_BONUS_TIME", 120)
	event = sk:CreateScoreEvent("SCORE_EVENT_ENTERED_MEXICO")
	event:AddNumericOp("set", "SCORE_EIGHTY_BITES_BONUS_TIME", 120)
	event = sk:CreateScoreEvent("SCORE_EVENT_ENTERED_GERMANY")
	event:AddNumericOp("set", "SCORE_EIGHTY_BITES_BONUS_TIME", 120)
	event = sk:CreateScoreEvent("SCORE_EVENT_ENTERED_PARIS")
	event:AddNumericOp("set", "SCORE_EIGHTY_BITES_BONUS_TIME", 120)
	event = sk:CreateScoreEvent("SCORE_EVENT_ENTERED_SCOTLAND")
	event:AddNumericOp("set", "SCORE_EIGHTY_BITES_BONUS_TIME", 120)
	event = sk:CreateScoreEvent("SCORE_EVENT_ENTERED_ITALY")
	event:AddNumericOp("set", "SCORE_EIGHTY_BITES_BONUS_TIME", 120)
	event = sk:CreateScoreEvent("SCORE_EVENT_ENTERED_AMERICA")
	event:AddNumericOp("set", "SCORE_EIGHTY_BITES_BONUS_TIME", 120)

	--Challenge mode
	score = sk:CreateScore("SCORE_EIGHTY_BITES_CHALLENGE_TABLES_SMASHED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_EIGHTY_BITES_CHALLENGE_TABLES_MAX", 30)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_EIGHTY_BITES_TABLE_SMASHED")
	event:AddNumericOp("add", "SCORE_EIGHTY_BITES_CHALLENGE_TABLES_SMASHED", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_4")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 4)
	score:AddDifferenceWatcher("SCORE_EIGHTY_BITES_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_POWER_UP")
	event:AddNumericOp("set", "SCORE_CLICHE_4", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 4)

	score = sk:FindScore("SCORE_CLICHE_5")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 5)
	score:AddDifferenceWatcher("SCORE_EIGHTY_BITES_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_COMBO_PUNCH")
	event:AddNumericOp("set", "SCORE_CLICHE_5", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 5)
	
end

function SetupTreeHugger()

	--Collectibles
    BuildCollectibleBlock(6, "TREEHUGGER", "KOUPON")
    BuildCollectibleBlock(5, "TREEHUGGER", "DOLL")

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_6")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 6)
	score:AddDifferenceWatcher("SCORE_TREEHUGGER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_GIANT_SAW_BLADES")
	event:AddNumericOp("set", "SCORE_CLICHE_6", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 6)

	score = sk:FindScore("SCORE_CLICHE_7")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 7)
	score:AddDifferenceWatcher("SCORE_TREEHUGGER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_EXPLOSIVE_BARREL")
	event:AddNumericOp("set", "SCORE_CLICHE_7", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 7)

end

function SetupMobRules()

	--Collectibles
    BuildCollectibleBlock(7, "MOB_RULES", "DOLL")
    BuildCollectibleBlock(6, "MOB_RULES", "PRODUCT")

	--Challenge mode
	score = sk:CreateScore("SCORE_MOB_RULES_CHALLENGE_RIOT_COPS_KILLED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_MOB_RULES_CHALLENGE_RIOT_COP_MAX", 15)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_MOB_RULES_RIOT_COP_KILLED")
	event:AddNumericOp("add", "SCORE_MOB_RULES_CHALLENGE_RIOT_COPS_KILLED", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_8")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 8)
	score:AddDifferenceWatcher("SCORE_MOB_RULES_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_INVISIBLE_BARRIER")
	event:AddNumericOp("set", "SCORE_CLICHE_8", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 8)

	score = sk:FindScore("SCORE_CLICHE_9")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 9)
	score:AddDifferenceWatcher("SCORE_MOB_RULES_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_CRACKED_UP")
	event:AddNumericOp("set", "SCORE_CLICHE_9", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 9)

end

function SetupCheater()

	--Collectibles
    BuildCollectibleBlock(8, "CHEATER", "KOUPON")
    BuildCollectibleBlock(8, "CHEATER", "DOLL")

	--Challenge Mode
	score = sk:CreateScore("SCORE_CHEATER_CHALLENGE_SLAVES_FREED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_CHEATER_CHALLENGE_SLAVES_MAX", 6)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_CHEATER_CHALLENGE_SLAVE_FREED")
	event:AddNumericOp("add", "SCORE_CHEATER_CHALLENGE_SLAVES_FREED", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_10")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 10)
	score:AddDifferenceWatcher("SCORE_CHEATER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_PORTAL")
	event:AddNumericOp("set", "SCORE_CLICHE_10", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 10)

	score = sk:FindScore("SCORE_CLICHE_11")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 11)
	score:AddDifferenceWatcher("SCORE_CHEATER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_SWITCHES_AND_LEVERS")
	event:AddNumericOp("set", "SCORE_CLICHE_11", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 11)

end

function SetupDolphins()

	--Collectibles
    BuildCollectibleBlock(7, "DOLPHINS", "KOUPON")
    BuildCollectibleBlock(4, "DOLPHINS", "DOLL")

	--Challenge mode
	score = sk:CreateScore("SCORE_DOLPHINS_CHALLENGE_CANS_COLLECTED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_DOLPHINS_CHALLENGE_CANS_MAX", 11)
	score:SetStorage("local")
	score:SetConstraint("constant")

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_14")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 14)
	score:AddDifferenceWatcher("SCORE_DOLPHINS_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_WATER_WARP")
	event:AddNumericOp("set", "SCORE_CLICHE_14", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 14)

end

function SetupColossalDonut()

	--Collectibles
    BuildCollectibleBlock(10, "COLOSSAL_DONUT", "KOUPON")
    BuildCollectibleBlock(9, "COLOSSAL_DONUT", "BEERCAP")

	-- Homer helium tutorial scores
	score = sk:CreateScore("SCORE_HH_TUTORIAL_LIFT", 0)
	score:SetStorage("session")
	score = sk:CreateScore("SCORE_HH_TUTORIAL_DASH", 0)
	score:SetStorage("session")
	
	event = sk:CreateScoreEvent("SCORE_EVENT_HH_TUTORIAL_LIFT")
	event:AddNumericOp("set", "SCORE_HH_TUTORIAL_LIFT", 1)
	event = sk:CreateScoreEvent("SCORE_EVENT_HH_TUTORIAL_DASH")
	event:AddNumericOp("set", "SCORE_HH_TUTORIAL_DASH", 1)

	--Challenge mode
	score = sk:CreateScore("SCORE_COLOSSAL_DONUT_CHALLENGE_KRUSTIES_KILLED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_COLOSSAL_DONUT_CHALLENGE_KRUSTIES_MAX", 20)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_COLOSSAL_DONUT_KRUSTY_KILLED")
	event:AddNumericOp("add", "SCORE_COLOSSAL_DONUT_CHALLENGE_KRUSTIES_KILLED", 1)
	
	--Cliches
	score = sk:FindScore("SCORE_CLICHE_13")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 13)
	score:AddDifferenceWatcher("SCORE_COLOSSAL_DONUT_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_OBVIOUS_WEAKNESS")
	event:AddNumericOp("set", "SCORE_CLICHE_13", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 13)

end

function SetupSpringfieldStoodStill()

	--Collectibles
    BuildCollectibleBlock(3, "SPRINGFIELD_STOOD_STILL", "KOUPON")
    BuildCollectibleBlock(4, "SPRINGFIELD_STOOD_STILL", "BEERCAP")

	--Space invaders
	score = sk:CreateScore("SCORE_SPRINGFIELD_STOOD_STILL_WAVES_DESTROYED", 1)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_SPRINGFIELD_STOOD_STILL_WAVES_MAX", 3)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_SPRINGFIELD_STOOD_STILL_STORY_WAVE_DESTROYED")
	event:AddNumericOp("add", "SCORE_SPRINGFIELD_STOOD_STILL_WAVES_DESTROYED", 1)

	--Challenge mode
	score = sk:CreateScore("SCORE_SPRINGFIELD_STOOD_STILL_CHALLENGE_WAVES_DESTROYED", 1)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_SPRINGFIELD_STOOD_STILL_CHALLENGE_WAVES_MAX", 5)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_SPRINGFIELD_STOOD_STILL_WAVE_DESTROYED")
	event:AddNumericOp("add", "SCORE_SPRINGFIELD_STOOD_STILL_CHALLENGE_WAVES_DESTROYED", 1)
	
	--Cliches
	score = sk:FindScore("SCORE_CLICHE_12")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 12)
	score:AddDifferenceWatcher("SCORE_SPRINGFIELD_STOOD_STILL_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_COLLECTIBLE_PLACEMENT")
	event:AddNumericOp("set", "SCORE_CLICHE_12", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 12)

end

function SetupBargainBin()

	--Collectibles
    BuildCollectibleBlock(4, "BARGAIN_BIN", "KOUPON")
    BuildCollectibleBlock(3, "BARGAIN_BIN", "BEERCAP")

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_15")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 15)
	score:AddDifferenceWatcher("SCORE_BARGAIN_BIN_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_CHASM_DEATH")
	event:AddNumericOp("set", "SCORE_CLICHE_15", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 15)

	score = sk:FindScore("SCORE_CLICHE_16")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 16)
	score:AddDifferenceWatcher("SCORE_BARGAIN_BIN_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_TIME_TRIAL")
	event:AddNumericOp("set", "SCORE_CLICHE_16", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 16)

end

function SetupGameHub()

	--Collectibles
	BuildCollectibleBlock(0, "GAME_HUB", "KOUPON")
    	BuildCollectibleBlock(0, "GAME_HUB", "BEERCAP")
	BuildCollectibleBlock(0, "GAME_HUB", "PRODUCT")
    	BuildCollectibleBlock(0, "GAME_HUB", "DOLL")

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_17")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 17)
	score:AddDifferenceWatcher("SCORE_GAME_HUB_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_TUTORIAL_HELL")
	event:AddNumericOp("set", "SCORE_CLICHE_17", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 17)

	score = sk:FindScore("SCORE_CLICHE_25")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 25)
	score:AddDifferenceWatcher("SCORE_GAME_HUB_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_KEY_CARD")
	event:AddNumericOp("set", "SCORE_CLICHE_25", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 25)

	--Tutorials
	score = sk:CreateScore("SCORE_GAME_HUB_POWER_UPGRADE_TUTORIAL_COMPLETE", 0)
	score:SetStorage("session")

	event = sk:CreateScoreEvent("SCORE_EVENT_GAME_HUB_TUTORIAL_COMPLETE")
	event:AddNumericOp("set", "SCORE_GAME_HUB_POWER_UPGRADE_TUTORIAL_COMPLETE", 1)

	--Powerups (used to unlock the gates)
	score = sk:CreateScore("SCORE_GAME_HUB_HOMER_POWERUP_COLLECTED", 0)
	score:SetStorage("session")
	score = sk:CreateScore("SCORE_GAME_HUB_BART_POWERUP_COLLECTED", 0)
	score:SetStorage("session")
	score = sk:CreateScore("SCORE_GAME_HUB_MARGE_POWERUP_COLLECTED", 0)
	score:SetStorage("session")
	score = sk:CreateScore("SCORE_GAME_HUB_LISA_POWERUP_COLLECTED", 0)
	score:SetStorage("session")

end

function SetupNeverquest()

	--Collectibles
    BuildCollectibleBlock(12, "NEVERQUEST", "PRODUCT")
    BuildCollectibleBlock(12, "NEVERQUEST", "BEERCAP")

	--Challenge mode
	score = sk:CreateScore("SCORE_NEVERQUEST_CHALLENGE_SPAWNERS_REMAINING", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_NEVERQUEST_CHALLENGE_SPAWNERS_MAX", 500)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_NEVERQUEST_CHALLENGE_SPAWNER_DESTROYED")
	event:AddNumericOp("add", "SCORE_NEVERQUEST_CHALLENGE_SPAWNERS_REMAINING", 1)
	
	--Cliches
	score = sk:FindScore("SCORE_CLICHE_20")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 20)
	score:AddDifferenceWatcher("SCORE_NEVERQUEST_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_ENEMY_SPAWNERS")
	event:AddNumericOp("set", "SCORE_CLICHE_20", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 20)

end

function SetupGrandTheftScratchy()

	--Collectibles
    BuildCollectibleBlock(12, "GRAND_THEFT_SCRATCHY", "PRODUCT")
    BuildCollectibleBlock(12, "GRAND_THEFT_SCRATCHY", "DOLL")

	--Converted Houses
	score = sk:CreateScore("SCORE_GRAND_THEFT_SCRATCHY_HOUSES_TOTAL", 16)
	score:SetStorage("local")
	score:SetConstraint("constant")
	score = sk:CreateScore("SCORE_GRAND_THEFT_SCRATCHY_HOUSES_CONVERTED", 0)
	score:SetStorage("local")
	event = sk:CreateScoreEvent("SCORE_EVENT_GRAND_THEFT_SCRATCHY_HOUSE_CONVERTED")
	event:AddNumericOp("add", "SCORE_GRAND_THEFT_SCRATCHY_HOUSES_CONVERTED", 1)

	--Missile Command
	score = sk:CreateScore("SCORE_GRAND_THEFT_SCRATCHY_WAVES_COMPLETED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_GRAND_THEFT_SCRATCHY_WAVES_MAX", 3)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_GRAND_THEFT_SCRATCHY_WAVE_COMPLETE")
	event:AddNumericOp("add", "SCORE_GRAND_THEFT_SCRATCHY_WAVES_COMPLETED", 1)

	--Challenge mode
	score = sk:CreateScore("SCORE_GRAND_THEFT_SCRATCHY_CHALLENGE_WAVES_COMPLETED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_GRAND_THEFT_SCRATCHY_CHALLENGE_WAVES_MAX", 5)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_GRAND_THEFT_SCRATCHY_CHALLENGE_WAVE_COMPLETE")
	event:AddNumericOp("add", "SCORE_GRAND_THEFT_SCRATCHY_CHALLENGE_WAVES_COMPLETED", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_21")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 21)
	score:AddDifferenceWatcher("SCORE_GRAND_THEFT_SCRATCHY_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_INFINITE_LEDGE")
	event:AddNumericOp("set", "SCORE_CLICHE_21", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 21)

end

function SetupMedalOfHomer()

	--Collectibles
    BuildCollectibleBlock(14, "MEDAL_OF_HOMER", "KOUPON")
    BuildCollectibleBlock(14, "MEDAL_OF_HOMER", "BEERCAP")

	score = sk:CreateScore("SCORE_MOH_FLAGS", 0)
	score:SetStorage("local")

	score = sk:CreateScore("SCORE_MOH_FLAGS_TOTAL", 24)
	score:SetStorage("local")

	--Challenge mode
	score = sk:CreateScore("SCORE_MEDAL_OF_HOMER_CHALLENGE_FLAGS_COLLECTED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_MEDAL_OF_HOMER_CHALLENGE_FLAGS_MAX", 24)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_MEDAL_OF_HOMER_FLAG_COLLECTED")
	event:AddNumericOp("add", "SCORE_MEDAL_OF_HOMER_CHALLENGE_FLAGS_COLLECTED", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_18")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 18)
	score:AddDifferenceWatcher("SCORE_MEDAL_OF_HOMER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_TRAMPOLINES")
	event:AddNumericOp("set", "SCORE_CLICHE_18", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 18)

	score = sk:FindScore("SCORE_CLICHE_19")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 19)
	score:AddDifferenceWatcher("SCORE_MEDAL_OF_HOMER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_ESCORT_MISSION")
	event:AddNumericOp("set", "SCORE_CLICHE_19", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 19)

end

function SetupBigSuperHappy()

	--Collectibles
    BuildCollectibleBlock(8, "BIG_SUPER", "DOLL")
    BuildCollectibleBlock(8, "BIG_SUPER", "BEERCAP")

	--Airship Engine scoring
	score = sk:CreateScore("SCORE_AIRSHIP_ENGINES_MAX", 5)
	score = sk:CreateScore("SCORE_AIRSHIP_TIME_SCALE", 0)
	score = sk:CreateScore("SCORE_AIRSHIP_ENGINES_ACTIVE", 0)

	local value = 1
	for i = 1, 5 do
		event = sk:CreateScoreEvent("SCORE_EVENT_AIRSHIP_ENGINE_"..i.."_OFF")
		event:AddNumericOp("subtract", "SCORE_AIRSHIP_ENGINES_ACTIVE", value)
		event:AddNumericOp("subtract", "SCORE_AIRSHIP_TIME_SCALE", 0.2)
		event = sk:CreateScoreEvent("SCORE_EVENT_AIRSHIP_ENGINE_"..i.."_ON")
		event:AddNumericOp("add", "SCORE_AIRSHIP_ENGINES_ACTIVE", value)
		event:AddNumericOp("add", "SCORE_AIRSHIP_TIME_SCALE", 0.2)
		value = value * 2
	end

	event = sk:CreateScoreEvent("SCORE_EVENT_AIRSHIP_ENGINES_CLEAR")
	event:AddNumericOp("set", "SCORE_AIRSHIP_ENGINES_ACTIVE", 0)
	event:AddNumericOp("set", "SCORE_AIRSHIP_TIME_SCALE", 0)

	--Challenge mode
	score = sk:CreateScore("SCORE_BIG_SUPER_CHALLENGE_MAKI_COLLECTED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_BIG_SUPER_CHALLENGE_MAKI_MAX", 18)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_BIG_SUPER_MAKI_COLLECTED")
	event:AddNumericOp("add", "SCORE_BIG_SUPER_CHALLENGE_MAKI_COLLECTED", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_22")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 22)
	score:AddDifferenceWatcher("SCORE_BIG_SUPER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_LAVA")
	event:AddNumericOp("set", "SCORE_CLICHE_22", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 22)

	score = sk:FindScore("SCORE_CLICHE_23")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 23)
	score:AddDifferenceWatcher("SCORE_BIG_SUPER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_FLYING_BOAT")
	event:AddNumericOp("set", "SCORE_CLICHE_23", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 23)

	score = sk:FindScore("SCORE_CLICHE_24")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 24)
	score:AddDifferenceWatcher("SCORE_BIG_SUPER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_ELEMENTAL_ENEMIES")
	event:AddNumericOp("set", "SCORE_CLICHE_24", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 24)

end

function SetupRhymesWithComplaining()

	--Collectibles
    BuildCollectibleBlock(4, "RHYMES_WITH_COMPLAINING", "KOUPON")
    BuildCollectibleBlock(5, "RHYMES_WITH_COMPLAINING", "BEERCAP")

	--Challenge mode
	score = sk:CreateScore("SCORE_RHYMES_WITH_COMPLAINING_CHALLENGE_ENEMIES_KILLED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_RHYMES_WITH_COMPLAINING_CHALLENGE_ENEMIES_MAX", 30)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_RHYMES_WITH_COMPLAINING_ENEMY_KILLED")
	event:AddNumericOp("add", "SCORE_RHYMES_WITH_COMPLAINING_CHALLENGE_ENEMIES_KILLED", 1)

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_26")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 26)
	score:AddDifferenceWatcher("SCORE_RHYMES_WITH_COMPLAINING_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_EVIL_GENIUS")
	event:AddNumericOp("set", "SCORE_CLICHE_26", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 26)

end

function SetupMeetThyPlayer()

	--Collectibles
    BuildCollectibleBlock(8, "MEET_THY_PLAYER", "KOUPON")
    BuildCollectibleBlock(5, "MEET_THY_PLAYER", "DOLL")
    BuildCollectibleBlock(7, "MEET_THY_PLAYER", "BEERCAP")
    BuildCollectibleBlock(5, "MEET_THY_PLAYER", "PRODUCT")

	--Family health for god battle
	score = sk:CreateScore("SCORE_MEET_THY_PLAYER_FAMILY_HEALTH", 5)
	score:SetStorage("local")
	score:SetBounds(0, 5)
	score = sk:CreateScore("SCORE_MEET_THY_PLAYER_FAMILY_HEALTH_MAX", 5)
	score:SetStorage("local")
	score:SetConstraint("constant")
	event = sk:CreateScoreEvent("SCORE_EVENT_MEET_THY_PLAYER_DECREMENT_FAMILY_HEALTH")
	event:AddNumericOp("subtract", "SCORE_MEET_THY_PLAYER_FAMILY_HEALTH", 1)
	event = sk:CreateScoreEvent("SCORE_EVENT_MEET_THY_PLAYER_RESET_FAMILY_HEALTH")
	event:AddNumericOp("set", "SCORE_MEET_THY_PLAYER_FAMILY_HEALTH", 0, "SCORE_MEET_THY_PLAYER_FAMILY_HEALTH_MAX")

	--Perfect God Battle
	score = sk:CreateScore("SCORE_MEET_THY_PLAYER_GOD_BATTLE_PERFECT", 0)
	--score:SetStorage("session")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 1, ACHIEVEMENT_HEAVENLY_SCORE)
	event = sk:CreateScoreEvent("SCORE_EVENT_GOD_BATTLE_PERFECT")
	event:AddNumericOp("set", "SCORE_MEET_THY_PLAYER_GOD_BATTLE_PERFECT", 1)

	--Challenge mode
	score = sk:CreateScore("SCORE_MEET_THY_PLAYER_CHALLENGE_CAKES_COLLECTED", 0)
	score:SetStorage("local")
	score = sk:CreateScore("SCORE_MEET_THY_PLAYER_CHALLENGE_CAKES_MAX", 12)
	score:SetStorage("local")
	score:SetConstraint("constant")

	--Cliches
	score = sk:FindScore("SCORE_CLICHE_27")
	score:AddUnlockWatcher(CLICHE_AWARD, 1, 27)
	score:AddDifferenceWatcher("SCORE_MEET_THY_PLAYER_CLICHE_COLLECTED")
	event = sk:CreateScoreEvent("SCORE_EVENT_CLICHE_REUSED_ENEMIES")
	event:AddNumericOp("set", "SCORE_CLICHE_27", 1)
	event:AddNumericOp("set", "SCORE_LAST_CLICHE_COLLECTED", 27)

end


-- DO NOT CHANGE BELOW HERE! (unless you know what you're doing and are willing to bear the consequences :-) )

-- Helper functions

function CreateNandGate(input, output)

	score = CreateNGate(input, output.."_NAND_GATE")
	score:AddComparisonWatcher(NOT_EQUAL, table.getn(input), output)

end

function CreateNorGate(input, output)
	
	score = CreateNGate(input, output.."_OR_GATE")
	score:AddComparisonWatcher(EQUAL, 0, output)

end

function CreateAndGate(input, output)

	score = CreateNGate(input, output.."_AND_GATE")
	score:AddComparisonWatcher(EQUAL, table.getn(input), output)

end

function CreateOrGate(input, output)
	
	score = CreateNGate(input, output.."_OR_GATE")
	score:AddComparisonWatcher(NOT_EQUAL, 0, output)

end

function CreateXorGate(input, output)

	score = CreateNGate(input, output.."_XOR_GATE")
	score:AddComparisonWatcher(EQUAL, 1, output)

end

function CreateNotGate(input, output)

	input:AddDifferenceWatcher(output, -1)

end

function CreateNGate(input, name)

	num = table.getn(input)

	-- Loop over all input scores, and attach watcher to the internal score
	for i = 1, num do
		input[i]:AddDifferenceWatcher(name)
	end

	local score = sk:CreateScore(name, 0, SCORE_CONTEXT_GLOBAL, 0)
	score:SetStorage( "session" )
	return score
end

function EpisodeHelper(episode, achievement, cliche, targetTime, challengeAchievement, challengeTargetTime, countTowardComplete)
	
	--Create completion score
	score = sk:CreateScore("SCORE_"..episode.."_COMPLETE", 0)
	score:SetStorage("session")
	score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 1, achievement)
	if countTowardComplete ~= 0 then
		score:AddDifferenceWatcher("SCORE_TOTAL_EPISODES_COMPLETE")
	end

	score = sk:CreateScore("SCORE_"..episode.."_COMPLETION_COUNT", 0)
	score:SetStorage("session")

	--Create locked score
	score = sk:CreateScore("SCORE_"..episode.."_LOCKED", 1)
	score:SetBounds(0,1)

	--Create time scores
	if targetTime >= 0 then
		score = sk:CreateScore("SCORE_"..episode.."_TARGET_TIME", targetTime)
		score:SetStorage("session")
		score:SetConstraint("constant")
		score = sk:CreateScore("SCORE_"..episode.."_BEST_COMPLETION_TIME", FLT_MAX)
		score:SetStorage("session")
		score:SetConstraint("decreasing")
		score:MarkAsStatistic()
		score:AddComparisonWatcher(GREATER_THAN_OR_EQUAL, 0, "SCORE_"..episode.."_TARGET_TIME_BEATEN", "SCORE_"..episode.."_TARGET_TIME")

		score = sk:CreateScore("SCORE_"..episode.."_RUNNING_TIME", 0)
		score:SetStorage("session")
		score = sk:CreateScore("SCORE_"..episode.."_COMPLETION_TIME", 0)
		score = sk:CreateScore("SCORE_"..episode.."_START_TIME", 0)
		score:SetStorage("session")
		score = sk:CreateScore("SCORE_"..episode.."_END_TIME", FLT_MAX)
		score:SetStorage("session")	
		score = sk:CreateScore("SCORE_"..episode.."_TARGET_TIME_BEATEN", 0)
		score:SetStorage("session")
		if countTowardComplete ~= 0 then
			score:AddDifferenceWatcher("SCORE_TOTAL_EPISODE_TARGET_TIMES_BEATEN")
		end	
	end

	--Create challenge mode scores
	if challengeTargetTime >= 0 then
		score = sk:CreateScore("SCORE_"..episode.."_CHALLENGE_LOCKED", 1)
		score:SetStorage("session")
		score:SetBounds(0,1)

		score = sk:CreateScore("SCORE_"..episode.."_CHALLENGE_COMPLETE", 0)
		score:SetStorage("session")
		score:AddUnlockWatcher(ACHIEVEMENT_AWARD, 1, challengeAchievement)
		score:SetBounds(0,1)
		if countTowardComplete ~=0 then
			score:AddDifferenceWatcher("SCORE_TOTAL_CHALLENGES_COMPLETE")
		end

		score = sk:CreateScore("SCORE_"..episode.."_CHALLENGE_SUCCESS", 0)
		score:SetBounds(0,1)

		score = sk:CreateScore("SCORE_"..episode.."_CHALLENGE_TARGET_TIME", challengeTargetTime)
		score:SetStorage("session")
		score:SetConstraint("constant")
		score = sk:CreateScore("SCORE_"..episode.."_CHALLENGE_BEST_COMPLETION_TIME", FLT_MAX)
		score:SetStorage("session")
		score:SetConstraint("decreasing")
		score:MarkAsStatistic()

		score = sk:CreateScore("SCORE_"..episode.."_CHALLENGE_COMPLETION_TIME", 0)
		score:SetStorage("local")	
		score = sk:CreateScore("SCORE_"..episode.."_CHALLENGE_START_TIME", 0)
		score:SetStorage("local")
		score = sk:CreateScore("SCORE_"..episode.."_CHALLENGE_END_TIME", FLT_MAX)
		score:SetStorage("local")
		score:SetConstraint("decreasing")		
	end

	--Create cliche scores
	score = sk:CreateScore("SCORE_"..episode.."_CLICHE_TOTAL", cliche)
	score:SetStorage("session")
	score = sk:CreateScore("SCORE_"..episode.."_CLICHE_COLLECTED", 0)
	score:SetStorage("session")

	--Create cheat score event
	sk:CreateScoreEvent("SCORE_EVENT_"..episode.."_CHEAT")

	--Create start score events
	event = sk:CreateScoreEvent("SCORE_EVENT_"..episode.."_START")
	event:AddNumericOp("set", "SCORE_"..episode.."_RUNNING_TIME", 0)
	event:AddEventOp("SCORE_EVENT_"..episode.."_RESTART")

	event = sk:CreateScoreEvent("SCORE_EVENT_"..episode.."_RESTART")
	event:AddTimeOp("SCORE_"..episode.."_START_TIME")
	event:AddTimeOp("SCORE_GAME_START_TIME")

	event = sk:CreateScoreEvent("SCORE_EVENT_"..episode.."_CHALLENGE_START")
	event:AddTimeOp("SCORE_"..episode.."_CHALLENGE_START_TIME")
	event:AddTimeOp("SCORE_GAME_START_TIME")

	event = sk:CreateScoreEvent("SCORE_EVENT_"..episode.."_UPDATE_PLAY_TIME")
	event:AddTimeOp("SCORE_"..episode.."_END_TIME")
	event:AddNumericOp("add", "SCORE_"..episode.."_RUNNING_TIME", 0, "SCORE_"..episode.."_END_TIME")
	event:AddNumericOp("subtract", "SCORE_"..episode.."_RUNNING_TIME", 0, "SCORE_"..episode.."_START_TIME")
	
	--Create completion score events
	event = sk:CreateScoreEvent("SCORE_EVENT_"..episode.."_COMPLETE")
	event:AddMessageOp("iMsgLevelSuccess")
	event:AddNumericOp("add", "SCORE_"..episode.."_COMPLETION_TIME", 0, "SCORE_"..episode.."_RUNNING_TIME")
	event:AddNumericOp("set", "SCORE_"..episode.."_BEST_COMPLETION_TIME", 0, "SCORE_"..episode.."_COMPLETION_TIME")
	event:AddNumericOp("set", "SCORE_"..episode.."_COMPLETE", 1)
	event:AddNumericOp("add", "SCORE_"..episode.."_COMPLETION_COUNT", 1)
	
	event = sk:CreateScoreEvent("SCORE_EVENT_"..episode.."_CHALLENGE_COMPLETE")
	event:AddTimeOp("SCORE_"..episode.."_CHALLENGE_END_TIME")
	event:AddNumericOp("set", "SCORE_"..episode.."_CHALLENGE_COMPLETION_TIME", 0, "SCORE_"..episode.."_CHALLENGE_END_TIME")
	event:AddNumericOp("subtract", "SCORE_"..episode.."_CHALLENGE_COMPLETION_TIME", 0, "SCORE_"..episode.."_CHALLENGE_START_TIME")
	event:AddNumericOp("set", "SCORE_"..episode.."_CHALLENGE_BEST_COMPLETION_TIME", 0, "SCORE_"..episode.."_CHALLENGE_COMPLETION_TIME")
	event:AddNumericOp("set", "SCORE_"..episode.."_CHALLENGE_COMPLETE", 1)
	event:AddNumericOp("set", "SCORE_"..episode.."_CHALLENGE_SUCCESS", 1)
end

function CreateCheatEvent(previous, current)

	event = sk:FindEvent("SCORE_EVENT_"..current.."_CHEAT")
	event:AddEventOp("SCORE_EVENT_"..previous.."_CHEAT")
	event:AddNumericOp("set", "SCORE_"..previous.."_LOCKED", 0)
	event:AddNumericOp("set", "SCORE_"..previous.."_COMPLETE", 1)
	event:AddNumericOp("set", "SCORE_"..current.."_LOCKED", 0)

	if previous ~= "GAME_HUB" then
		event:AddNumericOp("set", "SCORE_"..previous.."_BEST_COMPLETION_TIME", 362340)
	end

end

function BuildCollectibleBlock(number, episode, type)
	
	local prefix
	if episode == nil then
		prefix = "SCORE_"..type.."_"
	else
		prefix = "SCORE_"..episode.."_"..type.."_"
	end

	if number > 0 then
		--Establish the individual collectible scores
		for i = 1, number do
			score = sk:CreateScore(prefix..i, 0, SCORE_CONTEXT_GLOBAL, 0)
			score:SetStorage("session")
			score:SetBounds(0,1)
			score:AddDifferenceWatcher(prefix.."COLLECTED")
		end
	end
	
	--Create the collected counter
	score = sk:CreateScore(prefix.."COLLECTED", 0)
	score:SetStorage("session")
	score:SetBounds(0, number)
	score:AddDifferenceWatcher("SCORE_TOTAL_"..type.."_COLLECTED")
	score:AddComparisonWatcher(EQUAL, 0, prefix.."TROPHY_AWARDED", prefix.."TOTAL")

	--Create the total counter
	score = sk:CreateScore(prefix.."TOTAL", number)
	score:SetStorage("session")
	score:SetBounds(number, number)

	--Create trophy score
	score = sk:CreateScore(prefix.."TROPHY_AWARDED", 0)
	score:SetStorage("session")
	score:SetBounds(0, 1)
	score:AddMessageWatcher("iMsg"..type.."TrophyAwarded", 1, 2)
	score:AddDifferenceWatcher("SCORE_TROPHIES_NEEDED_BEFORE_POWER_UPGRADE", -1)
		
end


function BuildPowerScores( playerName, startVal )
	
	--Create the collected counter
	score = sk:CreateScore("SCORE_POWER_MAX_"..playerName, startVal )
	score:SetStorage("session")

end

-- Score installation (invoke all setup functions in order)

if sk.BeginScoreInstallation ~= nil then
	sk:BeginScoreInstallation()
end

--SetupTestScores()
SetupGeneric()
score = nil
event = nil
collectgarbage( 0 )

SetupTutorialScores()
score = nil
event = nil
collectgarbage( 0 )

SetupEpisodeScores()
score = nil
event = nil
collectgarbage( 0 )

SetupSprHub()
score = nil
event = nil
collectgarbage( 0 )

SetupPowerMax()
score = nil
event = nil
collectgarbage( 0 )

SetupWhiteBoxes()
score = nil
event = nil
collectgarbage( 0 )

SetupLandOfChocolate()
score = nil
event = nil
collectgarbage( 0 )

SetupBartmanBegins()
score = nil
event = nil
collectgarbage( 0 )

SetupEightyBites()
score = nil
event = nil
collectgarbage( 0 )

SetupTreeHugger()
score = nil
event = nil
collectgarbage( 0 )

SetupMobRules()
score = nil
event = nil
collectgarbage( 0 )

SetupCheater()
score = nil
event = nil
collectgarbage( 0 )

SetupDolphins()
score = nil
event = nil
collectgarbage( 0 )

SetupColossalDonut()
score = nil
event = nil
collectgarbage( 0 )

SetupSpringfieldStoodStill()
score = nil
event = nil
collectgarbage( 0 )

SetupBargainBin()
score = nil
event = nil
collectgarbage( 0 )

SetupGameHub()
score = nil
event = nil
collectgarbage( 0 )

SetupNeverquest()
score = nil
event = nil
collectgarbage( 0 )

SetupGrandTheftScratchy()
score = nil
event = nil
collectgarbage( 0 )

SetupMedalOfHomer()
score = nil
event = nil
collectgarbage( 0 )

SetupBigSuperHappy()
score = nil
event = nil
collectgarbage( 0 )

SetupRhymesWithComplaining()
score = nil
event = nil
collectgarbage( 0 )

SetupMeetThyPlayer()
score = nil
event = nil
collectgarbage( 0 )

if sk.FinalizeScoreInstallation ~= nil then
	sk:FinalizeScoreInstallation()
end

sk = nil
collectgarbage( 0 )
