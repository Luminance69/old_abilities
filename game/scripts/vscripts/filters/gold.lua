function Filters:ModifyGoldFilter(event)
	local player_id = event.player_id_const
	local hero = (player_id and PlayerResource:GetSelectedHeroEntity(player_id)) or nil

	-- processing goes here

	event.gold = event.gold * GameSettings:GetGoldMultiplier()
	-- Teamwide gold sharing
	if GameSettings:GetShareTeamGold() and GameSettings:GetShareTeamGold() > 0 and HeroController.known_player_heroes then
		for _, other_hero in pairs(HeroController.known_player_heroes) do
			if hero ~= other_hero and hero:GetTeam() == other_hero:GetTeam() then
				other_hero:ModifyGold(event.gold * GameSettings:GetShareTeamGold(), false, 0)
			end
		end
	end

	return true
end
