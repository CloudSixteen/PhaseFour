--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "Item9x19mmRounds";
ITEM.cost = 150;
ITEM.model = "models/items/boxsrounds.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "ammo_pistol";
ITEM.business = true;
ITEM.ammoClass = "pistol";
ITEM.ammoAmount = 60;
ITEM.description = "Item9x19mmRoundsDesc";

ITEM:Register();