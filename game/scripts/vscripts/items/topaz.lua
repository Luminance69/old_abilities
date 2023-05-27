LinkLuaModifier("modifier_item_topaz", "items/topaz", LUA_MODIFIER_MOTION_NONE)

item_topaz = item_topaz or {}

function item_topaz:GetIntrinsicModifierName() return "modifier_item_topaz" end

--============================================================================--

modifier_item_topaz = modifier_item_topaz or {}

modifier_item_topaz.IsHidden 	= TRUE
modifier_item_topaz.IsPurgable 	= FALSE
modifier_item_topaz.IsDebuff 	= FALSE
modifier_item_topaz.GetAttributes = function() return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_topaz:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_item_topaz:OnCreated() DECLARE_FUNCTIONS(self) end
