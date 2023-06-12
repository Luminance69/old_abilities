--[[
	Technically, this is just a 900 radius thing, since theres no need to make it global for heroes because its just for demonstration
]]

drow_ranger_trueshot_custom_3 = class({})

LinkLuaModifier("modifier_drow_ranger_trueshot_custom_3", "heroes/drow/trueshot_3", LUA_MODIFIER_MOTION_NONE)

function drow_ranger_trueshot_custom_3:GetIntrinsicModifierName()
	return "modifier_drow_ranger_trueshot_custom_3"
end

modifier_drow_ranger_trueshot_custom_3 = class({})

function modifier_drow_ranger_trueshot_custom_3:IsDebuff() return false end
function modifier_drow_ranger_trueshot_custom_3:IsHidden() return true end
function modifier_drow_ranger_trueshot_custom_3:IsPurgable() return false end
function modifier_drow_ranger_trueshot_custom_3:RemoveOnDeath() return false end

function modifier_drow_ranger_trueshot_custom_3:IsAura() return true end
function modifier_drow_ranger_trueshot_custom_3:GetAuraRadius() return 900 end
function modifier_drow_ranger_trueshot_custom_3:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_drow_ranger_trueshot_custom_3:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_drow_ranger_trueshot_custom_3:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_drow_ranger_trueshot_custom_3:GetModifierAura() return "modifier_drow_ranger_trueshot_custom_3_effect" end

LinkLuaModifier("modifier_drow_ranger_trueshot_custom_3_effect", "heroes/drow/trueshot_3", LUA_MODIFIER_MOTION_NONE)

modifier_drow_ranger_trueshot_custom_3_effect = class({})

function modifier_drow_ranger_trueshot_custom_3_effect:IsDebuff() return false end
function modifier_drow_ranger_trueshot_custom_3_effect:IsHidden() return not (self:GetAbility():GetLevel() > 0) end

function modifier_drow_ranger_trueshot_custom_3_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_drow_ranger_trueshot_custom_3_effect:GetModifierPreAttack_BonusDamage()
	return self:GetCaster():GetAgility() * self:GetAbility():GetSpecialValueFor("agility_as_damage") / 100
end
