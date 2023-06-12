drow_ranger_trueshot_custom_1 = class({})

LinkLuaModifier("modifier_drow_ranger_trueshot_custom_1", "heroes/drow/trueshot_1", LUA_MODIFIER_MOTION_NONE)

function drow_ranger_trueshot_custom_1:GetIntrinsicModifierName()
	return "modifier_drow_ranger_trueshot_custom_1"
end

modifier_drow_ranger_trueshot_custom_1 = class({})

function modifier_drow_ranger_trueshot_custom_1:IsDebuff() return false end
function modifier_drow_ranger_trueshot_custom_1:IsHidden() return true end
function modifier_drow_ranger_trueshot_custom_1:IsPurgable() return false end
function modifier_drow_ranger_trueshot_custom_1:RemoveOnDeath() return false end

function modifier_drow_ranger_trueshot_custom_1:IsAura() return true end
function modifier_drow_ranger_trueshot_custom_1:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_drow_ranger_trueshot_custom_1:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_drow_ranger_trueshot_custom_1:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_drow_ranger_trueshot_custom_1:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_drow_ranger_trueshot_custom_1:GetModifierAura() return "modifier_drow_ranger_trueshot_custom_1_effect" end

LinkLuaModifier("modifier_drow_ranger_trueshot_custom_1_effect", "heroes/drow/trueshot_1", LUA_MODIFIER_MOTION_NONE)

modifier_drow_ranger_trueshot_custom_1_effect = class({})

function modifier_drow_ranger_trueshot_custom_1_effect:IsDebuff() return false end
function modifier_drow_ranger_trueshot_custom_1_effect:IsHidden() return false end

function modifier_drow_ranger_trueshot_custom_1_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_drow_ranger_trueshot_custom_1_effect:GetModifierDamageOutgoing_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end
