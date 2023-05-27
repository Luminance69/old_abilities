MVPTracker = MVPTracker or {
	players = {}
}

local wards = {
	npc_dota_observer_wards = true,
	npc_dota_sentry_wards = true,
}

ListenToGameEvent("game_rules_state_change", function()
	 if GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
	 	MVPTracker:Init()
	 end
end, nil)

function MVPTracker:Init()

	for pID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		self.players[pID] = {}
	end

	ListenToGameEvent("last_hit", MVPTracker.OnLastHit, MVPTracker)
	ListenToGameEvent("entity_hurt", MVPTracker.OnEntityHurt, MVPTracker)

	-- EventDriver:Listen("neutral_camp_creep_stacked", MVPTracker.OnNeutralCampCreepStacked, MVPTracker)

	-- Enumerate neutral spawners for neutral camp stack event purposes
	local spawners = Entities:FindAllByClassname("npc_dota_neutral_spawner")
	local i = 0
	for k, spawner in pairs(spawners) do
		spawner:SetEntityName(tostring(i))
		i = i + 1
	end
end

local spawners_frame_stacked = {}
function MVPTracker:OnNeutralCampCreepStacked(event)
	local spawner_number = event.creep:GetNeutralSpawnerName()

	local frame = GetFrameCount()
	if spawners_frame_stacked[spawner_number] ~= frame then
		spawners_frame_stacked[spawner_number] = frame
		self:IncrementCampStacks(event.hero:GetPlayerOwnerID())
		print("[MVPTracker]: " .. "Neutral camp #" .. spawner_number .. " stacked by player " .. event.hero:GetPlayerOwnerID())
	end
end

function MVPTracker:OnLastHit(event)
	if event.PlayerID == -1 then return end

	local killed = EntIndexToHScript(event.EntKilled)
	if not IsValidEntity(killed) then return end

	if wards[killed:GetUnitName()] and PlayerResource:GetTeam(event.PlayerID) ~= killed:GetTeam() then
		self:IncrementWardKills(event.PlayerID)
	end
end

function MVPTracker:OnEntityHurt(event)
	local victim = EntIndexToHScript(event.entindex_killed)
	local attacker = EntIndexToHScript(event.entindex_attacker)
	if not IsValidEntity(victim) or not IsValidEntity(attacker) then return end

	local player_id = attacker:GetPlayerOwnerID()
	if player_id == -1 then return end

	if victim:IsBuilding() and victim:GetPlayerOwnerID() == -1 then
		self:AddBuidingDamage(player_id, event.damage)
	end
end

function MVPTracker:AddBuidingDamage(player_id, damage)
	self.players[player_id].building_damage = (self.players[player_id].building_damage or 0) + damage
end

function MVPTracker:GetBuidingDamage(player_id)
	return self.players[player_id].building_damage or 0
end

function MVPTracker:IncrementWardKills(player_id)
	self.players[player_id].ward_kills = (self.players[player_id].ward_kills or 0) + 1
end

function MVPTracker:GetWardKills(player_id)
	return self.players[player_id].ward_kills or 0
end

function MVPTracker:IncrementCampStacks(player_id)
	self.players[player_id].camp_stacks = (self.players[player_id].camp_stacks or 0) + 1
end

function MVPTracker:GetCampStacks(player_id)
	return self.players[player_id].camp_stacks or 0
end

function MVPTracker:AddWeirdPoints(player_id, points)
	self.players[player_id].weird_shit = (self.players[player_id].weird_shit or 0) + points
end

function MVPTracker:GetWeirdPoints(player_id)
	return self.players[player_id].weird_shit or 0
end

function MVPTracker:GetDamageDoneByPlayer(player_id)
	local damage = 0

	for pID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(player_id) ~= PlayerResource:GetTeam(pID) then
			damage = damage + PlayerResource:GetDamageDoneToHero(player_id, pID)
		end
	end

	return damage
end

function MVPTracker:GetMostValuablePlayer(winning_team)
	local player_points = self:CalcPlayerPoints()

	local mvp_id = -1
	local mvp_points = 0.01

	for player_id, points in pairs(player_points) do
		if PlayerResource:GetTeam(player_id) == winning_team then
			if points > mvp_points or (points == mvp_points and RollPercentage(50)) then
				mvp_id = player_id
				mvp_points = points
			end
		end
	end

	return mvp_id
end

function MVPTracker:GetRunnerUpPlayer(winning_team, team)
	local mvp_id = self:GetMostValuablePlayer(winning_team)
	local player_points = self:CalcPlayerPoints()

	local runner_up_id = -1
	local runner_up_points = 0.01

	for player_id, points in pairs(player_points) do
		if PlayerResource:GetTeam(player_id) == team and player_id ~= mvp_id then
			if points > runner_up_points or (points == runner_up_points and RollPercentage(50)) then
				runner_up_id = player_id
				runner_up_points = points
			end
		end
	end

	return runner_up_id
end

function MVPTracker:CalcPlayerPoints()
	local players = {}
	local player_points = {}

	local data = {
		camps_stack = {},
		ward_kills = {},
		denies = {},
		kills_assists = {},
		building_damage = {},
		hero_damage = {},
		healing = {},
	}

	for player_id = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayerID(player_id) then
			data.camps_stack[player_id] = self:GetCampStacks(player_id)
			data.ward_kills[player_id] = self:GetWardKills(player_id)
			data.denies[player_id] = PlayerResource:GetDenies(player_id)
			data.kills_assists[player_id] = PlayerResource:GetKills(player_id) + PlayerResource:GetAssists(player_id)
			data.building_damage[player_id] = self:GetBuidingDamage(player_id)
			data.hero_damage[player_id] = self:GetDamageDoneByPlayer(player_id)
			data.healing[player_id] = PlayerResource:GetHealing(player_id)

			player_points[player_id] = 0
		end
	end

	local get_max = function(t)
		local res = {}
		local max = 1

		for k,v in pairs(t) do
			v = math.floor(v + 0.5)

			if v > max then
				res = { k }
				max = v
			elseif v == max then
				table.insert(res, k)
			end
		end

		return res
	end

	data = vlua.map(data, get_max)

	for stat, best in pairs(data) do
		local points = 1 / #best

		for _, player_id in pairs(best) do
			player_points[player_id] = player_points[player_id] + points
		end
	end

	return player_points
end

function MVPTracker:DebugPrint()
	print("[MVPTracker]:")

	DeepPrintTable(MVPTracker:CalcPlayerPoints())

	print("MVP Radiant:", MVPTracker:GetMostValuablePlayer(DOTA_TEAM_GOODGUYS))
	print("MVP Dire:", MVPTracker:GetMostValuablePlayer(DOTA_TEAM_BADGUYS))

	print("RunnerUp Radiant Radiant:", MVPTracker:GetRunnerUpPlayer(DOTA_TEAM_GOODGUYS, DOTA_TEAM_GOODGUYS))
	print("RunnerUp Radiant Dire:", MVPTracker:GetRunnerUpPlayer(DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS))

	print("RunnerUp Dire Radiant:", MVPTracker:GetRunnerUpPlayer(DOTA_TEAM_BADGUYS, DOTA_TEAM_GOODGUYS))
	print("RunnerUp Dire Dire:", MVPTracker:GetRunnerUpPlayer(DOTA_TEAM_BADGUYS, DOTA_TEAM_BADGUYS))
end
