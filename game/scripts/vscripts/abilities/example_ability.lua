example_ability = example_ability or class({})
modifier_example_ability = modifier_example_ability or class({})
LinkLuaModifier("modifier_example_ability", "abilities/example_ability", LUA_MODIFIER_MOTION_NONE)

-- Set ability to level 1 at the start of the game
function example_ability:Spawn()
	if IsClient then return end

	self:SetLevel(1)
end

function example_ability:GetIntrinsicModifierName()
	return "modifier_example_ability"
end



function modifier_example_ability:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}
end

function modifier_example_ability:GetModifierOverrideAbilitySpecial(keys)
    if not keys.ability or not keys.ability_special_value then return 0 end

	if not not keys.ability == self:GetAbility() then return end

	if keys.ability_special_value == "example_kv_dynamic_base" then
		print(1)
		return 1
	else
		return 0
	end
end

function modifier_example_ability:GetModifierOverrideAbilitySpecialValue(keys)
    local ability = keys.ability
    local special_value = keys.ability_special_value -- "example_kv_dynamic_base"
	local special_level = keys.ability_special_level -- Ability Level (0 indexed iirc)

	local hero_level = self:GetParent():GetLevel() - 1

    local ability_name = ability:GetAbilityName()

    local base_value = keys.ability:GetLevelSpecialValueNoOverride(special_value, special_level)
    local value_per_level = keys.ability:GetLevelSpecialValueNoOverride("example_kv_dynamic_change_per_level", special_level)

	print(base_value, value_per_level, hero_level)
	print(base_value + value_per_level * hero_level)

	return base_value + value_per_level * hero_level
end
