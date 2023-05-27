LinkLuaModifier("modifier_item_sabaton_intellect", "items/sabaton_intellect", LUA_MODIFIER_MOTION_NONE)

item_sabaton_intellect = item_sabaton_intellect or {}

function item_sabaton_intellect:GetIntrinsicModifierName() return "modifier_item_sabaton_intellect" end

--============================================================================--

modifier_item_sabaton_intellect = modifier_item_sabaton_intellect or {}

modifier_item_sabaton_intellect.IsHidden 		= TRUE
modifier_item_sabaton_intellect.IsPurgable 		= FALSE
modifier_item_sabaton_intellect.IsDebuff 		= FALSE
modifier_item_sabaton_intellect.GetAttributes 	= function() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_sabaton_intellect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_sabaton_intellect:OnCreated() DECLARE_FUNCTIONS(self) end
