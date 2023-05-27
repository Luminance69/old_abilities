modifier_roshan_devotion_aura_omg = modifier_roshan_devotion_aura_omg or class({})

function modifier_roshan_devotion_aura_omg:IsHidden() return true end
function modifier_roshan_devotion_aura_omg:IsDebuff() return false end
function modifier_roshan_devotion_aura_omg:IsPurgable() return false end
function modifier_roshan_devotion_aura_omg:IsPermanent() return true end

function modifier_roshan_devotion_aura_omg:OnCreated()
	self.parent = self:GetParent()
	
	if IsServer() then self.parent:RemoveModifierByName("modifier_roshan_inherent_buffs") end

	local time = GameRules:GetDOTATime(false, true)

	if time < 0 then
		self:StartIntervalThink(abs(time)) -- start thinking at game start
	else
		self:UpdateStats() -- calculate stats on respawn

		self:StartIntervalThink(60 - GameRules:GetDOTATime(false, false) % 60) -- start thinking at next minute mark
	end
end

function modifier_roshan_devotion_aura_omg:OnIntervalThink()
	self:StartIntervalThink(60) -- think every minute from now on

	self:UpdateStats()
end

function modifier_roshan_devotion_aura_omg:UpdateStats()
	local time = math.floor(GameRules:GetDOTATime(false, false))
	self.armor = 0.375 * time / 60 + 0.375
	self.damage = 12 * time / 60

	self.health = 230 * time / 60

	if IsServer() then
		local hp = self.parent:GetHealthPercent()
		self.parent:SetMaxHealth(6000 + self.health)
		self.parent:SetBaseMaxHealth(6000 + self.health)
		self.parent:SetHealth(hp * (6000 + self.health) * 0.01)
	end
end

function modifier_roshan_devotion_aura_omg:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, -- GetModifierPhysicalArmorBonus
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, -- GetModifierPreAttack_BonusDamage
	}
end

function modifier_roshan_devotion_aura_omg:GetModifierPhysicalArmorBonus() return self.armor or 0 end
function modifier_roshan_devotion_aura_omg:GetModifierPreAttack_BonusDamage() return self.damage or 0 end