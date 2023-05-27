LinkLuaModifier("modifier_item_sabaton_strength", "items/sabaton_strength", LUA_MODIFIER_MOTION_NONE)

item_sabaton_strength = item_sabaton_strength or {}

function item_sabaton_strength:GetIntrinsicModifierName() return "modifier_item_sabaton_strength" end

--============================================================================--

modifier_item_sabaton_strength = modifier_item_sabaton_strength or {}

modifier_item_sabaton_strength.IsHidden 		= TRUE
modifier_item_sabaton_strength.IsPurgable 		= FALSE
modifier_item_sabaton_strength.IsDebuff 		= FALSE
modifier_item_sabaton_strength.GetAttributes 	= function() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_sabaton_strength:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATUS_RESISTANCE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_sabaton_strength:OnCreated() DECLARE_FUNCTIONS(self) end
