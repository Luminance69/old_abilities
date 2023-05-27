ORIGIN = Vector(-100, -3300, 0)

Scenario["drow"] = {
	-- 1
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		PlayerResource:SetCameraTarget(0, hero)

		-- Hero stats as of 6.70
		hero:SetBaseStrength(17)
		hero:SetBaseAgility(26)
		hero:SetBaseIntellect(15)
		hero:SetBaseDamageMin(1)
		hero:SetBaseDamageMax(1)

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local actor = CreateUnitByName("npc_dota_hero_axe", ORIGIN + Vector(800, 0, 0), true, nil, nil, 3)
		actor:Hold()

		local loop = function(tick)
			if tick == 300 then
				hero:MoveToTargetToAttack(actor)
			end
		end

		local end_loop = function()
			UTIL_Remove(actor)
		end

		return loop, end_loop
	end,
	-- 2
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1500)

		GameMode:HideUI(true)

		local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		PlayerResource:SetCameraTarget(0, hero)

		-- Hero stats as of 6.70
		hero:SetBaseStrength(17)
		hero:SetBaseAgility(26)
		hero:SetBaseIntellect(15)
		hero:SetBaseDamageMin(1)
		hero:SetBaseDamageMax(1)

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		GameRules:SetTimeOfDay(0)

		local actor1 = CreateUnitByName("npc_dota_hero_axe", ORIGIN + Vector(1000, 0, 0), true, nil, nil, 3)
		local actor2 = CreateUnitByName("npc_dota_hero_tinker", ORIGIN + Vector(-700, 400, 0), true, nil, nil, 3)
		local actor3 = CreateUnitByName("npc_dota_hero_pudge", ORIGIN + Vector(-800, 0, 0), true, nil, nil, 3)
		local actor4 = CreateUnitByName("npc_dota_hero_sven", ORIGIN + Vector(400, -200, 0), true, nil, nil, 3)
		local actor5 = CreateUnitByName("npc_dota_hero_chen", ORIGIN + Vector(0, 1000, 0), true, nil, nil, 3)
		actor1:Hold()
		actor2:Hold()
		actor3:Hold()
		actor4:Hold()
		actor5:Hold()

		local loop = function(tick)
			if tick == 300 then
				hero:SetNightTimeVisionRange(1700)
			end
		end

		local end_loop = function()
			UTIL_Remove(actor1)
			UTIL_Remove(actor2)
			UTIL_Remove(actor3)
			UTIL_Remove(actor4)
			UTIL_Remove(actor5)
		end

		return loop, end_loop
	end,
	-- 3
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		PlayerResource:SetCameraTarget(0, hero)
		local frost_arrows = hero:GetAbilityByIndex(0)

		frost_arrows:SetLevel(1)
		frost_arrows:ToggleAutoCast()

		-- Hero stats as of 6.70
		hero:SetBaseStrength(17)
		hero:SetBaseAgility(26)
		hero:SetBaseIntellect(15)
		hero:SetBaseDamageMin(1)
		hero:SetBaseDamageMax(1)

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local actor = CreateUnitByName("npc_dota_hero_axe", ORIGIN + Vector(500, 0, 0), true, nil, nil, 3)
		actor:Hold()
		actor:SetControllableByPlayer(0, true)

		local loop = function(tick)
			if tick == 280 then
				-- VALVE PLS WHY DOESNT THIS WORK
				actor:MoveToPosition(ORIGIN + Vector(250, -250, 0))
			end
			if tick == 300 then
				hero:MoveToTargetToAttack(actor)
				actor:MoveToPosition(ORIGIN + Vector(250, 250, 0))
			end
			if tick == 330 then
				actor:MoveToPosition(ORIGIN + Vector(-250, 250, 0))
			end
		end

		local end_loop = function()
			UTIL_Remove(actor)
		end

		return loop, end_loop
	end,
}
