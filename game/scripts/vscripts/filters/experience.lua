function Filters:FilterModifyExperience(event)
	local hero = event.hero_entindex_const and EntIndexToHScript(event.hero_entindex_const)

	if hero and hero.IsTempestDouble and hero:IsTempestDouble() then
		return false
	end

	-- processing goes here

	event.experience = event.experience * GameSettings:GetExpMultiplier()

	-- Teamwide exp sharing
	if GameSettings:GetShareTeamExp() and GameSettings:GetShareTeamExp() > 0 and GameSettings.correct_heroes then
		for _, other_hero in pairs(GameSettings.correct_heroes) do
			if hero ~= other_hero and hero:GetTeam() == other_hero:GetTeam() then
				other_hero:AddExperience(event.experience * GameSettings:GetShareTeamExp(), DOTA_ModifyXP_Unspecified, false, true)
			end
		end
	end

	return true
end
