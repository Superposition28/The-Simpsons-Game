--///////////////////////////////////////////////////////////////////////////////
--/// \file simpsons_gameflow_helpers.h
--/// \brief Simpsons Gameflow
--///
--///	Builds the Gameflow Structure for the Simpsons
--///
--/// \par Copyright:
--///   (c) 2006 - Electronic Arts Inc.
--/// \author 
--///   Kaye Mason
--/// \date 
--///   12/12/06
--///////////////////////////////////////////////////////////////////////////////

--Syntax notes:
--Create a Game First.
--Create Episodes.
--Create Movies for episodes.
--Create Maps for episodes.
--Create Game modes for Episodes.
--Attach Maps to Modes.
--Attach Movies to Modes.

--NB: Requires simpsons_gamelfow_helpers.lua to be loaded first.

function SetupCostumes()
	if CostumeRegistry ~= nil then
		costumeRegistry = CostumeRegistry:GetCostumeRegistry()
		costumeRegistry:RegisterCostume( "costume_bart_default",	"Bart",		"FE_outfitSelect_Bart_Default",		"simpsons_chars/GlobalFolder/costumes/costume_bart_default" )
		costumeRegistry:RegisterCostume( "costume_bart_moh",		"Bart",		"FE_outfitSelect_Bart_MOH",			"simpsons_chars/GlobalFolder/costumes/costume_bart_moh", "SCORE_COSTUME_BART_MEDAL_OF_HOMER_LOCKED" )
		costumeRegistry:RegisterCostume( "costume_bart_moh_drk",	"Bart",		"",									"simpsons_chars/GlobalFolder/costumes/costume_bart_moh_drk" )
		costumeRegistry:RegisterCostume( "costume_homer_default",	"Homer",	"FE_outfitSelect_Homer_Default",	"simpsons_chars/GlobalFolder/costumes/costume_homer_default" )
		costumeRegistry:RegisterCostume( "costume_homer_bshff",		"Homer",	"FE_outfitSelect_Homer_BSHFF",		"simpsons_chars/GlobalFolder/costumes/costume_homer_bshff", "SCORE_COSTUME_HOMER_BIG_SUPER_LOCKED" )
		costumeRegistry:RegisterCostume( "costume_homer_moh",		"Homer",	"FE_outfitSelect_Homer_MOH",		"simpsons_chars/GlobalFolder/costumes/costume_homer_moh", "SCORE_COSTUME_HOMER_MEDAL_OF_HOMER_LOCKED" )
		costumeRegistry:RegisterCostume( "costume_homer_moh_drk",	"Homer",	"",									"simpsons_chars/GlobalFolder/costumes/costume_homer_moh_drk" )
		costumeRegistry:RegisterCostume( "costume_homer_nq",		"Homer",	"FE_outfitSelect_Homer_NQ",			"simpsons_chars/GlobalFolder/costumes/costume_homer_nq", "SCORE_COSTUME_HOMER_NEVERQUEST_LOCKED" )
		costumeRegistry:RegisterCostume( "costume_marge_default",	"Marge",	"FE_outfitSelect_Marge_Default",	"simpsons_chars/GlobalFolder/costumes/costume_marge_default" )
		costumeRegistry:RegisterCostume( "costume_marge_nq",		"Marge",	"FE_outfitSelect_Marge_NQ",			"simpsons_chars/GlobalFolder/costumes/costume_marge_nq", "SCORE_COSTUME_MARGE_NEVERQUEST_LOCKED" )
		costumeRegistry:RegisterCostume( "costume_lisa_default",	"Lisa",		"FE_outfitSelect_Lisa_Default",		"simpsons_chars/GlobalFolder/costumes/costume_lisa_default" )
		costumeRegistry:RegisterCostume( "costume_lisa_bshff",		"Lisa",		"FE_outfitSelect_Lisa_BSHFF",		"simpsons_chars/GlobalFolder/costumes/costume_lisa_bshff", "SCORE_COSTUME_LISA_BIG_SUPER_LOCKED" )
		costumeRegistry = nil
		end
	end

function SetupGame()
  
	local gameFlowManager = GameFlowManager:GetGameFlowManager()
	local episode
	local mode
	local map
  
    gameFlowManager:SetGameFlowVersion( 1 )
  
	local game = NewGame( "The Simpsons", "NEW_GAME" )

	--EPISODE: SPR_HUB
	episode = NewEpisode( game, "SPR_HUB", "FE_Episode_spr_hub", nil, "SCORE_SPR_HUB_LOCKED", "SCORE_EVENT_SPR_HUB_CHEAT", CONTEXT_EPISODE_SPRINGFIELD_HUB )        
	episode:SetRoot()
	episode:SetRestorePlayerPositions()
	episode:SetBusStopFail()
	episode:SetReplayDisabled()
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_OnePlayer", "SCORE_EVENT_RESTART_GAME_TIME", "SCORE_EVENT_RESTART_GAME_TIME" )
			mode:AddEntry( NewMap( "Springfield", "spr_hub", "spr_hub.str" ) )

	--EPISODE: LAND OF CHOCOLATE
	episode = NewEpisode( game, "LAND_OF_CHOCOLATE", "FE_Episode_loc", "SCORE_LAND_OF_CHOCOLATE_COMPLETE", "SCORE_LAND_OF_CHOCOLATE_LOCKED", "SCORE_EVENT_LAND_OF_CHOCOLATE_CHEAT", CONTEXT_EPISODE_CHOCOLATE )
	episode:SetDefault()
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_OnePlayer", "SCORE_EVENT_LAND_OF_CHOCOLATE_START", "SCORE_EVENT_LAND_OF_CHOCOLATE_RESTART", "SCORE_EVENT_LAND_OF_CHOCOLATE_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Homer's Dream", "loc_igc01", "INTRO", "FE_FMV_01",0.85 ) )
			map = NewMap( "loc map", "loc", "loc.str", nil, "SCORE_EVENT_LAND_OF_CHOCOLATE_COMPLETE" )
			map:SetNextEpisode( "SPR_HUB" )
			mode:AddEntry( map )
			mode:AddEntry( NewMovie( "Homer Explodes", "loc_igc02", "OUTRO", "FE_FMV_02",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Land of Chocolate", "COMPLETED_LAND_OF_CHOCOLATE", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			mode:AddEntry( NewMap( "loc map", "loc", "loc.str", "{AA1A126C-9681-472C-9508-54114AD46196}", "SCORE_EVENT_LAND_OF_CHOCOLATE_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed LoC Timed Challenge", "FAILED_MODE_TIMED_LAND_OF_CHOCOLATE", "loc_mode_timed_failed", "SCORE_LAND_OF_CHOCOLATE_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed LoC Timed Challenge", "COMPLETED_MODE_TIMED_LAND_OF_CHOCOLATE", "loc_mode_timed_complete", "SCORE_LAND_OF_CHOCOLATE_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: BARTMAN BEGINS
	episode = NewEpisode( game, "BARTMAN_BEGINS", "FE_Episode_bartman_begins", "SCORE_BARTMAN_BEGINS_COMPLETE", "SCORE_BARTMAN_BEGINS_LOCKED", "SCORE_EVENT_BARTMAN_BEGINS_CHEAT", CONTEXT_EPISODE_BARTMAN )    
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_BARTMAN_BEGINS_START", "SCORE_EVENT_BARTMAN_BEGINS_RESTART", "SCORE_EVENT_BARTMAN_BEGINS_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "gam_igc01", "gam_igc01", "INTRO", "FE_FMV_03",0.85 ) )
			mode:AddEntry( NewMap( "brt map", "brt", "brt.str", nil, "SCORE_EVENT_BARTMAN_BEGINS_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Principal Skinner confesses", "brt_igc02", "OUTRO", "FE_FMV_05",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Bartman Begins", "COMPLETED_BARTMAN_BEGINS", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer")
			mode:AddEntry( NewMap( "brt timed map", "brt", "brt.str", "{19E30557-45CE-48A2-977A-3DEC2E8D53D1}", "SCORE_EVENT_BARTMAN_BEGINS_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Bartman Begins Timed Challenge", "FAILED_MODE_TIMED_BARTMAN_BEGINS", "brt_mode_timed_failed", "SCORE_BARTMAN_BEGINS_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Bartman Begins Timed Challenge", "COMPLETED_MODE_TIMED_BARTMAN_BEGINS", "brt_mode_timed_complete", "SCORE_BARTMAN_BEGINS_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: AROUND THE WORLD IN EIGHTY BITES
	episode = NewEpisode( game, "EIGHTY_BITES", "FE_Episode_eighty_bites", "SCORE_EIGHTY_BITES_COMPLETE", "SCORE_EIGHTY_BITES_LOCKED", "SCORE_EVENT_EIGHTY_BITES_CHEAT", CONTEXT_EPISODE_80BITES )    
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_EIGHTY_BITES_START", "SCORE_EVENT_EIGHTY_BITES_RESTART", "SCORE_EVENT_EIGHTY_BITES_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "80 Bites Intro", "80b_igc01", "INTRO", "FE_FMV_06",0.9 ) )
			mode:AddEntry( NewMap( "eighty bites map", "eighty_bites", "eighty_bites.str", nil, "SCORE_EVENT_EIGHTY_BITES_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Homer wins", "80b_igc03", "OUTRO", "FE_FMV_07",0.75 ) )
			mode:AddEntry( NewMetricScreen( "Completed Eighty Bites", "COMPLETED_EIGHTY_BITES", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			mode:AddEntry( NewMap( "eighty bites timed map", "eighty_bites", "eighty_bites.str", "{57924986-870B-4AD6-B72F-416F771E9E18}", "SCORE_EVENT_EIGHTY_BITES_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed 80 Bites Timed Challenge", "FAILED_MODE_TIMED_EIGHTY_BITES", "eb_mode_timed_failed", "SCORE_EIGHTY_BITES_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed 80 Bites Timed Challenge", "COMPLETED_MODE_TIMED_EIGHTY_BITES", "eb_mode_timed_complete", "SCORE_EIGHTY_BITES_CHALLENGE_SUCCESS", 1 ) )
    
	--EPISODE: THE TREEHUGGER
	episode = NewEpisode( game, "TREEHUGGER", "FE_Episode_tree_hugger", "SCORE_TREEHUGGER_COMPLETE", "SCORE_TREEHUGGER_LOCKED", "SCORE_EVENT_TREEHUGGER_CHEAT", CONTEXT_EPISODE_TREEHUGGER )    
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_TREEHUGGER_START", "SCORE_EVENT_TREEHUGGER_RESTART", "SCORE_EVENT_TREEHUGGER_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Lisa decides to do something", "hug_igc01", "INTRO", "FE_FMV_08",0.75 ) )
			mode:AddEntry( NewMap( "tree hugger map", "tree_hugger", "tree_hugger.str", nil, "SCORE_EVENT_TREEHUGGER_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Factory is blown up", "hug_igc05", "OUTRO", "FE_FMV_09",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Treehugger", "COMPLETED_TREEHUGGER", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer")
			mode:AddEntry( NewMap( "treehugger timed map", "tree_hugger", "tree_hugger.str", "{A1504A47-8D9C-4C0E-8A0F-D7F49F8A47D6}", "SCORE_EVENT_TREEHUGGER_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Treehugger Timed Challenge", "FAILED_MODE_TIMED_TREEHUGGER", "treehugger_mode_timed_failed", "SCORE_TREEHUGGER_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Treehugger Timed Challenge", "COMPLETED_MODE_TIMED_TREEHUGGER", "treehugger_mode_timed_complete", "SCORE_TREEHUGGER_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: MOB RULES
	episode = NewEpisode( game, "MOB_RULES", "FE_Episode_mob_rules", "SCORE_MOB_RULES_COMPLETE", "SCORE_MOB_RULES_LOCKED", "SCORE_EVENT_MOB_RULES_CHEAT", CONTEXT_EPISODE_MOBRULES )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_MOB_RULES_START", "SCORE_EVENT_MOB_RULES_RESTART", "SCORE_EVENT_MOB_RULES_UPDATE_PLAY_TIME")	    
			mode:AddEntry( NewMovie( "Mayor Quimby declares GTS day", "mob_igc01", "INTRO", "FE_FMV_10",0.85 ) )
			mode:AddEntry( NewMap( "mob rules map", "mob_rules", "mob_rules.str", nil, "SCORE_EVENT_MOB_RULES_COMPLETE" ) )
			mode:AddEntry( NewMovie( "gam_igc02", "gam_igc02", "OUTRO", "FE_FMV_12",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Mob Rules", "COMPLETED_MOB_RULES", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed" )
			mode:AddEntry( NewMap( "mob rules timed map", "mob_rules", "mob_rules.str", "{E21367F7-6942-4D70-83DE-E34C501405F8}", "SCORE_EVENT_MOB_RULES_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Mob Rules Timed Challenge", "FAILED_MODE_TIMED_MOB_RULES", "mob_mode_timed_failed", "SCORE_MOB_RULES_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Mob Rules Timed Challenge", "COMPLETED_MODE_TIMED_MOB_RULES", "mob_mode_timed_complete", "SCORE_MOB_RULES_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: CHEATER CHEATER
	episode = NewEpisode( game, "CHEATER", "FE_Episode_cheater", "SCORE_CHEATER_COMPLETE", "SCORE_CHEATER_LOCKED", "SCORE_EVENT_CHEATER_CHEAT", CONTEXT_EPISODE_CHEATERCHEATER )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_CHEATER_START", "SCORE_EVENT_CHEATER_RESTART", "SCORE_EVENT_CHEATER_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Lisa and Bart find themselves in the Game Engine", "che_igc01", "INTRO", "FE_FMV_13",0.75 ) )
			mode:AddEntry( NewMap( "cheater map", "cheater", "cheater.str", nil, "SCORE_EVENT_CHEATER_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Frink helps Bart and Lisa exit back to Springfield", "che_igc02", "OUTRO", "FE_FMV_14",0.95 ) )
			mode:AddEntry( NewMetricScreen( "Completed Cheater Cheater", "COMPLETED_CHEATER", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			mode:AddEntry( NewMap( "cheater timed map", "cheater", "cheater.str", "{ECF6FA6E-55F7-478E-A850-BBA586899C33}", "SCORE_EVENT_CHEATER_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Cheater Timed Challenge", "FAILED_MODE_TIMED_CHEATER", "cheater_mode_timed_failed", "SCORE_CHEATER_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Cheater Timed Challenge", "COMPLETED_MODE_TIMED_CHEATER", "cheater_mode_timed_complete", "SCORE_CHEATER_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: DAY OF THE DOLPHINS
	episode = NewEpisode( game, "DOLPHINS", "FE_Episode_dayofthedolphins", "SCORE_DOLPHINS_COMPLETE", "SCORE_DOLPHINS_LOCKED", "SCORE_EVENT_DOLPHINS_CHEAT", CONTEXT_EPISODE_DOLPHIN )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_DOLPHINS_START", "SCORE_EVENT_DOLPHINS_RESTART", "SCORE_EVENT_DOLPHINS_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Free McAllister", "dod_igc01", "INTRO", "FE_FMV_17",0.75 ) )
			mode:AddEntry( NewMap( "dolphins map", "dayofthedolphins", "dayofthedolphins.str", nil, "SCORE_EVENT_DOLPHINS_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Snorky is defeated", "dod_igc03", "OUTRO", "FE_FMV_18",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Day of the Dolphins", "COMPLETED_DOLPHINS", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			mode:AddEntry( NewMap( "Day of the Dolphins timed map", "dayofthedolphins", "dayofthedolphins.str", "{8EE7A085-73B1-4FAA-AC04-9A5173550814}", "SCORE_EVENT_DOLPHINS_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Day of the Dolphins Timed Challenge", "FAILED_MODE_TIMED_DOLPHINS", "dotd_mode_timed_failed", "SCORE_DOLPHINS_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Day of the Dolphins Timed Challenge", "COMPLETED_MODE_TIMED_DOLPHINS", "dotd_mode_timed_complete", "SCORE_DOLPHINS_CHALLENGE_SUCCESS", 1 ) )
	    
	--EPISODE: SHADOW OF THE COLOSSAL DONUT
	episode = NewEpisode( game, "COLOSSAL_DONUT", "FE_Episode_colossaldonut", "SCORE_COLOSSAL_DONUT_COMPLETE", "SCORE_COLOSSAL_DONUT_LOCKED", "SCORE_EVENT_COLOSSAL_DONUT_CHEAT", CONTEXT_EPISODE_DONUT )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_COLOSSAL_DONUT_START", "SCORE_EVENT_COLOSSAL_DONUT_RESTART", "SCORE_EVENT_COLOSSAL_DONUT_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Set up objective", "scd_igc01", "INTRO", "FE_FMV_19",0.75 ) )
			mode:AddEntry( NewMap( "shadow map", "colossaldonut", "colossaldonut.str", nil, "SCORE_EVENT_COLOSSAL_DONUT_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Lard Lad is defeated", "scd_igc03", "OUTRO", "FE_FMV_20",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Shadow of the Colossal Donut", "COMPLETED_COLOSSAL_DONUT", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			mode:AddEntry( NewMap( "shadow timed map", "colossaldonut", "colossaldonut.str", "{9F2756DB-4F58-40E9-9633-198B4818822B}", "SCORE_EVENT_COLOSSAL_DONUT_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Colossal Donut Timed Challenge", "FAILED_MODE_TIMED_COLOSSAL_DONUT", "socd_mode_challenge_failed", "SCORE_COLOSSAL_DONUT_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Colossal Donut Timed Challenge", "COMPLETED_MODE_TIMED_COLOSSAL_DONUT", "socd_mode_challenge_complete", "SCORE_COLOSSAL_DONUT_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: THE DAY SPRINGFIELD STOOD STILL
	episode = NewEpisode( game, "SPRINGFIELD_STOOD_STILL", "FE_Episode_dayspringfieldstoodstill", "SCORE_SPRINGFIELD_STOOD_STILL_COMPLETE", "SCORE_SPRINGFIELD_STOOD_STILL_LOCKED", "SCORE_EVENT_SPRINGFIELD_STOOD_STILL_CHEAT", CONTEXT_EPISODE_SPRINGFIELDSTOODSTILL )	    
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_SPRINGFIELD_STOOD_STILL_START", "SCORE_EVENT_SPRINGFIELD_STOOD_STILL_RESTART", "SCORE_EVENT_SPRINGFIELD_STOOD_STILL_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Aliens attack citizens", "sss_igc01", "INTRO", "FE_FMV_15",0.9 ) )
			mode:AddEntry( NewMap( "daySSS map", "dayspringfieldstoodstill", "dayspringfieldstoodstill.str", nil, "SCORE_EVENT_SPRINGFIELD_STOOD_STILL_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Sideshow Bob", "sss_igc03", "OUTRO", "FE_FMV_16",0.9 ) )
			mode:AddEntry( NewMetricScreen( "Completed Day Springfield Stood Still", "COMPLETED_SPRINGFIELD_STOOD_STILL", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed" )
			mode:AddEntry( NewMap( "daySSS timed map", "dayspringfieldstoodstill", "dayspringfieldstoodstill.str", "{B91A7ABE-FE48-4EDA-B0CB-E12EB3D3E800}", "SCORE_EVENT_SPRINGFIELD_STOOD_STILL_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed DSSS Timed Challenge", "FAILED_MODE_TIMED_SPRINGFIELD_STOOD_STILL", "dss_challenge_mode_failed", "SCORE_SPRINGFIELD_STOOD_STILL_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed DSSS Timed Challenge", "COMPLETED_MODE_TIMED_SPRINGFIELD_STOOD_STILL", "dss_challenge_mode_completed", "SCORE_SPRINGFIELD_STOOD_STILL_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: BARGAIN BIN
	episode = NewEpisode( game, "BARGAIN_BIN", "FE_Episode_bargainbin", "SCORE_BARGAIN_BIN_COMPLETE", "SCORE_BARGAIN_BIN_LOCKED", "SCORE_EVENT_BARGAIN_BIN_CHEAT", CONTEXT_EPISODE_BARGAINBIN )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_BARGAIN_BIN_START", "SCORE_EVENT_BARGAIN_BIN_RESTART", "SCORE_EVENT_BARGAIN_BIN_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Homer and Bart go back into the game engine", "bin_igc01", "INTRO", "FE_FMV_21",0.85 ) )
			map = NewMap( "bargain bin map", "bargainbin", "bargainbin.str", nil, "SCORE_EVENT_BARGAIN_BIN_COMPLETE" )
			map:SetNextEpisode( "GAME_HUB" )
			mode:AddEntry( map )
			mode:AddEntry( NewMetricScreen( "Completed Bargain Bin", "COMPLETED_BARGAIN_BIN", "" ) )
			mode:AddEntry( NewMovie( "gam_igc05", "gam_igc05", "OUTRO", "FE_FMV_22",0.9 ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed" )
			mode:AddEntry( NewMap( "bargain bin timed map", "bargainbin", "bargainbin.str", "{7EF8E9CF-8F5F-4821-91C8-C4E309577526}", "SCORE_EVENT_BARGAIN_BIN_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Neverquest Timed Challenge", "FAILED_MODE_TIMED_BARGAIN_BIN", "bin_mode_timed_failed", "SCORE_BARGAIN_BIN_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Neverquest Timed Challenge", "COMPLETED_MODE_TIMED_BARGAIN_BIN", "bin_mode_timed_complete", "SCORE_BARGAIN_BIN_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: GAMEHUB
	episode = NewEpisode( game, "GAME_HUB", "FE_Episode_gamehub", nil, "SCORE_GAME_HUB_LOCKED", "SCORE_EVENT_GAME_HUB_CHEAT", CONTEXT_EPISODE_GAME_HUB )
	episode:SetRoot()
	episode:DisableQuit()
	episode:SetSpawnDefaultPlayers()
	episode:SetReplayDisabled()
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, nil, "SCORE_EVENT_RESTART_GAME_TIME", "SCORE_EVENT_RESTART_GAME_TIME" )
			mode:AddEntry( NewMap( "gamehub map", "gamehub", "gamehub.str" ) )
		    
	--EPISODE: NEVERQUEST
	episode = NewEpisode( game, "NEVERQUEST", "FE_Episode_neverquest", "SCORE_NEVERQUEST_COMPLETE", "SCORE_NEVERQUEST_LOCKED", "SCORE_EVENT_NEVERQUEST_CHEAT", CONTEXT_EPISODE_NEVERQUEST )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_NEVERQUEST_START", "SCORE_EVENT_NEVERQUEST_RESTART", "SCORE_EVENT_NEVERQUEST_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Intro to Hobbit town", "nvq_igc01", "INTRO", "FE_FMV_23",0.8 ) )
			mode:AddEntry( NewMap( "neverquest map", "neverquest", "neverquest.str", nil, "SCORE_EVENT_NEVERQUEST_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Homer grabs the shards", "nvq_igc04", "OUTRO", "FE_FMV_24",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Neverquest", "COMPLETED_NEVERQUEST", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			mode:AddEntry( NewMap( "neverquest timed map", "neverquest", "neverquest.str", "{4E0EAD82-0A12-4064-AE53-34C18F98A4E9}", "SCORE_EVENT_NEVERQUEST_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Neverquest Timed Challenge", "FAILED_MODE_TIMED_NEVERQUEST", "brt_mode_timed_failed", "SCORE_NEVERQUEST_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Neverquest Timed Challenge", "COMPLETED_MODE_TIMED_NEVERQUEST", "brt_mode_timed_complete", "SCORE_NEVERQUEST_CHALLENGE_SUCCESS", 1 ) )
	    
	--EPISODE: GRAND THEFT SCRATCHY
	episode = NewEpisode( game, "GRAND_THEFT_SCRATCHY", "FE_Episode_grand_theft_scratchy", "SCORE_GRAND_THEFT_SCRATCHY_COMPLETE", "SCORE_GRAND_THEFT_SCRATCHY_LOCKED", "SCORE_EVENT_GRAND_THEFT_SCRATCHY_CHEAT", CONTEXT_EPISODE_GRANDTHEFTSCRATCHY )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_GRAND_THEFT_SCRATCHY_START", "SCORE_EVENT_GRAND_THEFT_SCRATCHY_RESTART", "SCORE_EVENT_GRAND_THEFT_SCRATCHY_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Marge and Lisa enter GTS Game", "gts_igc01", "INTRO", "FE_FMV_29",0.75 ) )
			mode:AddEntry( NewMap( "gts map", "grand_theft_scratchy", "grand_theft_scratchy.str", nil, "SCORE_EVENT_GRAND_THEFT_SCRATCHY_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Hot Coffee, Hillary Clinton", "gts_igc03", "OUTRO", "FE_FMV_30",0.9 ) )
			mode:AddEntry( NewMetricScreen( "Completed Grand Theft Scratchy", "COMPLETED_GRAND_THEFT_SCRATCHY", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			map = NewMap( "gts timed map", "grand_theft_scratchy", "grand_theft_scratchy.str", "{1B81CDCD-5B07-4197-A862-B72B5721993C}", "SCORE_EVENT_GRAND_THEFT_SCRATCHY_CHALLENGE_COMPLETE" )
			map:SetPlayerOverride( 0, "{E9B13167-5318-4D2D-AE69-5F0CED25758A}:lisa_sx2_hog3_h2" )
			mode:AddEntry( map )
			mode:AddEntry( NewMetricScreen( "Failed GTS Timed Challenge", "FAILED_MODE_TIMED_GRAND_THEFT_SCRATCHY", "gts_cm_failed", "SCORE_GRAND_THEFT_SCRATCHY_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed GTS Timed Challenge", "COMPLETED_MODE_TIMED_GRAND_THEFT_SCRATCHY", "gts_cm_complete", "SCORE_GRAND_THEFT_SCRATCHY_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: MEDAL OF HOMER
	episode = NewEpisode( game, "MEDAL_OF_HOMER", "FE_Episode_medal_of_homer", "SCORE_MEDAL_OF_HOMER_COMPLETE", "SCORE_MEDAL_OF_HOMER_LOCKED", "SCORE_EVENT_MEDAL_OF_HOMER_CHEAT", CONTEXT_EPISODE_MEDALOFHOMER )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_MEDAL_OF_HOMER_START", "SCORE_EVENT_MEDAL_OF_HOMER_RESTART", "SCORE_EVENT_MEDAL_OF_HOMER_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Mission 1 Briefing", "moh_briefing01", "INTRO" ) )
			map = NewMap( "moh map", "medal_of_homer", "medal_of_homer.str" )
			map:SetPlayerOverride( 0, "{1C98F648-6CE5-4581-996B-0253B13F6964}:bart_bc2_grp1_ss2_h2_moh_drk" )
			map:SetPlayerOverride( 1, "{1C629E06-227B-4C10-81E9-E9CD387B7D1B}:homer_fh1_gh1_hh1_h2_moh_drk" )
			mode:AddEntry( map )
			mode:AddEntry( NewMovie( "Mission 2 Briefing", "moh_briefing02", "INTRO" ) )
			map = NewMap( "moh map", "medal_of_homer", "medal_of_homer.str", "{CACBB150-FAC1-4F3B-AC22-448B141DA10F}" )
			map:MarkAsExtension()
			mode:AddEntry( map )
			mode:AddEntry( NewMovie( "Mission 3 Briefing", "moh_briefing03", "INTRO" ) )
			map = NewMap( "moh map", "medal_of_homer", "medal_of_homer.str", "{63A32AC2-7A5D-4CF2-A5FD-2EBAFB03081A}", "SCORE_EVENT_MEDAL_OF_HOMER_COMPLETE" )
			map:MarkAsExtension()
			mode:AddEntry( map )
			mode:AddEntry( NewMovie( "Retrieval of shard key, Normandy Invasion", "moh_igc03", "OUTRO", "FE_FMV_26",0.9 ) )
			mode:AddEntry( NewMetricScreen( "Completed Medal of Homer", "COMPLETED_MEDAL_OF_HOMER", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			map = NewMap( "moh timed map", "medal_of_homer", "medal_of_homer.str", "{2A2B9245-400D-4875-A02B-9F20F2587DFA}", "SCORE_EVENT_MEDAL_OF_HOMER_CHALLENGE_COMPLETE" )
			map:SetPlayerOverride( 0, "{1C98F648-6CE5-4581-996B-0253B13F6964}:bart_bc2_grp1_ss2_h2_moh_drk" )
			map:SetPlayerOverride( 1, "{1C629E06-227B-4C10-81E9-E9CD387B7D1B}:homer_fh1_gh1_hh1_h2_moh_drk" )
			mode:AddEntry( map )
			mode:AddEntry( NewMetricScreen( "Failed MoH Timed Challenge", "FAILED_MODE_TIMED_MEDAL_OF_HOMER", "moh_challenge_mode_failed", "SCORE_MEDAL_OF_HOMER_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed MoH Timed Challenge", "COMPLETED_MODE_TIMED_MEDAL_OF_HOMER", "moh_challenge_mode_complete", "SCORE_MEDAL_OF_HOMER_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: BIG SUPER HAPPY FUN FUN GAME
	episode = NewEpisode( game, "BIG_SUPER", "FE_Episode_bigsuperhappy", "SCORE_BIG_SUPER_COMPLETE", "SCORE_BIG_SUPER_LOCKED", "SCORE_EVENT_BIG_SUPER_CHEAT", CONTEXT_EPISODE_HAPPYFUNFUN )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_BIG_SUPER_START", "SCORE_EVENT_BIG_SUPER_RESTART", "SCORE_EVENT_BIG_SUPER_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Mr. Dirt Intro", "bsh_igc01", "INTRO", "FE_FMV_27",0.9 ) )
			mode:AddEntry( NewMap( "bigsh map", "bigsuperhappy", "bigsuperhappy.str", nil, "SCORE_EVENT_BIG_SUPER_COMPLETE" ) )
			mode:AddEntry( NewMovie( "Giant washing machine cleans everything", "bsh_igc05", "OUTRO", "FE_FMV_28",0.9 ) )
			mode:AddEntry( NewMetricScreen( "Completed Big Super", "COMPLETED_BIG_SUPER", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			mode:AddEntry( NewMap( "bigsh timed map", "bigsuperhappy", "bigsuperhappy.str", "{25C768EB-A3FD-42DA-BCE3-7E54E617B6C5}", "SCORE_EVENT_BIG_SUPER_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed BSHFF Timed Challenge", "FAILED_MODE_TIMED_BIG_SUPER", "bsh_mode_timed_failed", "SCORE_BIG_SUPER_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed BSHFF Timed Challenge", "COMPLETED_MODE_TIMED_BIG_SUPER", "bsh_mode_timed_complete", "SCORE_BIG_SUPER_CHALLENGE_SUCCESS", 1 ) )

	--EPISODE: RHYMES WITH COMPLAINING
	episode = NewEpisode( game, "RHYMES_WITH_COMPLAINING", "FE_Episode_rhymes", "SCORE_RHYMES_WITH_COMPLAINING_COMPLETE", "SCORE_RHYMES_WITH_COMPLAINING_LOCKED", "SCORE_EVENT_RHYMES_WITH_COMPLAINING_CHEAT", CONTEXT_EPISODE_RHYMESWITHCOMPLAINING )
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_RHYMES_WITH_COMPLAINING_START", "SCORE_EVENT_RHYMES_WITH_COMPLAINING_RESTART", "SCORE_EVENT_RHYMES_WITH_COMPLAINING_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Opening mansion gate", "gam_igc06", "INTRO", "FE_FMV_31",0.9 ) )
			map = NewMap( "rhymes map", "rhymes", "rhymes.str", nil, "SCORE_EVENT_RHYMES_WITH_COMPLAINING_COMPLETE" )
			map:SetNextEpisode( "MEET_THY_PLAYER" )
			mode:AddEntry( map )
			mode:AddEntry( NewMovie( "Confronting Groening", "rwc_igc03", "OUTRO", "FE_FMV_33",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Rhymes", "COMPLETED_RHYMES", "" ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil )
			mode:AddEntry( NewMap( "rhymes timed map", "rhymes", "rhymes.str", "{1DA1AC05-DC32-4E4F-B4C9-7E6918CF480E}", "SCORE_EVENT_RHYMES_WITH_COMPLAINING_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Rhymes With Complaining Timed Challenge", "FAILED_MODE_TIMED_RHYMES_WITH_COMPLAINING", "rwc_mode_timed_failed", "SCORE_RHYMES_WITH_COMPLAINING_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Rhymes With Complaining Timed Challenge", "COMPLETED_MODE_TIMED_RHYMES_WITH_COMPLAINING", "rwc_mode_timed_complete", "SCORE_RHYMES_WITH_COMPLAINING_CHALLENGE_SUCCESS", 1 ) )
	    
	--EPISODE: MEET THY PLAYER
	episode = NewEpisode( game, "MEET_THY_PLAYER", "FE_Episode_meetthyplayer", "SCORE_MEET_THY_PLAYER_COMPLETE", "SCORE_MEET_THY_PLAYER_LOCKED", "SCORE_EVENT_MEET_THY_PLAYER_CHEAT", CONTEXT_EPISODE_MEETTHYPLAYER )
	episode:SetLastEpisode()
	episode:DisableQuit()
	episode:SetAlwaysResetControlledPlayerArray()
		mode = NewMode( episode, "MODE_STANDARD", "FE_GameMode_Standard", nil, "GameMode_TwoPlayer", "SCORE_EVENT_MEET_THY_PLAYER_START", "SCORE_EVENT_MEET_THY_PLAYER_RESTART", "SCORE_EVENT_MEET_THY_PLAYER_UPDATE_PLAY_TIME")
			mode:AddEntry( NewMovie( "Praying", "mtp_igc01", "INTRO", "FE_FMV_34",0.9 ) )
			mode:AddEntry( NewMap( "meet tp map", "meetthyplayer", "meetthyplayer.str", nil, "SCORE_EVENT_MEET_THY_PLAYER_COMPLETE" ) )
			mode:AddEntry( NewMovie( "gam_igc07", "gam_igc07", "OUTRO", "FE_FMV_35",0.85 ) )
			mode:AddEntry( NewMetricScreen( "Completed Meet Thy Player", "COMPLETED_MEET_THY_PLAYER", "" ) )
			mode:AddEntry( NewMetricScreen( "Completed Game", "GAME_COMPLETION_SCREEN", "", "SCORE_MEET_THY_PLAYER_COMPLETION_COUNT", 1 ) )
		mode = NewMode( episode, "MODE_TIMED", "FE_GameMode_Timed", nil, "GameMode_OnePlayer" )
			mode:AddEntry( NewMap( "meet thy player timed map", "meetthyplayer", "meetthyplayer.str", "{63351547-77BB-4506-B121-ADAD55A6F3BF}", "SCORE_EVENT_MEET_THY_PLAYER_CHALLENGE_COMPLETE" ) )
			mode:AddEntry( NewMetricScreen( "Failed Meet Thy Player Timed Challenge", "FAILED_MODE_TIMED_MEET_THY_PLAYER", "mtp_mode_timed_failed", "SCORE_MEET_THY_PLAYER_CHALLENGE_SUCCESS", 0 ) )
			mode:AddEntry( NewMetricScreen( "Completed Meet Thy Player Timed Challenge", "COMPLETED_MODE_TIMED_MEET_THY_PLAYER", "mtp_mode_timed_complete", "SCORE_MEET_THY_PLAYER_CHALLENGE_SUCCESS", 1 ) )
	    

    -- establish game
    gameFlowManager:SetGame( game )    
    
    -- cleanup
    map = nil
    mode = nil
    episode = nil
    game = nil
    gf = nil
    
    collectgarbage( 0 )

end

SetupGame()
SetupCostumes()
