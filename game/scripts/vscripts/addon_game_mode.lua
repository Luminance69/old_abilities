_G.GameMode = GameMode or {}

require("extensions/init")
require("utils/init")
require("libraries/init")
require("scenario/scenario")

function Activate()
	GameMode:Init()
end

function GameMode:Init()
	print("[GameMode] Init started")

	local game_mode_entity = GameRules:GetGameModeEntity()
	game_mode_entity.GameMode = self

	game_mode_entity:SetFreeCourierModeEnabled(true)
	game_mode_entity:SetUseDefaultDOTARuneSpawnLogic(true)
	game_mode_entity:SetDaynightCycleDisabled(true)
	game_mode_entity:SetBotThinkingEnabled(false)
	game_mode_entity:SetAnnouncerDisabled(true)
	game_mode_entity:SetAnnouncerGameModeAnnounceDisabled(true)
	GameRules:SetTimeOfDay(0.5)
	GameRules:SetPreGameTime(90)
	GameRules:SetHeroSelectionTime(0)
	GameRules:SetHeroSelectPenaltyTime(0)
	GameRules:SetStrategyTime(0)
	GameRules:SetShowcaseTime(0)
	GameRules:SetCreepSpawningEnabled(false)
	GameRules:SetNeutralInitialSpawnOffset(99999)

	GameRules:SetUseUniversalShopMode(false)

	game_mode_entity:SetFixedRespawnTime(1)
	game_mode_entity:SetDraftingBanningTimeOverride(0)
	GameRules:SetCustomGameSetupAutoLaunchDelay(1)

	_G.GameModeEntity = game_mode_entity

	-- Register events
	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(GameMode, "OnGameRulesStateChange"), self)

	ChatCommands:Init()
	Scenario:Init()
end

function GameMode:HideUI(hide)
	CustomGameEventManager:Send_ServerToAllClients("hide_ui", {hide = hide})
end

function GameMode:OnGameRulesStateChange()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then
		PlayerResource:GetPlayer(0):SetSelectedHero("npc_dota_hero_drow_ranger")
	end
end
