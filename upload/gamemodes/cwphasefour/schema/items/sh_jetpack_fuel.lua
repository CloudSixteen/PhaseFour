--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemJetpackFuel";
ITEM.uniqueID = "jetpack_fuel";
ITEM.cost = 300;
ITEM.model = "models/props_junk/gascan001a.mdl";
ITEM.weight = 1;
ITEM.useText = "Refuel";
ITEM.business = true;
ITEM.category = "Consumables";
ITEM.description = "ItemJetpackFuelDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:SetCharacterData("fuel", 100);
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();