
--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 5000;
ITEM.name = "ItemDuplexanExterior";
ITEM.uniqueID = "duplexan_exterior";
ITEM.weight = 3;
ITEM.business = true;
ITEM.armorScale = 0.375;
ITEM.replacement = "models/spx7.mdl";
ITEM.description = "ItemDuplexanExteriorDesc";

ITEM:Register();