modifier_courier_speed_bonus = class({})


function modifier_courier_speed_bonus:IsHidden() return true end
function modifier_courier_speed_bonus:IsPurgable() return false end
function modifier_courier_speed_bonus:RemoveOnDeath() return false end
function modifier_courier_speed_bonus:DestroyOnExpire() return false end
function modifier_courier_speed_bonus:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_courier_speed_bonus:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_courier_speed_bonus:GetModifierMoveSpeedBonus_Percentage()
	return 100
end
