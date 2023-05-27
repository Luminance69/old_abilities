LinkLuaModifier("modifier_item_cruel_stars", "items/cruel_stars", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_cruel_stars_active", "items/cruel_stars", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_cruel_stars_cooldown", "items/cruel_stars", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_cruel_stars_pull", "items/cruel_stars", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_cruel_stars_slow", "items/cruel_stars", LUA_MODIFIER_MOTION_NONE)

item_cruel_stars = item_cruel_stars or {}

item_cruel_stars.ResetToggleOnRespawn = TRUE
item_cruel_stars.GetIntrinsicModifierName = function() return "modifier_item_cruel_stars" end

function item_cruel_stars:OnToggle()
	local caster = self:GetCaster()

	if not caster:HasModifier("modifier_item_cruel_stars_active") then
		caster:EmitSound("DOTA_Item.Armlet.Activate")
		caster:AddNewModifier(caster, self, "modifier_item_cruel_stars_active", {})
	else
		caster:EmitSound("DOTA_Item.Armlet.DeActivate")
		caster:RemoveModifierByName("modifier_item_cruel_stars_active")
	end
end

function item_cruel_stars:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_item_cruel_stars_active") then
		if self:GetCaster() and self:GetCaster():HasModifier("modifier_item_cruel_stars_cooldown") then
			return "799/cruel_stars_cooldown"
		else
			return "799/cruel_stars_active"
		end
	else
		return "799/cruel_stars"
	end
end

--============================================================================--

modifier_item_cruel_stars = modifier_item_cruel_stars or {}

modifier_item_cruel_stars.IsHidden 		= TRUE
modifier_item_cruel_stars.IsPurgable 	= FALSE
modifier_item_cruel_stars.IsDebuff 		= FALSE
modifier_item_cruel_stars.GetAttributes = function() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_cruel_stars:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_item_cruel_stars:OnCreated()
	DECLARE_FUNCTIONS(self)

	self.parent 	= self:GetParent()
	self.ability	= self:GetAbility()
	self.team 		= self.parent:GetTeamNumber()

	self.bonus_attack_speed			= self.ability:GetSpecialValueFor("bonus_attack_speed")

	self.echo_cooldown				= self.ability:GetSpecialValueFor("echo_cooldown")
	self.echo_damage				= self.ability:GetSpecialValueFor("echo_damage")
	self.echo_max_targets			= self.ability:GetSpecialValueFor("echo_max_targets") - 1 -- no i dont know why i need to do this, fuck you
	self.echo_search_radius			= self.ability:GetSpecialValueFor("echo_search_radius")
	self.echo_pull_distance			= self.ability:GetSpecialValueFor("echo_pull_distance")
	self.echo_pull_duration			= self.ability:GetSpecialValueFor("echo_pull_duration")
	self.echo_slow_duration			= self.ability:GetSpecialValueFor("echo_slow_duration")
	self.echo_bonus_attack_speed	= self.ability:GetSpecialValueFor("echo_bonus_attack_speed")
	self.echo_particle				= "particles/econ/events/ti9/maelstorm_ti9.vpcf"
end

function modifier_item_cruel_stars:IsOnCooldown()
	return (not self.parent) or self.parent:HasModifier("modifier_item_cruel_stars_cooldown")
end

function modifier_item_cruel_stars:FindTargets(previous_targets)
	local all_new_targets = {}

	for target, _ in pairs(previous_targets) do
		local new_targets = FindUnitsInRadius(
			self.team,
			target:GetAbsOrigin(),
			nil,
			self.echo_search_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
			FIND_CLOSEST,
			false
		)

		for _, new_target in pairs(new_targets) do
			if #previous_targets + #all_new_targets < self.echo_max_targets then
				if not previous_targets[new_target] then
					table.insert(all_new_targets, new_target)

					new_target:AddNewModifier(self.parent, self.ability, "modifier_item_cruel_stars_slow", {duration = self.echo_slow_duration})
					local modifier = new_target:AddNewModifier(self.parent, self.ability, "modifier_item_cruel_stars_pull", {duration = self.echo_pull_duration, damage = self.echo_damage})

					modifier.destination = new_target:GetAbsOrigin() + (target:GetAbsOrigin() - new_target:GetAbsOrigin()):Normalized() * self.echo_pull_distance

					local particle = ParticleManager:CreateParticle(self.echo_particle, PATTACH_ABSORIGIN_FOLLOW, target)

					ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
					ParticleManager:SetParticleControlEnt(particle, 1, new_target, PATTACH_POINT_FOLLOW, "attach_hitloc", new_target:GetAbsOrigin(), true)
					ParticleManager:SetParticleControl(particle, 2, Vector(1, 1, 1))
					ParticleManager:ReleaseParticleIndex(particle)

					new_target:EmitSound("Hero_Leshrac.Lightning_Storm")
				end
			else
				return
			end
		end
	end

	-- If we made it here then we still need more targets
	for _, new_target in pairs(all_new_targets) do
		if not previous_targets[new_target] then
			previous_targets[new_target] = true
			self:FindTargets(previous_targets)
		end
	end
end

function modifier_item_cruel_stars:GetModifierProcAttack_Feedback(keys)
	if self.parent:IsRangedAttacker() then return end
	if self.parent:IsIllusion() then return end

	if not self:IsOnCooldown() then
		self.next_hit = true
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_cruel_stars_cooldown", {duration = self.echo_cooldown})

		keys.target:AddNewModifier(self.parent, self.ability, "modifier_item_cruel_stars_slow", {duration = self.echo_slow_duration})

		return
	end

	if self.next_hit then
		self.next_hit = false

		if self:GetCaster():HasModifier("modifier_item_cruel_stars_active") then
			if not (keys.target:IsHero() or keys.target:IsCreep()) then return end -- Don't lightning on towers

			self:FindTargets({[keys.target] = true})

			keys.target:AddNewModifier(self.parent, self.ability, "modifier_item_cruel_stars_slow", {duration = self.echo_slow_duration})
			local modifier = keys.target:AddNewModifier(self.parent, self.ability, "modifier_item_cruel_stars_pull", {duration = self.echo_pull_duration, damage = self.echo_damage})

			local pull_distance = math.min((self.parent:GetAbsOrigin() - keys.target:GetAbsOrigin()):Length2D() - 32, self.echo_pull_distance)

			modifier.destination = keys.target:GetAbsOrigin() + (self.parent:GetAbsOrigin() - keys.target:GetAbsOrigin()):Normalized() * pull_distance

			local particle = ParticleManager:CreateParticle(self.echo_particle, PATTACH_ABSORIGIN_FOLLOW, keys.target)

			ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(particle, 1, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), true)
			ParticleManager:SetParticleControl(particle, 2, Vector(1, 1, 1))
			ParticleManager:ReleaseParticleIndex(particle)

			keys.target:EmitSound("Hero_Leshrac.Lightning_Storm")
		end
	end
end

function modifier_item_cruel_stars:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed + (self.next_hit and self.echo_bonus_attack_speed or 0)
end

--============================================================================--

modifier_item_cruel_stars_active = modifier_item_cruel_stars_active or {}

modifier_item_cruel_stars_active.IsHidden 		= FALSE
modifier_item_cruel_stars_active.IsPurgable 	= FALSE
modifier_item_cruel_stars_active.IsDebuff 		= FALSE
modifier_item_cruel_stars_active.GetAttributes 	= function() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
modifier_item_cruel_stars_active.GetEffectName 	= function() return "particles/items_fx/armlet.vpcf" end

function modifier_item_cruel_stars_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_cruel_stars_active:GetTexture()
	return self.ability and self.ability:GetAbilityTextureName()
end

function modifier_item_cruel_stars_active:OnCreated()
	DECLARE_FUNCTIONS(self)

	self.ability = self:GetAbility()

	self.bonus_attack_damage 	= self.ability:GetSpecialValueFor("unholy_bonus_damage")
	self.bonus_armor 			= 0 -- for some reason vanilla armlet works this way, idfk why
	self.dps  					= self:GetParent():IsIllusion() and 0 or self.ability:GetSpecialValueFor("unholy_dps")
	self.tps  					= self.ability:GetSpecialValueFor("unholy_tps")
	self.charge_up_time			= self.ability:GetSpecialValueFor("unholy_charge_up_time")

	self.new_health = self:GetParent():GetHealth()
	self.bonus_strength = 0
	self.strength_to_gain = self.ability:GetSpecialValueFor("unholy_bonus_strength")
	self.dpt = self.dps / self.tps
	self:StartIntervalThink(1 / self.tps)
end

function modifier_item_cruel_stars_active:OnIntervalThink()
	if not self.ability or self.ability:IsNull() or not self:GetParent() or self:GetParent():IsNull() or (IsServer() and not self:GetParent():IsAlive()) then
		self:Destroy()
		return
	end

	local parent = self:GetParent()

	local new_health = parent:GetHealth() - self.dpt

	if self.bonus_strength < self.strength_to_gain then
		local strength = self.strength_to_gain * self.charge_up_time / self.tps

		if self.bonus_strength + strength > self.strength_to_gain then
			strength = self.strength_to_gain - self.bonus_strength

			self.bonus_armor = self.ability:GetSpecialValueFor("unholy_bonus_armor")
		end

		self.bonus_strength = self.bonus_strength + strength

		new_health = new_health + strength * 20

		if IsServer() then
			parent:CalculateStatBonus(true)
		end
	end

	if IsServer() then
		self.new_health = math.max(new_health, 1)
		parent:SetHealth(self.new_health)

		if parent:HasModifier("modifier_item_armlet_unholy_strength") then
			parent:RemoveModifierByName("modifier_item_armlet_unholy_strength")
		end
	end
end

function modifier_item_cruel_stars_active:OnDestroy()
	if IsClient() then return end

	if not self:GetParent() or self:GetParent():IsNull() or not self:GetParent():IsAlive() then
		return
	end

	self:GetParent():SetHealth(math.max(self.new_health - self.bonus_strength * 20, 1))
end

function modifier_item_cruel_stars_active:GetModifierBonusStats_Strength() return self.bonus_strength end

--============================================================================--

modifier_item_cruel_stars_cooldown = modifier_item_cruel_stars_cooldown or {}

modifier_item_cruel_stars_cooldown.IsHidden 		= FALSE
modifier_item_cruel_stars_cooldown.IsPurgable 		= FALSE
modifier_item_cruel_stars_cooldown.IsDebuff 		= TRUE
modifier_item_cruel_stars_cooldown.GetAttributes 	= function() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

--============================================================================--

modifier_item_cruel_stars_slow = modifier_item_cruel_stars_slow or {}

modifier_item_cruel_stars_slow.IsHidden 		= FALSE
modifier_item_cruel_stars_slow.IsPurgable 		= FALSE
modifier_item_cruel_stars_slow.IsDebuff 		= TRUE

function modifier_item_cruel_stars_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_cruel_stars_slow:GetModifierMoveSpeedBonus_Percentage() return -100 end

--============================================================================--

modifier_item_cruel_stars_pull = modifier_item_cruel_stars_pull or {}

modifier_item_cruel_stars_pull.IsHidden 	= FALSE
modifier_item_cruel_stars_pull.IsPurgable 	= TRUE
modifier_item_cruel_stars_pull.IsDebuff 	= TRUE

function modifier_item_cruel_stars_pull:OnCreated(keys)
	if IsClient() then return end

	self.parent = self:GetParent()

	self.damage = keys.damage

	self:StartIntervalThink(FrameTime())
end

function modifier_item_cruel_stars_pull:OnIntervalThink()
	if (not self.parent) or self.parent:IsNull() or (not self.parent:IsAlive()) then
		self:Destroy()
		return
	end

	local position = self.parent:GetAbsOrigin()

	self.movement_vector = self.movement_vector or (self.destination - position) * FrameTime() / self:GetDuration()

	local destination = position + self.movement_vector

	self.parent:SetAbsOrigin(destination)
end

function modifier_item_cruel_stars_pull:OnDestroy()
	if (not self.parent) or self.parent:IsNull() or (not self.parent:IsAlive()) then return end

	FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)

	ApplyDamage({
		victim = self.parent,
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	})
end
