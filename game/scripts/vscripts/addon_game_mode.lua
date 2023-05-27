_G.GameMode = GameMode or {}

require("declarations")

require("extensions/init")
require("utils/init")
require("libraries/init")
require("filters/init")
require("events/init")
require("game/init")

function Activate()
	GameMode:Init()
end


function Precache(context)
	print("[GameMode] Precache started")

	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_leshrac.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/custom_sounds.vsndevts", context)

	print("[GameMode] Precache finished")
end

function GameMode:Init()
	print("[GameMode] Init started")

	local game_mode_entity = GameRules:GetGameModeEntity()
	game_mode_entity.GameMode = self

	GameMode:SetupTeams()
	GameMode:EmpowerFountains()
	Filters:Init()

	game_mode_entity:SetFreeCourierModeEnabled(true)
	game_mode_entity:SetUseDefaultDOTARuneSpawnLogic(true)
	game_mode_entity:SetDaynightCycleDisabled(false)
	game_mode_entity:SetBotThinkingEnabled(true)
	game_mode_entity:SetTowerBackdoorProtectionEnabled(true)
	game_mode_entity:SetMaximumAttackSpeed(700)
	game_mode_entity:SetCameraDistanceOverride(1400)
	GameRules:SetTimeOfDay(0.251)
	GameRules:SetPreGameTime(90)

	GameRules:SetUseUniversalShopMode(true)

	if IsInToolsMode() then
		game_mode_entity:SetFixedRespawnTime(1)
		game_mode_entity:SetDraftingBanningTimeOverride(0)
		GameRules:SetCustomGameSetupAutoLaunchDelay(3)
	end

	_G.GameModeEntity = game_mode_entity

	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(Events, "OnGameRulesStateChange"), Events)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(Events, "OnNPCSpawned"), Events)
	ListenToGameEvent("entity_killed", Dynamic_Wrap(Events, "OnEntityKilled"), Events)

	print("[GameMode] Init finished")
end


function GameMode:SetupTeams()
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 5)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 5)
end

function GameMode:EmpowerFountains()
	local fountains = Entities:FindAllByClassname("ent_dota_fountain")
	GameMode.fountain_positions = {}

	for _, fountain in pairs(fountains) do
		print("[GameMode] found fountain", fountain:GetEntityIndex(), "of", fountain:GetTeam())

		-- record fountain positions for order filter
		GameMode.fountain_positions[fountain:GetTeam()] = fountain:GetAbsOrigin()

		fountain:AddNewModifier(fountain, nil, "modifier_fountain_offence_aura", {duration = -1})
	end
end


function GameMode:IsDeveloper(player_id)
	if IsInToolsMode() then return true end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))
	return DEV_STEAM_IDS[steam_id] == true
end
