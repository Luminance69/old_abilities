drow_ranger_marksmanship_custom_1 = class({})

LinkLuaModifier("modifier_drow_ranger_marksmanship_custom_1", "heroes/drow/marksmanship_1", LUA_MODIFIER_MOTION_NONE)

function drow_ranger_marksmanship_custom_1:GetIntrinsicModifierName()
	return "modifier_drow_ranger_marksmanship_custom_1"
end

modifier_drow_ranger_marksmanship_custom_1 = class({})

function modifier_drow_ranger_marksmanship_custom_1:IsDebuff() return false end
function modifier_drow_ranger_marksmanship_custom_1:IsHidden() return true end
function modifier_drow_ranger_marksmanship_custom_1:IsPurgable() return false end
function modifier_drow_ranger_marksmanship_custom_1:RemoveOnDeath() return false end

function modifier_drow_ranger_marksmanship_custom_1:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
end

function modifier_drow_ranger_marksmanship_custom_1:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end
