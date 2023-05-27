function CDOTA_BaseNPC:RemoveAbilityForEmpty(ability_name)
	if string.starts(ability_name, "empty_") then return end

	local ability = self:FindAbilityByName(ability_name)
	if not ability then return end

	local index = ability:GetAbilityIndex()

	ScepterController:OnAbilityLost(self, ability)
	ShardController:OnAbilityLost(self, ability)
	if not ability.is_secondary then
		self:SetAbilityPoints(self:GetAbilityPoints() + ability:GetLevel())
		AbilityController:UnlockAbility(ability_name, ability:GetAbilityType())
	end

	table.remove_item(self.abilities, ability)
	self.ability_names[ability_name] = nil

	ability:Disable()
	if index <= 5 then -- only swap if we get assigned hotkey, otherwise pointless
		self:SwapAbilities(ability_name, "empty_" .. index, false, false)
	end

	local placeholder = self:FindAbilityByName("empty_" .. index)
	if placeholder then
		placeholder.used_placeholder = nil
	end

	for linked_name, hidden_status in pairs(AbilityController.linked_abilities[ability_name] or {}) do
		self:RemoveAbilityForEmpty(linked_name)
	end


	ability:SetRemovalTimer()
end


function CDOTA_BaseNPC:HasShard()
	if not self or self:IsNull() then return end

	return self:HasModifier("modifier_item_aghanims_shard")
end

-- Talent handling
function CDOTA_BaseNPC:HasTalent(talent_name)
	if not self or self:IsNull() then return end

	local talent = self:FindAbilityByName(talent_name)
	if talent and talent:GetLevel() > 0 then return true end
end


function CDOTA_BaseNPC:FindTalentValue(talent_name, key)
	if self:HasTalent(talent_name) then
		local value_name = key or "value"
		return self:FindAbilityByName(talent_name):GetSpecialValueFor(value_name)
	end
	return 0
end
