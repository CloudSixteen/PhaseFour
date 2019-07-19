--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 1000;
ITEM.name = "ItemCombatUniform";
ITEM.uniqueID = "combat_uniform";
ITEM.group = "group03";
ITEM.weight = 1;
ITEM.business = true;
ITEM.armorScale = 0.1;
ITEM.description = "ItemCombatUniformDesc";

ITEM:Register();