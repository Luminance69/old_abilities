drow_ranger_marksmanship_custom_3 = class({})

LinkLuaModifier("modifier_drow_ranger_marksmanship_custom_3", "heroes/drow/marksmanship_3", LUA_MODIFIER_MOTION_NONE)

function drow_ranger_marksmanship_custom_3:GetIntrinsicModifierName()
	return "modifier_drow_ranger_marksmanship_custom_3"
end

modifier_drow_ranger_marksmanship_custom_3 = class({})

function modifier_drow_ranger_marksmanship_custom_3:IsDebuff() return false end
function modifier_drow_ranger_marksmanship_custom_3:IsHidden() return self:GetAbility():GetLevel() == 0 end
function modifier_drow_ranger_marksmanship_custom_3:IsPurgable() return false end
function modifier_drow_ranger_marksmanship_custom_3:RemoveOnDeath() return false end

function modifier_drow_ranger_marksmanship_custom_3:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_drow_ranger_marksmanship_custom_3:GetModifierDamageOutgoing_Percentage()
	if not self:GetAbility().splitting then return end

	return -self:GetAbility():GetSpecialValueFor("scepter_split_damage")
end

function modifier_drow_ranger_marksmanship_custom_3:GetModifierBonusStats_Agility()
	local enemies = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("search_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

	local agi = self:GetAbility():GetSpecialValueFor("bonus_agility")

	if #enemies == 0 then
		agi = agi * self:GetAbility():GetSpecialValueFor("agility_multiplier")
	end

	self:SetStackCount(agi)

	return agi
end

function modifier_drow_ranger_marksmanship_custom_3:GetModifierProcAttack_Feedback(keys)
	if not self:GetParent():HasScepter() then return end
	if self:GetAbility().splitting then return end

	local targets = FindUnitsInRadius(self:GetParent():GetTeamNumber(), keys.target:GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("scepter_split_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

	for _, target in pairs(targets) do
		if target ~= keys.target then
			projectile_data = {
				Target = target,
				Source = keys.target,
				Ability = self:GetAbility(),
				bDodgeable = true,
				EffectName = "particles/units/heroes/hero_drow/drow_base_attack.vpcf",
				iMoveSpeed = self:GetParent():GetProjectileSpeed(),
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
			}

			ProjectileManager:CreateTrackingProjectile(projectile_data)
		end
	end
end

function drow_ranger_marksmanship_custom_3:OnProjectileHit(target, location)
	if target then
		self.splitting = true
		self:GetCaster():PerformAttack(target, true, true, true, true, false, false, true)
		self.splitting = false
	end
end
