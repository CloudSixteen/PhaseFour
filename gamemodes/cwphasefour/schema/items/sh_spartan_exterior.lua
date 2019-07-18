--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 4500;
ITEM.name = "ItemSpartanExterior";
ITEM.uniqueID = "spartan_exterior";
ITEM.weight = 3;
ITEM.business = true;
ITEM.armorScale = 0.325;
ITEM.replacement = "models/spex.mdl";
ITEM.description = "ItemSpartanExteriorDesc";

ITEM:Register();