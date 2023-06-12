drow_ranger_trueshot_custom_2 = class({})

LinkLuaModifier("modifier_drow_ranger_trueshot_custom_2", "heroes/drow/trueshot_2", LUA_MODIFIER_MOTION_NONE)

function drow_ranger_trueshot_custom_2:GetIntrinsicModifierName()
	return "modifier_drow_ranger_trueshot_custom_2"
end

function drow_ranger_trueshot_custom_2:Spawn()
	self.aura_search_type = DOTA_UNIT_TARGET_HERO
end

function drow_ranger_trueshot_custom_2:OnToggle()
	if self:GetToggleState() then
		self.aura_search_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	else
		self.aura_search_type = DOTA_UNIT_TARGET_HERO
	end
end

modifier_drow_ranger_trueshot_custom_2 = class({})

function modifier_drow_ranger_trueshot_custom_2:IsDebuff() return false end
function modifier_drow_ranger_trueshot_custom_2:IsHidden() return true end
function modifier_drow_ranger_trueshot_custom_2:IsPurgable() return false end
function modifier_drow_ranger_trueshot_custom_2:RemoveOnDeath() return false end

function modifier_drow_ranger_trueshot_custom_2:IsAura() return true end
function modifier_drow_ranger_trueshot_custom_2:GetAuraRadius() return -1 end
function modifier_drow_ranger_trueshot_custom_2:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_drow_ranger_trueshot_custom_2:GetAuraSearchType() return self:GetAbility().aura_search_type end
function modifier_drow_ranger_trueshot_custom_2:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_drow_ranger_trueshot_custom_2:GetModifierAura() return "modifier_drow_ranger_trueshot_custom_2_effect" end

LinkLuaModifier("modifier_drow_ranger_trueshot_custom_2_effect", "heroes/drow/trueshot_2", LUA_MODIFIER_MOTION_NONE)

modifier_drow_ranger_trueshot_custom_2_effect = class({})

function modifier_drow_ranger_trueshot_custom_2_effect:IsDebuff() return false end
function modifier_drow_ranger_trueshot_custom_2_effect:IsHidden() return not (self:GetAbility():GetLevel() > 0) end

function modifier_drow_ranger_trueshot_custom_2_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_drow_ranger_trueshot_custom_2_effect:GetModifierPreAttack_BonusDamage()
	return self:GetCaster():GetAgility() * self:GetAbility():GetSpecialValueFor("agility_as_damage") / 100
end
