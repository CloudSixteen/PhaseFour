--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "Item765x59mmRounds";
ITEM.cost = 250;
ITEM.model = "models/items/redammo.mdl";
ITEM.weight = 2;
ITEM.uniqueID = "ammo_sniper";
ITEM.business = true;
ITEM.ammoClass = "ar2";
ITEM.ammoAmount = 30;
ITEM.description = "Item765x59mmRoundsDesc";
ITEM.requiresGunsmith = true;

ITEM:Register();