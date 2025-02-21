--///////////////////////////////////////////////////////////////////////////////
--/// \file simpsons_gameflow_helpers.h
--/// \brief Simpsons Gameflow Helpers
--///
--///	Contains Wrapper functions to assist in building the gameflow model
--///
--/// \par Copyright:
--///   (c) 2006 - Electronic Arts Inc.
--/// \author 
--///   Kaye Mason
--/// \date 
--///   12/12/06
--///////////////////////////////////////////////////////////////////////////////

function NewGame( name, type )
	local object = GamePkg:New( name, type )
	result = tolua.takeownership( object )
	assert( result, "LUA failed to take ownership of a Game Package." )
	return object
end

function GetGame()
	local object = GameFlowManager:GetGameFlowManager():GetGame()
	result = tolua.takeownership( object )
	assert( result, "LUA failed to take ownership of a Game Package." )
	return object
end

function NewEpisode( game, name, localizedKey, completeScore, lockedScore, cheatScoreEvent, richPresenceID )
	local object = EpisodePkg:New( name, localizedKey, completeScore, lockedScore )
	object:SetCheatScoreEventName( cheatScoreEvent )
	
	if richPresenceID ~= nil then
		object:SetRichPresenceID( richPresenceID )
		end
	
	result = tolua.takeownership( object )
	assert( result, "LUA failed to take ownership of an Episode Package." )
	game:AddEpisode( object )
	return object
end

function FindEpisode( game, name )
	local object = game:FindEpisode( name )
	if object ~= nil then
		result = tolua.takeownership( object )
		assert( result, "LUA failed to take ownership of an Episode Package." )
		end
	return object
end

function NewMode( episode, modeType, modeName, completionEvent, numPlayers, startEvent, restartEvent, updateTimeEvent )
	local object = ModePkg:New( modeType )
	result = tolua.takeownership( object )
	object:SetLocalizedName( modeName )
	if completionEvent ~= nil then
		object:SetCompletionScoreEvent( completionEvent )
		end
	if numPlayers ~= nil then
		object:SetNumPlayersAllowed( numPlayers )
		end
	if startEvent ~= nil then
		object:SetStartScoreEvent( startEvent )
		end
	if restartEvent ~= nil then
		object:SetRestartScoreEvent( restartEvent )
		end
	if updateTimeEvent ~= nil then
		object:SetUpdateTimeScoreEvent( updateTimeEvent )
		end
	assert( result, "LUA failed to take ownership of a Mode Package." )
	episode:AddEntry( object )
	return object
end

function NewMovie( movieName, stream, movieType, localizedKey, movieVolume )
	local object = MoviePkg:New( movieName, stream, movieType )
	if localizedKey ~= nil then
		object:SetLocalizedKey( localizedKey )
		end

	if movieVolume ~= nil then
		object:SetMovieVolume( movieVolume )
		end

	result = tolua.takeownership( object )
	assert( result, "LUA failed to take ownership of a Movie Package." )
	return object
end

function NewMap( mapName, folder, stream, checkpoint, completionEvent )
	local object = MapPkg:New( mapName, folder, stream )
	if checkpoint ~= nil then
		object:SetCheckpoint( checkpoint )
		end
	if completionEvent ~= nil then
		object:SetCompletionScoreEvent( completionEvent )
		end
	result = tolua.takeownership( object )
	assert( result, "LUA failed to take ownership of a Map Package." )
	return object
end

function NewMetricScreen( name, bindingName, titleKey, requiredScore, requiredValue )
	local object = MetricScreenPkg:New( name, bindingName, titleKey )
	if requiredScore ~= nil then
		object:SetRequiredScore( requiredScore )
		if requiredValue ~= nil then
			object:SetRequiredScoreValue( requiredValue )
			end
		end
	result = tolua.takeownership( object )
	assert( result, "LUA failed to take ownership of a MetricScreen Package." )
	return object
end
