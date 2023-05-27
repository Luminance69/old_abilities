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
	GameRules:SetTimeOfDay(0.5)
	GameRules:SetPreGameTime(90)
	GameRules:SetCreepSpawningEnabled(false)

	GameRules:SetUseUniversalShopMode(false)

	game_mode_entity:SetFixedRespawnTime(1)
	game_mode_entity:SetDraftingBanningTimeOverride(0)
	GameRules:SetCustomGameSetupAutoLaunchDelay(1)

	_G.GameModeEntity = game_mode_entity

	ChatCommands:Init()
	Scenario:Init()
end

function GameMode:HideUI(hide)
	CustomGameEventManager:Send_ServerToAllClients("hide_ui", {hide = hide})
end
