modifier_fountain_offence_aura = class({})
LinkLuaModifier("modifier_fountain_offence_aura_effect", "game/modifiers/modifier_fountain_offence_aura", LUA_MODIFIER_MOTION_NONE)

function modifier_fountain_offence_aura:GetPriority() return MODIFIER_PRIORITY_SUPER_ULTRA end

function modifier_fountain_offence_aura:IsAura() return true end
function modifier_fountain_offence_aura:IsHidden() return true end
function modifier_fountain_offence_aura:IsDebuff() return false end
function modifier_fountain_offence_aura:IsPurgable() return false end
function modifier_fountain_offence_aura:RemoveOnDeath() return true end
function modifier_fountain_offence_aura:GetModifierAura() return "modifier_fountain_offence_aura_effect" end
function modifier_fountain_offence_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_fountain_offence_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_fountain_offence_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES  end

function modifier_fountain_offence_aura:GetAuraRadius() return 1500 end

function modifier_fountain_offence_aura:OnCreated()
	if not IsServer() then return end
	self.parent = self:GetParent()

	if not self.parent or self.parent:IsNull() then return end
	if not self.parent:HasAbility("ursa_fury_swipes") then
		local added_ability = self.parent:AddAbility("ursa_fury_swipes")
		added_ability:SetLevel(4)
	end
end


function modifier_fountain_offence_aura:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true
	}
end


modifier_fountain_offence_aura_effect = class({})

function modifier_fountain_offence_aura_effect:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_BLIND] = true,
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
		[MODIFIER_STATE_CANNOT_TARGET_ENEMIES] = true,
	}
end

function modifier_fountain_offence_aura_effect:GetTexture()
	return "doom_bringer_doom"
end

function modifier_fountain_offence_aura_effect:GetEffectName()
	return "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf"
end

function modifier_fountain_offence_aura_effect:OnCreated()
	if not IsServer() then return end

	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end

	parent:EmitSound("Hero_DoomBringer.Doom")
end

function modifier_fountain_offence_aura_effect:OnDestroy()
	if not IsServer() then return end

	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end

	parent:StopSound("Hero_DoomBringer.Doom")
end
