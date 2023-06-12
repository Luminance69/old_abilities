drow_ranger_marksmanship_custom_2 = class({})

LinkLuaModifier("modifier_drow_ranger_marksmanship_custom_2", "heroes/drow/marksmanship_2", LUA_MODIFIER_MOTION_NONE)

function drow_ranger_marksmanship_custom_2:GetIntrinsicModifierName()
	return "modifier_drow_ranger_marksmanship_custom_2"
end

modifier_drow_ranger_marksmanship_custom_2 = class({})

function modifier_drow_ranger_marksmanship_custom_2:IsDebuff() return false end
function modifier_drow_ranger_marksmanship_custom_2:IsHidden() return self:GetAbility():GetLevel() == 0 end
function modifier_drow_ranger_marksmanship_custom_2:IsPurgable() return false end
function modifier_drow_ranger_marksmanship_custom_2:RemoveOnDeath() return false end

function modifier_drow_ranger_marksmanship_custom_2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
end

function modifier_drow_ranger_marksmanship_custom_2:GetModifierBonusStats_Agility()
	local enemies = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("search_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

	local agi = self:GetAbility():GetSpecialValueFor("bonus_agility")

	if #enemies == 0 then
		agi = agi * self:GetAbility():GetSpecialValueFor("agility_multiplier")
	end

	self:SetStackCount(agi)

	return agi
end
