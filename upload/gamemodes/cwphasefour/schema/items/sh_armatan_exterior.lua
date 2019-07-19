--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 4750;
ITEM.name = "ItemArmatanExterior";
ITEM.uniqueID = "armatan_exterior";
ITEM.weight = 3;
ITEM.business = true;
ITEM.armorScale = 0.35;
ITEM.replacement = "models/spx2.mdl";
ITEM.description = "ItemArmatanExteriorDesc";

ITEM:Register();