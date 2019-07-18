--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 1000;
ITEM.name = "ItemMedicUniform";
ITEM.uniqueID = "medic_uniform";
ITEM.group = "group03m";
ITEM.weight = 1;
ITEM.business = true;
ITEM.armorScale = 0.1;
ITEM.description = "ItemMedicUniformDesc";

ITEM:Register();