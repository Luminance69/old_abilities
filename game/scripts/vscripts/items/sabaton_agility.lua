LinkLuaModifier("modifier_item_sabaton_agility", "items/sabaton_agility", LUA_MODIFIER_MOTION_NONE)

item_sabaton_agility = item_sabaton_agility or {}

function item_sabaton_agility:GetIntrinsicModifierName() return "modifier_item_sabaton_agility" end

--============================================================================--

modifier_item_sabaton_agility = modifier_item_sabaton_agility or {}

modifier_item_sabaton_agility.IsHidden 		= TRUE
modifier_item_sabaton_agility.IsPurgable 	= FALSE
modifier_item_sabaton_agility.IsDebuff 		= FALSE
modifier_item_sabaton_agility.GetAttributes = function() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_sabaton_agility:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE,
	}
end

function modifier_item_sabaton_agility:OnCreated() DECLARE_FUNCTIONS(self) end
