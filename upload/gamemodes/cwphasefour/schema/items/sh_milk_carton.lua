--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemMilkCarton";
ITEM.uniqueID = "milk_carton";
ITEM.cost = 30;
ITEM.model = "models/props_junk/garbage_milkcarton002a.mdl";
ITEM.weight = 0.8;
ITEM.useText = "Drink";
ITEM.category = "Medical"
ITEM.business = true;
ITEM.description = "ItemMilkCartonDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:SetHealth(math.Clamp(player:Health() + 5, 0, 100));
	player:BoostAttribute(self.name, ATB_ENDURANCE, 1, 600);
	player:BoostAttribute(self.name, ATB_STRENGTH, 1, 600);
	
	local stamina = player:GetCharacterData("Stamina");
	
	if (stamina) then
		player:SetCharacterData("Stamina", math.min(stamina + 50, 100));
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();