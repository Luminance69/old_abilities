FALSE = function() return false end
TRUE = function() return true end

MODIFIER_FUNCTIONS = {
	[MODIFIER_PROPERTY_STATS_STRENGTH_BONUS] 	= {"bonus_strength", 	"GetModifierBonusStats_Strength"},
	[MODIFIER_PROPERTY_STATS_AGILITY_BONUS] 	= {"bonus_agility", 	"GetModifierBonusStats_Agility"},
	[MODIFIER_PROPERTY_STATS_INTELLECT_BONUS]	= {"bonus_intellect", 	"GetModifierBonusStats_Intellect"},

	[MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE] 				= {"bonus_attack_damage", 					"GetModifierPreAttack_BonusDamage"},
	[MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS] 				= {"bonus_armor", 							"GetModifierPhysicalArmorBonus"},
	[MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT] 				= {"bonus_hp_regen", 						"GetModifierConstantHealthRegen"},
	[MODIFIER_PROPERTY_MANA_REGEN_CONSTANT] 				= {"bonus_mp_regen", 						"GetModifierConstantManaRegen"},
	[MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE] 				= {"bonus_movement_speed_boots", 			"GetModifierMoveSpeedBonus_Special_Boots"},
	[MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE] 	= {"bonus_movement_speed_percent_unique", 	"GetModifierMoveSpeedBonus_Percentage_Unique"},
	[MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT] 			= {"bonus_attack_speed", 					"GetModifierAttackSpeedBonus_Constant"},
	[MODIFIER_PROPERTY_STATUS_RESISTANCE] 					= {"bonus_status_resistance", 				"GetModifierStatusResistance"},
	[MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE] 		= {"bonus_hp_regen_amp", 					"GetModifierHPRegenAmplify_Percentage"},
	[MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE]		= {"bonus_lifesteal_amp", 					"GetModifierLifestealRegenAmplify_Percentage"},
	[MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE]			= {"bonus_mp_regen_amp", 					"GetModifierMPRegenAmplify_Percentage"},
	[MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE]	= {"bonus_spell_lifesteal_amp",				"GetModifierSpellLifestealRegenAmplify_Percentage"},
	[MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE]		= {"bonus_spell_amp_unique", 				"GetModifierSpellAmplify_PercentageUnique"},
	[MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING]			= {"bonus_status_resist",	 				"GetModifierStatusResistanceStacking"},
}

function DECLARE_FUNCTIONS(modifier)
	for _, func in pairs(modifier:DeclareFunctions()) do
		local data = MODIFIER_FUNCTIONS[func]

		if data and not modifier[data[2]] then
			modifier[data[1]] = modifier:GetAbility():GetSpecialValueFor(data[1])
			modifier[data[2]] = function() return modifier[data[1]] end
		end
	end
end
