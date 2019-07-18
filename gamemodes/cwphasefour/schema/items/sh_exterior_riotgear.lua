--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 4000;
ITEM.name = "ItemExteriorRiotgear";
ITEM.uniqueID = "exterior_riotgear";
ITEM.weight = 2.5;
ITEM.business = true;
ITEM.armorScale = 0.3;
ITEM.replacement = "models/riot_ex2.mdl";
ITEM.description = "ItemExteriorRiotgearDesc";

ITEM:Register();