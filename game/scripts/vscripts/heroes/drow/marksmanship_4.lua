drow_ranger_marksmanship_custom_4 = class({})

LinkLuaModifier("modifier_drow_ranger_marksmanship_custom_4", "heroes/drow/marksmanship_4", LUA_MODIFIER_MOTION_NONE)

function drow_ranger_marksmanship_custom_4:GetIntrinsicModifierName()
	return "modifier_drow_ranger_marksmanship_custom_4"
end

function drow_ranger_marksmanship_custom_4:OnProjectileHit(target, location)
	if target then
		self.splitting = true
		self:GetCaster():PerformAttack(target, true, true, true, true, false, false, true)
		self.splitting = false
	end
end

modifier_drow_ranger_marksmanship_custom_4 = class({})

function modifier_drow_ranger_marksmanship_custom_4:IsDebuff() return false end
function modifier_drow_ranger_marksmanship_custom_4:IsHidden() return self:GetAbility():GetLevel() == 0 end
function modifier_drow_ranger_marksmanship_custom_4:IsPurgable() return false end
function modifier_drow_ranger_marksmanship_custom_4:RemoveOnDeath() return false end

function modifier_drow_ranger_marksmanship_custom_4:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
	}
end

function modifier_drow_ranger_marksmanship_custom_4:OnCreated()
	self.records = {}
end

function modifier_drow_ranger_marksmanship_custom_4:GetModifierDamageOutgoing_Percentage()
	if not self:GetAbility().splitting then return end

	return -self:GetAbility():GetSpecialValueFor("scepter_split_damage")
end

function modifier_drow_ranger_marksmanship_custom_4:GetModifierProcAttack_Feedback(keys)
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

function modifier_drow_ranger_marksmanship_custom_4:OnAttackRecord(keys)
	if self:GetAbility().splitting then return end

	-- Setting attack projectile doesnt work on this attack, so we do everything 1 attack in advance
	if self.proc_next_hit then
		self.records[keys.record] = true
	end

	if RollPseudoRandomPercentage(self:GetAbility():GetSpecialValueFor("proc_chance"), DOTA_PSEUDO_RANDOM_DROW_MARKSMANSHIP, self:GetParent()) then
		self.proc_next_hit = true

		self:GetParent():SetRangedProjectileName("particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf")
	else
		self.proc_next_hit = false

		self:GetParent():SetRangedProjectileName("particles/units/heroes/hero_drow/drow_base_attack.vpcf")
	end
end

function modifier_drow_ranger_marksmanship_custom_4:OnAttackRecordDestroy(keys)
	if self.records[keys.record] then
		self.records[keys.record] = nil
	end
end

function modifier_drow_ranger_marksmanship_custom_4:OnAttack(keys)
	if not IsServer() then return end

	if self.records[keys.record] then
		self:GetParent():SetRangedProjectileName("particles/units/heroes/hero_drow/drow_base_attack.vpcf")
	end
end

function modifier_drow_ranger_marksmanship_custom_4:GetModifierProcAttack_BonusDamage_Physical(keys)
	if self.records[keys.record] then
		if keys.target:IsCreep() or keys.target:IsAncient() then
			keys.target:Kill(self:GetAbility(), self:GetParent())
		end
		keys.target:AddNewModifier(self:GetAbility(), self:GetParent(), "modifier_drow_ranger_marksmanship_custom_4_debuff", {duration = FrameTime()})

		return 0
	end
end

LinkLuaModifier("modifier_drow_ranger_marksmanship_custom_4_debuff", "heroes/drow/marksmanship_4", LUA_MODIFIER_MOTION_NONE)

modifier_drow_ranger_marksmanship_custom_4_debuff = class({})

function modifier_drow_ranger_marksmanship_custom_4_debuff:IsDebuff() return true end
function modifier_drow_ranger_marksmanship_custom_4_debuff:IsHidden() return true end

function modifier_drow_ranger_marksmanship_custom_4_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_drow_ranger_marksmanship_custom_4_debuff:GetModifierPhysicalArmorBonus()
	return self:GetParent():GetPhysicalArmorValue(false) * -1
end
