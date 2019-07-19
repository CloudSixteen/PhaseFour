--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemSinnerTome";
ITEM.cost = 200;
ITEM.model = "models/props_lab/binderredlabel.mdl";
ITEM.batch = 1;
ITEM.weight = 0.5;
ITEM.useText = "Read";
ITEM.uniqueID = "sinners_tome";
ITEM.category = "Enhancers"
ITEM.business = true;
ITEM.description = "ItemSinnerTomeDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:HandleHonor(-10);
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();