--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "ItemX369mm";
ITEM.uniqueID = "x36_9mm";
ITEM.cost = 240;
ITEM.model = "models/items/combine_rifle_ammo01.mdl";
ITEM.weight = 1;
ITEM.business = true;
ITEM.ammoClass = "ar2altfire";
ITEM.ammoAmount = 90;
ITEM.description = "ItemX369mmDesc";
ITEM.requiresGunsmith = true;

ITEM:Register();