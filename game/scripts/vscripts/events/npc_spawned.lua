function Events:OnNPCSpawned(event)
	local unit = EntIndexToHScript(event.entindex)

	local unit_name = unit:GetUnitName()

	-- wait for 1 frame for unit creation to finalize
	-- some fields aren't correct when accessed from here without delay
	Timers:CreateTimer(0, function()
		Events:_OnNpcInitFinished(event, unit, unit_name)
	end)
end


function Events:_OnNpcInitFinished(event, unit, unit_name)
	if not unit or unit:IsNull() then return end
	local owner_player_id = unit:GetPlayerOwnerID()

	if unit_name == "npc_dota_courier" then
		print("[Events] applying speed bonus to courier")
		unit:AddNewModifier(unit, nil, "modifier_courier_speed_bonus", {})
	end

	if unit_name == "npc_dota_roshan" then
		print("[Events] applying stat bonus to roshan")
		unit:AddNewModifier(unit, nil, "modifier_roshan_devotion_aura_omg", {})
	end

	if unit == PlayerResource:GetSelectedHeroEntity(owner_player_id) then
		HeroController:InitHero(owner_player_id, unit)
	end
end
