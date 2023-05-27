-- clearing those modifiers break their abilities
_G.modifier_exceptions = {
	modifier_faceless_void_time_walk_tracker = true,
	modifier_weaver_timelapse = true,

	modifier_ember_spirit_fire_remnant_charge_counter = true,
	modifier_ember_spirit_fire_remnant_thinker = true,
	modifier_ember_spirit_fire_remnant_timer = true,
}

function CDOTABaseAbility:HasBehavior(behavior)
	if not self or self:IsNull() then return end
	local abilityBehavior = tonumber(tostring(self:GetBehaviorInt()))
	return bit.band(abilityBehavior, behavior) == behavior
end

-- remove intrinsic ability modifiers
function CDOTABaseAbility:ClearModifiers()
	if self:GetKeyValue("HasInnateModifiers") ~= 1 then
		for _,v in ipairs(self:GetCaster():FindAllModifiers()) do
			if v:GetAbility() == self then
				if not _G.modifier_exceptions[v:GetName()] then
					v:Destroy()
				end
			end
		end
	end
end


function CDOTABaseAbility:Disable()
	if self:IsChanneling() then
		self:SetChanneling(false)
	end
	if self:GetToggleState() then
		self:ToggleAbility()
	end
	if self:GetAutoCastState() then
		self:ToggleAutoCast()
	end
	self:ClearModifiers()
	self:SetLevel(0)
	self:ClearModifiers()
	self:SetHidden(true)
	self:OnChannelFinish(true)
end


function CDOTABaseAbility:SetRemovalTimer()
	self.removal_timer = Timers:CreateTimer(1, function()
		if self and not self:IsNull() and self.removal_timer then
			if self:NumModifiersUsingAbility() ~= 0 or self:IsChanneling() then return 1 end
			self:ClearModifiers(true)
			self.removal_timer = nil
			self:RemoveSelf()
		end
	end)
end


function CDOTABaseAbility:CancelRemovalTimer()
	if self.removal_timer then
		Timers:RemoveTimer(self.removal_timer)
		self.removal_timer = nil
	end
end
