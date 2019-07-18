--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "Item556x45mmRounds";
ITEM.cost = 210;
ITEM.model = "models/items/boxmrounds.mdl";
ITEM.weight = 2;
ITEM.uniqueID = "ammo_smg1";
ITEM.business = true;
ITEM.ammoClass = "smg1";
ITEM.ammoAmount = 90;
ITEM.description = "Item556x45mmRoundsDesc";

ITEM:Register();