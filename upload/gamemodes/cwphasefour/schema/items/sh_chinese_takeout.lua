--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemChineseTakeout";
ITEM.uniqueID = "chinese_takeout";
ITEM.cost = 40;
ITEM.model = "models/props_junk/garbage_takeoutcarton001a.mdl";
ITEM.weight = 0.8;
ITEM.useText = "Eat";
ITEM.category = "Medical"
ITEM.business = true;
ITEM.description = "ItemChineseTakeoutDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:SetHealth(math.Clamp(player:Health() + 10, 0, player:GetMaxHealth()));
	player:BoostAttribute(self.name, ATB_ENDURANCE, 2, 600);
	
	local stamina = player:GetCharacterData("Stamina");
	
	if (stamina) then
		player:SetCharacterData("Stamina", math.min(stamina + 50, 100));
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();