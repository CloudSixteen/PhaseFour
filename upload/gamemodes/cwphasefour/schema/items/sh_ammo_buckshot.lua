--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "ItemShotgunShells";
ITEM.cost = 210;
ITEM.model = "models/items/boxbuckshot.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "ammo_buckshot";
ITEM.business = true;
ITEM.ammoClass = "buckshot";
ITEM.ammoAmount = 40;
ITEM.description = "ItemShotgunShellsDesc";
ITEM.requiresGunsmith = true;

ITEM:Register();