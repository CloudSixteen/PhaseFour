--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("alcohol_base");

ITEM.name = "ItemBeer";
ITEM.uniqueID = "beer";
ITEM.cost = 30;
ITEM.model = "models/props_junk/garbage_glassbottle003a.mdl";
ITEM.weight = 0.6;
ITEM.business = true;
ITEM.attributes = {Strength = 10};
ITEM.description = "ItemBeerDesc";

-- Called when a player drinks the item.
function ITEM:OnDrink(player)
	PhaseFour.victories:Progress(player, VIC_DRUNKARD);
end;

ITEM:Register();