--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemMilkJugs";
ITEM.uniqueID = "milk_jugs";
ITEM.cost = 40;
ITEM.model = "models/props_junk/garbage_milkcarton001a.mdl";
ITEM.weight = 1;
ITEM.useText = "Drink";
ITEM.category = "Medical"
ITEM.business = true;
ITEM.description = "ItemMilkJugsDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:SetHealth(math.Clamp(player:Health() + 10, 0, 100));
	player:BoostAttribute(self.name, ATB_ENDURANCE, 2, 600);
	player:BoostAttribute(self.name, ATB_STRENGTH, 2, 600);
	
	local stamina = player:GetCharacterData("Stamina");
	
	if (stamina) then
		player:SetCharacterData("Stamina", math.min(stamina + 50, 100));
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();