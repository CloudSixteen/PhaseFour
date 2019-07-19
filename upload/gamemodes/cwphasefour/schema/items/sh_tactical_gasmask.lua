--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 2000;
ITEM.name = "ItemTacticalGasmask";
ITEM.uniqueID = "tactical_gasmask";
ITEM.weight = 1.5;
ITEM.business = true;
ITEM.armorScale = 0.15;
ITEM.replacement = "models/tactical_rebel.mdl";
ITEM.description = "ItemTacticalGasmaskDesc";
ITEM.tearGasProtection = true;

ITEM:Register();