--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemSaintTome";
ITEM.cost = 250;
ITEM.model = "models/props_lab/binderbluelabel.mdl";
ITEM.batch = 1;
ITEM.weight = 0.5;
ITEM.useText = "Read";
ITEM.category = "Enhancers"
ITEM.uniqueID = "saints_tome";
ITEM.business = true;
ITEM.description = "ItemSaintTomeDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:HandleHonor(10);
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();