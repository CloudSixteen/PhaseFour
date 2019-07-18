--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemEngineeringStimpack";
ITEM.uniqueID = "engineering_stimpack";
ITEM.cost = 1250;
ITEM.model = "models/props_c17/trappropeller_lever.mdl";
ITEM.batch = 1;
ITEM.weight = 1;
ITEM.useText = "Inject";
ITEM.category = "Enhancers"
ITEM.business = true;
ITEM.description = "ItemEngineeringStimpackDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:UpdateAttribute(ATB_ENGINEERING, 1);
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();