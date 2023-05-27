Filters = Filters or {}

require("filters/experience")
require("filters/gold")

function Filters:Init()
	local game_mode_entity = GameRules:GetGameModeEntity()

	game_mode_entity:SetModifyGoldFilter(Dynamic_Wrap(Filters, "ModifyGoldFilter"), Filters)
	game_mode_entity:SetModifyExperienceFilter(Dynamic_Wrap(Filters, "FilterModifyExperience"), Filters)
end
