LinkLuaModifier("modifier_item_leapfrog_boots", "items/leapfrog_boots", LUA_MODIFIER_MOTION_BOTH)

item_leapfrog_boots = item_leapfrog_boots or {}

function item_leapfrog_boots:GetIntrinsicModifierName() return "modifier_item_leapfrog_boots" end

function item_leapfrog_boots:OnSpellStart()
	local caster = self:GetCaster()

	caster:Hold()

	local leap_distance = self:GetSpecialValueFor("leap_distance")
	local leap_duration = self:GetSpecialValueFor("leap_duration")
	local leap_height = self:GetSpecialValueFor("leap_height")

	local multiplier = caster:GetAbsOrigin().z == 0 and self:GetSpecialValueFor("leap_river_multiplier") or 1

	leap_distance = leap_distance * multiplier

	local velocity = (leap_distance * caster:GetForwardVector() * FrameTime()) / leap_duration + Vector(0, 0, leap_height * leap_duration)

	local gravity = Vector(0, 0, -leap_height) * FrameTime() / leap_duration

	self.active = true

	local pos = caster:GetAbsOrigin()

	Timers:CreateTimer(0, function()
		if not caster:IsAlive() then
			self.active = false

			return
		end

		print(pos, velocity)

		velocity = velocity + gravity

		pos = pos + velocity

		caster:SetAbsOrigin(pos)

		if pos.z <= GetGroundHeight(pos, caster) then
			self.active = false

			FindClearSpaceForUnit(caster, Vector(pos.x, pos.y, GetGroundHeight(pos, caster)), true)
			ResolveNPCPositions(caster:GetAbsOrigin(), 64)
		else
			return FrameTime()
		end
	end)

	local cooldown = caster:IsRangedAttacker() and self:GetSpecialValueFor("leap_ranged_cooldown") or self:GetCooldownTime()

	self:StartCooldown(cooldown)
end

--============================================================================--

modifier_item_leapfrog_boots = modifier_item_leapfrog_boots or {}

modifier_item_leapfrog_boots.IsHidden 		= TRUE
modifier_item_leapfrog_boots.IsPurgable 	= FALSE
modifier_item_leapfrog_boots.IsDebuff 		= FALSE
modifier_item_leapfrog_boots.GetAttributes = function() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_leapfrog_boots:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE,
	}
end

function modifier_item_leapfrog_boots:OnCreated() DECLARE_FUNCTIONS(self) end

function modifier_item_leapfrog_boots:CheckState()
	return self:GetAbility().active and IsServer() and {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		--[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
	}
end

function modifier_item_leapfrog_boots:IsMotionController() return self:GetAbility().active end
function modifier_item_leapfrog_boots:GetMotionControllerPriority() return DOTA_MOTION_CONTROLLER_PRIORITY_MEDIUM end

