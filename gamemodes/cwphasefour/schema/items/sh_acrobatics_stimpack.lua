--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemAcrobaticsStimpack";
ITEM.uniqueID = "acrobatics_stimpack";
ITEM.cost = 1750;
ITEM.model = "models/props_c17/trappropeller_lever.mdl";
ITEM.weight = 1;
ITEM.useText = "Inject";
ITEM.category = "Enhancers"
ITEM.business = true;
ITEM.description = "ItemAcrobaticsStimpackDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:UpdateAttribute(ATB_ACROBATICS, 10);
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;
	
ITEM:Register();