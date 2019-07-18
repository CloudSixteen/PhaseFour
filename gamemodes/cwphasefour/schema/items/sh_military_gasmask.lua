--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 2500;
ITEM.name = "ItemMilitaryGasmask";
ITEM.uniqueID = "military_gasmask";
ITEM.weight = 2;
ITEM.business = true;
ITEM.armorScale = 0.2;
ITEM.replacement = "models/pmc/pmc_4/pmc__07.mdl";
ITEM.description = "ItemMilitaryGasmaskDesc";
ITEM.tearGasProtection = true;

ITEM:Register();