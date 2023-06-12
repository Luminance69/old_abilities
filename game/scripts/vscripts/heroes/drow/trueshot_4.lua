--[[
	Technically, this is just a 900 radius thing, since theres no need to make it global for heroes because its just for demonstration
]]

drow_ranger_trueshot_custom_4 = class({})

LinkLuaModifier("modifier_drow_ranger_trueshot_custom_4", "heroes/drow/trueshot_4", LUA_MODIFIER_MOTION_NONE)

function drow_ranger_trueshot_custom_4:GetIntrinsicModifierName()
	return "modifier_drow_ranger_trueshot_custom_4"
end

modifier_drow_ranger_trueshot_custom_4 = class({})

function modifier_drow_ranger_trueshot_custom_4:IsDebuff() return false end
function modifier_drow_ranger_trueshot_custom_4:IsHidden() return true end
function modifier_drow_ranger_trueshot_custom_4:IsPurgable() return false end
function modifier_drow_ranger_trueshot_custom_4:RemoveOnDeath() return false end

function modifier_drow_ranger_trueshot_custom_4:IsAura() return true end
function modifier_drow_ranger_trueshot_custom_4:GetAuraRadius() return 900 end
function modifier_drow_ranger_trueshot_custom_4:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_drow_ranger_trueshot_custom_4:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_drow_ranger_trueshot_custom_4:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_drow_ranger_trueshot_custom_4:GetModifierAura() return "modifier_drow_ranger_trueshot_custom_4_effect" end

LinkLuaModifier("modifier_drow_ranger_trueshot_custom_4_effect", "heroes/drow/trueshot_4", LUA_MODIFIER_MOTION_NONE)

modifier_drow_ranger_trueshot_custom_4_effect = class({})

function modifier_drow_ranger_trueshot_custom_4_effect:IsDebuff() return false end
function modifier_drow_ranger_trueshot_custom_4_effect:IsHidden() return not (self:GetAbility():GetLevel() > 0) end

function modifier_drow_ranger_trueshot_custom_4_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_drow_ranger_trueshot_custom_4_effect:GetModifierAttackSpeedBonus_Constant()
	return self:GetCaster():GetAgility() * self:GetAbility():GetSpecialValueFor("agility_as_attack_speed") / 100
end
