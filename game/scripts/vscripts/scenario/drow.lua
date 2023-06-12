ORIGIN = Vector(-100, -3300, 0)

Scenario["drow"] = {
	-- 1
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		PlayerResource:SetCameraTarget(0, hero)


		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local actor2 = CreateUnitByName("npc_dota_hero_axe", ORIGIN + Vector(800, 0, 0), true, nil, nil, 3)
		actor2:Hold()

		local loop = function(tick)
			if tick == 350 then
				hero:Interrupt()
				hero:MoveToTargetToAttack(actor2)
			end
		end

		local end_loop = function()
			UTIL_Remove(actor2)
		end

		return loop, end_loop
	end,
	-- 2
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1500)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		PlayerResource:SetCameraTarget(0, hero)


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
			if tick == 350 then
				hero:SetNightTimeVisionRange(1700)
			end
		end

		local end_loop = function()
			UTIL_Remove(actor1)
			UTIL_Remove(actor2)
			UTIL_Remove(actor3)
			UTIL_Remove(actor4)
			UTIL_Remove(actor5)

			GameRules:SetTimeOfDay(0.5)
		end

		return loop, end_loop
	end,
	-- 3
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		PlayerResource:SetCameraTarget(0, hero)
		local frost_arrows = hero:GetAbilityByIndex(0)

		frost_arrows:SetLevel(4)
		frost_arrows:ToggleAutoCast()


		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local actor = CreateUnitByName("npc_dota_hero_axe", ORIGIN + Vector(500, 0, 0), true, nil, nil, 3)
		actor:Hold()
		actor:SetControllableByPlayer(0, true)

		local loop = function(tick)
			if tick == 330 then
				actor:Interrupt()
				actor:MoveToPosition(ORIGIN + Vector(350, -350, 0))
			end
			if tick == 350 then
				hero:Interrupt()
				hero:MoveToTargetToAttack(actor)
			end
			if tick == 370 then
				actor:MoveToPosition(ORIGIN + Vector(350, 350, 0))
			end
			if tick == 410 then
				actor:MoveToPosition(ORIGIN + Vector(-350, 350, 0))
			end
			if tick == 450 then
				actor:MoveToPosition(ORIGIN + Vector(350, 350, 0))
			end
			if tick == 490 then
				actor:MoveToPosition(ORIGIN + Vector(350, -350, 0))
			end
		end

		local end_loop = function()
			UTIL_Remove(actor)
			frost_arrows:SetLevel(0)
		end

		return loop, end_loop
	end,
	-- 4
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		PlayerResource:SetCameraTarget(0, hero)
		local silence = hero:GetAbilityByIndex(1)
		silence:SetLevel(1)


		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local actor = CreateUnitByName("npc_dota_hero_lion", ORIGIN + Vector(500, 0, 0), true, nil, nil, 3)
		actor:Hold()
		actor:SetControllableByPlayer(0, true)
		local mana_drain = actor:GetAbilityByIndex(2)
		mana_drain:SetLevel(1)

		local loop = function(tick)
			if tick == 240 then
				actor:Interrupt()
				actor:CastAbilityOnTarget(hero, mana_drain, 0)
			end
			if tick == 300 then
				hero:Interrupt()
				hero:CastAbilityOnPosition(ORIGIN + Vector(450, 0, 0), silence, 0)
			end
		end

		local end_loop = function()
			UTIL_Remove(actor)
			silence:SetLevel(0)
		end

		return loop, end_loop
	end,
	-- 5
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		local trueshot = hero:GetAbilityByIndex(2)


		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(400, 0, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local loop = function(tick)
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToTargetToAttack(dummy)
			end
			if tick == 450 then
				trueshot:SetLevel(1)
			end
			if tick == 600 then
				for _ = 1, 6 do
					hero:HeroLevelUp(false)
				end
				trueshot:SetLevel(4)
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			trueshot:SetLevel(0)
			PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 6
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()
		local marksmanship = hero:GetAbilityByIndex(5)

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(400, 0, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local loop = function(tick)
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToTargetToAttack(dummy)
			end
			if tick == 450 then
				for _ = 1, 5 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(1)
			end
			if tick == 600 then
				for _ = 1, 12 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(3)
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			marksmanship:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 7
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()

		local trueshot = nil
		if hero:HasAbility("drow_ranger_trueshot_custom_1") then
			hero:RemoveAbility("drow_ranger_trueshot_custom_1")
			trueshot = hero:AddAbility("drow_ranger_trueshot_custom_2")
		else
			trueshot = hero:FindAbilityByName("drow_ranger_trueshot_custom_2")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(400, 0, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local loop = function(tick)
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToTargetToAttack(dummy)
			end
			if tick == 600 then
				trueshot:SetLevel(1)
			end
			if tick == 900 then
				for _ = 1, 6 do
					hero:HeroLevelUp(false)
				end
				trueshot:SetLevel(4)
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			trueshot:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 8
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()

		local trueshot = nil
		if hero:HasAbility("drow_ranger_trueshot_custom_1") then
			hero:RemoveAbility("drow_ranger_trueshot_custom_1")
			trueshot = hero:AddAbility("drow_ranger_trueshot_custom_2")
		else
			trueshot = hero:FindAbilityByName("drow_ranger_trueshot_custom_2")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", Vector(-5950, 5300, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local actor = CreateUnitByName("npc_dota_hero_mirana", Vector(-6200, 4900, 256), true, nil, nil, DOTA_TEAM_GOODGUYS)
		actor:Hold()

		local dummy2 = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy2 = CreateUnitByName("npc_dota_hero_target_dummy", Vector(-5950, 5700, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy2:Hold()
			dummy2:SetControllableByPlayer(0, true)
		end, -1)

		local actor2 = CreateUnitByName("npc_dota_creep_goodguys_ranged", Vector(-6200, 5300, 256), true, nil, nil, DOTA_TEAM_GOODGUYS)
		actor:Hold()

		local loop = function(tick)
			if tick == 300 then
				actor:Interrupt()
				actor:MoveToTargetToAttack(dummy)
				actor2:Interrupt()
				actor2:MoveToTargetToAttack(dummy2)
			end
			if tick == 600 then
				trueshot:SetLevel(1)
			end
			if tick == 900 then
				for _ = 1, 6 do
					hero:HeroLevelUp(false)
				end
				trueshot:SetLevel(4)
			end
			if tick == 1200 then
				trueshot:ToggleAbility()
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			UTIL_Remove(actor)
			UTIL_Remove(dummy2)
			UTIL_Remove(actor2)
			trueshot:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 9
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN + Vector(-300, 400, 256), true)
		hero:Hold()

		local trueshot = hero:FindAbilityByName("drow_ranger_trueshot_custom_3")

		if not trueshot then
			hero:RemoveAbility("drow_ranger_trueshot_custom_1")
			hero:RemoveAbility("drow_ranger_trueshot_custom_2")
			trueshot = hero:AddAbility("drow_ranger_trueshot_custom_3")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(200, 0, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local actor = CreateUnitByName("npc_dota_creep_goodguys_ranged", ORIGIN + Vector(-200, 0, 256), true, nil, nil, DOTA_TEAM_GOODGUYS)
		actor:Hold()


		local loop = function(tick)
			if tick == 300 then
				actor:Interrupt()
				actor:MoveToTargetToAttack(dummy)
			end
			if tick == 600 then
				trueshot:SetLevel(1)
			end
			if tick == 900 then
				for _ = 1, 6 do
					hero:HeroLevelUp(false)
				end
				trueshot:SetLevel(4)
			end
			if tick == 1200 then
				hero:Interrupt()
				hero:MoveToPosition(ORIGIN + Vector(-1000, 1000, 256))
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			UTIL_Remove(actor)
			trueshot:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 10
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN + Vector(-300, 400, 256), true)
		hero:Hold()

		local trueshot = hero:FindAbilityByName("drow_ranger_trueshot_custom_4")

		if not trueshot then
			hero:RemoveAbility("drow_ranger_trueshot_custom_1")
			hero:RemoveAbility("drow_ranger_trueshot_custom_2")
			hero:RemoveAbility("drow_ranger_trueshot_custom_3")
			trueshot = hero:AddAbility("drow_ranger_trueshot_custom_4")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(200, 0, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local actor = CreateUnitByName("npc_dota_creep_goodguys_ranged", ORIGIN + Vector(-200, 0, 256), true, nil, nil, DOTA_TEAM_GOODGUYS)
		actor:Hold()


		local loop = function(tick)
			if tick == 300 then
				actor:Interrupt()
				actor:MoveToTargetToAttack(dummy)
			end
			if tick == 600 then
				trueshot:SetLevel(1)
			end
			if tick == 900 then
				for _ = 1, 6 do
					hero:HeroLevelUp(false)
				end
				trueshot:SetLevel(4)
			end
			if tick == 1200 then
				hero:Interrupt()
				hero:MoveToPosition(ORIGIN + Vector(-1000, 1000, 256))
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			UTIL_Remove(actor)
			trueshot:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 11
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN, true)
		hero:Hold()

		local trueshot = hero:FindAbilityByName("drow_ranger_trueshot_custom_4")

		if not trueshot then
			hero:RemoveAbility("drow_ranger_trueshot_custom_1")
			hero:RemoveAbility("drow_ranger_trueshot_custom_2")
			hero:RemoveAbility("drow_ranger_trueshot_custom_3")
			trueshot = hero:AddAbility("drow_ranger_trueshot_custom_4")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(400, 0, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local loop = function(tick)
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToTargetToAttack(dummy)
			end
			if tick == 600 then
				trueshot:SetLevel(1)
			end
			if tick == 900 then
				for _ = 1, 6 do
					hero:HeroLevelUp(false)
				end
				trueshot:SetLevel(4)
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			trueshot:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 12
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN + Vector(-100, -300), true)
		hero:Hold()

		local marksmanship = hero:FindAbilityByName("drow_ranger_marksmanship_custom_2")

		if not marksmanship then
			hero:RemoveAbility("drow_ranger_marksmanship_custom_1")
			marksmanship = hero:AddAbility("drow_ranger_marksmanship_custom_2")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(200, 0, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local actor = CreateUnitByName("npc_dota_hero_axe", ORIGIN + Vector(500, 0, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
		actor:Hold()

		local loop = function(tick)
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToTargetToAttack(dummy)
			end
			if tick == 600 then
				for _ = 1, 5 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(1)
			end
			if tick == 900 then
				for _ = 1, 12 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(3)
			end
			if tick == 1200 then
				actor:Interrupt()
				actor:MoveToPosition(ORIGIN)
			end
			if tick == 1350 then
				actor:Hold()
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			UTIL_Remove(actor)
			marksmanship:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 13
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN + Vector(-100, -300), true)
		hero:Hold()
		local items = {}
		table.insert(items, hero:AddItemByName("item_ultimate_scepter"))

		local marksmanship = hero:FindAbilityByName("drow_ranger_marksmanship_custom_3")

		if not marksmanship then
			hero:RemoveAbility("drow_ranger_marksmanship_custom_1")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_2")
			marksmanship = hero:AddAbility("drow_ranger_marksmanship_custom_3")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(200, 0, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local dummy2 = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy2 = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(100, 150, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy2:Hold()
			dummy2:SetControllableByPlayer(0, true)
		end, -1)
		local dummy3 = nil
		PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
			dummy3 = CreateUnitByName("npc_dota_hero_target_dummy", ORIGIN + Vector(300, -150, 256), true, nil, nil, DOTA_TEAM_NEUTRALS)
			dummy3:Hold()
			dummy3:SetControllableByPlayer(0, true)
		end, -1)

		local loop = function(tick)
			hero:SetHealth(hero:GetMaxHealth())
			hero:SetMana(hero:GetMaxMana())
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToTargetToAttack(dummy)
			end
			if tick == 600 then
				for _ = 1, 5 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(1)
			end
			if tick == 900 then
				for _ = 1, 12 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(3)
			end
			if tick == 1200 then
				table.insert(items, hero:AddItemByName("item_maelstrom"))
				table.insert(items, hero:AddItemByName("item_basher"))
				table.insert(items, hero:AddItemByName("item_monkey_king_bar"))
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			UTIL_Remove(dummy2)
			UTIL_Remove(dummy3)
			UTIL_Remove(actor)

			for _, item in pairs(items) do
				UTIL_Remove(item)
			end

			marksmanship:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 14
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN + Vector(-100, -300), true)
		hero:Hold()

		local marksmanship = hero:FindAbilityByName("drow_ranger_marksmanship_custom_4")
		if not marksmanship then
			hero:RemoveAbility("drow_ranger_marksmanship_custom_1")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_2")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_3")
			marksmanship = hero:AddAbility("drow_ranger_marksmanship_custom_4")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_neutral_granite_golem", function()
			dummy = CreateUnitByName("npc_dota_neutral_granite_golem", ORIGIN + Vector(200, 0, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local dummy2 = nil
		PrecacheUnitByNameAsync("npc_dota_neutral_rock_golem", function()
			dummy2 = CreateUnitByName("npc_dota_neutral_rock_golem", ORIGIN + Vector(100, 150, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy2:Hold()
			dummy2:SetControllableByPlayer(0, true)
		end, -1)
		local dummy3 = nil
		PrecacheUnitByNameAsync("npc_dota_neutral_rock_golem", function()
			dummy3 = CreateUnitByName("npc_dota_neutral_rock_golem", ORIGIN + Vector(300, -150, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy3:Hold()
			dummy3:SetControllableByPlayer(0, true)
		end, -1)

		local loop = function(tick)
			hero:SetHealth(hero:GetMaxHealth())
			hero:SetMana(hero:GetMaxMana())
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToPositionAggressive(hero:GetAbsOrigin())
			end
			if tick == 600 then
				for _ = 1, 5 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(1)
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			UTIL_Remove(dummy2)
			UTIL_Remove(dummy3)

			marksmanship:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 15
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN + Vector(-100, -300), true)
		hero:Hold()

		local marksmanship = hero:FindAbilityByName("drow_ranger_marksmanship_custom_5")
		if not marksmanship then
			hero:RemoveAbility("drow_ranger_marksmanship_custom_1")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_2")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_3")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_4")
			marksmanship = hero:AddAbility("drow_ranger_marksmanship_custom_5")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee", function()
			dummy = CreateUnitByName("npc_dota_creep_badguys_melee", ORIGIN + Vector(200, 0, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local dummy2 = nil
		PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee", function()
			dummy2 = CreateUnitByName("npc_dota_creep_badguys_melee", ORIGIN + Vector(100, 150, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy2:Hold()
			dummy2:SetControllableByPlayer(0, true)
		end, -1)
		local dummy3 = nil
		PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee", function()
			dummy3 = CreateUnitByName("npc_dota_creep_badguys_melee", ORIGIN + Vector(300, -150, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy3:Hold()
			dummy3:SetControllableByPlayer(0, true)
		end, -1)
		local dummy4 = nil
		PrecacheUnitByNameAsync("npc_dota_neutral_granite_golem", function()
			dummy4 = CreateUnitByName("npc_dota_neutral_granite_golem", ORIGIN + Vector(300, 150, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy4:Hold()
			dummy4:SetControllableByPlayer(0, true)
		end, -1)

		local loop = function(tick)
			hero:SetHealth(hero:GetMaxHealth())
			hero:SetMana(hero:GetMaxMana())
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToPositionAggressive(hero:GetAbsOrigin())
			end
			if tick == 600 then
				for _ = 1, 5 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(1)
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)
			UTIL_Remove(dummy2)
			UTIL_Remove(dummy3)
			UTIL_Remove(dummy4)

			marksmanship:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
	-- 16
	function()
		_G.GameModeEntity:SetMaximumAttackSpeed(700)
		_G.GameModeEntity:SetCameraDistanceOverride(1134)

		GameMode:HideUI(true)

		local hero = PlayerResource:GetSelectedHeroEntity(0)
		FindClearSpaceForUnit(hero, ORIGIN + Vector(-100, -300), true)
		hero:Hold()

		local marksmanship = hero:FindAbilityByName("drow_ranger_marksmanship_custom_5")
		if not marksmanship then
			hero:RemoveAbility("drow_ranger_marksmanship_custom_1")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_2")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_3")
			hero:RemoveAbility("drow_ranger_marksmanship_custom_4")
			marksmanship = hero:AddAbility("drow_ranger_marksmanship_custom_5")
		end

		hero:SetMaxHealth(540)
		hero:SetMaxMana(255)
		hero:SetHealth(540)
		hero:SetMana(255)

		local dummy = nil
		PrecacheUnitByNameAsync("npc_dota_hero_terrorblade", function()
			dummy = CreateUnitByName("npc_dota_hero_terrorblade", ORIGIN + Vector(200, 0, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
			dummy:Hold()
			dummy:SetControllableByPlayer(0, true)
			for i=2, 30 do
				dummy:HeroLevelUp(false)
			end
			PlayerResource:SetCameraTarget(0, dummy)
		end, -1)

		local loop = function(tick)
			hero:SetHealth(hero:GetMaxHealth())
			hero:SetMana(hero:GetMaxMana())
			if tick == 300 then
				hero:Interrupt()
				hero:MoveToPositionAggressive(hero:GetAbsOrigin())
			end
			if tick == 600 then
				for _ = 1, 5 do
					hero:HeroLevelUp(false)
				end
				marksmanship:SetLevel(1)
			end
		end

		local end_loop = function()
			UTIL_Remove(dummy)

			marksmanship:SetLevel(0)
			local hero = PlayerResource:ReplaceHeroWithNoTransfer(0, "npc_dota_hero_drow_ranger", 0, 0)
			PlayerResource:GetPlayer(0):SetAssignedHeroEntity(hero)
		end

		return loop, end_loop
	end,
}
