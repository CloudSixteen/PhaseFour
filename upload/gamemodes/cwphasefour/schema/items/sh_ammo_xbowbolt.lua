--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "Item57x28mmRounds";
ITEM.cost = 175;
ITEM.model = "models/items/boxzrounds.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "ammo_xbowbolt";
ITEM.business = true;
ITEM.ammoClass = "xbowbolt";
ITEM.ammoAmount = 60;
ITEM.description = "Item57x28mmRoundsDesc";

ITEM:Register();