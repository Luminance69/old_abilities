PanoramaResponses = PanoramaResponses or {}
PANORAMA_RESPONSE_PLAYER = 0
PANORAMA_RESPONSE_TEAM = 1
PANORAMA_RESPONSE_ALL = 2

function PanoramaResponses:Init()
	self.requests_funcs = {
		[PANORAMA_RESPONSE_PLAYER] = self._RegisterRequest_ToPlayer,
		[PANORAMA_RESPONSE_TEAM] = self._RegisterRequest_ToTeam,
		[PANORAMA_RESPONSE_ALL] = self._RegisterRequest_ToAll,
	}
	
	self:Subscribe("HeroSelection:preselect_hero", "HeroSelection:topbar_preselect_hero", PANORAMA_RESPONSE_TEAM, self.UpdatePreselectHero)
	self:Subscribe("scoreboard:get_valid_abilities", "scoreboard:update_valid_abilities", PANORAMA_RESPONSE_PLAYER, self.UpdateValidAbilities)
end

--[[
	Requests
]]--

function PanoramaResponses.UpdatePreselectHero(data)
	return {
		player_id = data.event.PlayerID,
		hero_name = data.event.hero_name,
	}
end

PanoramaResponses.SelectedHero = PanoramaResponses.UpdatePreselectHero

function PanoramaResponses.UpdateValidAbilities(data)
	return AbilityController.valid_abilities;
end


--[[
	Basic functions
]]--

function PanoramaResponses:Subscribe(event_name, callback_name, panorama_response_type, func)
	if not func then return end
	
	RegisterCustomEventListener(event_name, function(event)
		local player = event.PlayerID and PlayerResource:GetPlayer(event.PlayerID)
		if not player then return end
		
		self.requests_funcs[panorama_response_type](func, callback_name, player, event)
	end)
end

function PanoramaResponses._RegisterRequest_ToPlayer(func, callback_name, player, event)
	CustomGameEventManager:Send_ServerToPlayer(player, callback_name, func({ event = event, player = player }))
end

function PanoramaResponses._RegisterRequest_ToTeam(func, callback_name, player, event)
	local team_id = player:GetTeam()
	if not team_id then return end

	CustomGameEventManager:Send_ServerToTeam(team_id, callback_name, func({ event = event, player = player, team_id = team_id }))
end

function PanoramaResponses._RegisterRequest_ToAll(func, callback_name, player, event)
	CustomGameEventManager:Send_ServerToAllClients(callback_name, func({event = event, player = player}))
end

PanoramaResponses:Init()
