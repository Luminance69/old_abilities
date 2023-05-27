GameSettings = GameSettings or {}

function GameSettings:Init()
	GameSettings.settings = {
		["gold_multiplier"] = 300,
		["exp_multiplier"] = 300,
		["bonus_passive_gpm"] = 300,
		["bonus_passive_xpm"] = 300,
		["share_team_gold"] = 0,
		["share_team_exp"] = 0,
		["respawn_time_reduction"] = 50,
		["respawn_time_cap"] = 80,
		["death_match"] = false,
	}

	GameSettings.globals = {}

	RegisterCustomEventListener("GameSettings:get_settings", function(event) GameSettings:GetSettings(event) end)
	RegisterCustomEventListener("GameSettings:set_settings", function(event) GameSettings:SetSettings(event) end)
end

function GameSettings:GetGoldMultiplier() return self.settings.gold_multiplier / 100 end
function GameSettings:GetExpMultiplier() return self.settings.exp_multiplier / 100 end
function GameSettings:GetBonusGPM() return self.settings.bonus_passive_gpm ~= 0 and self.settings.bonus_passive_gpm end
function GameSettings:GetBonusXPM() return self.settings.bonus_passive_xpm ~= 0 and self.settings.bonus_passive_xpm end
function GameSettings:GetShareTeamGold() return self.settings.share_team_gold > 0 and self.settings.share_team_gold / 100 end
function GameSettings:GetShareTeamExp() return self.settings.share_team_exp > 0 and self.settings.share_team_exp / 100 end
function GameSettings:GetRespawnTimeReduction() return math.min(self.settings.respawn_time_reduction, 100) / 100 end
function GameSettings:GetRespawnTimeCap() return math.max(self.settings.respawn_time_cap, 0) end
function GameSettings:IsDeathMatchMode() return self.settings.death_match end


function GameSettings:GameStateChanged(event)
	if event.state ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then return end
	if not self:GetBonusGPM() and not self:GetBonusXPM() then return end

	Timers:CreateTimer(function()
		for _, hero in pairs(HeroController.known_player_heroes) do
			if self:GetBonusGPM() then
				-- print("adding gold from passive gpm to", hero:GetUnitName(), self:GetBonusGPM() * 0.05)
				hero:ModifyGold(self:GetBonusGPM() * 0.05, false, 0)
			end
			if self:GetBonusXPM() then
				hero:AddExperience(self:GetBonusXPM() * 0.05, DOTA_ModifyXP_Unspecified, false, true)
			end
		end
		return 3
	end)
end

function GameSettings:GetSettings(event)
	local player_id = event.PlayerID
	if not player_id then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not player then return end


	CustomGameEventManager:Send_ServerToPlayer(player,"GameSettings:create", GameSettings.settings)
end

function GameSettings:SetSettings(event)
	local player_id = event.PlayerID
	if not player_id or player_id ~= 0 then return end

	local settings = event.settings
	if not settings then return end

	for s_name, value in pairs(settings) do
		if GameSettings.globals[s_name] then
			_G[GameSettings.globals[s_name]] = tonumber(value)
		end

		if type(self.settings[s_name]) == "boolean" then
			value = value ~= 0
		end

		self.settings[s_name] = value
	end
end

GameSettings:Init()
