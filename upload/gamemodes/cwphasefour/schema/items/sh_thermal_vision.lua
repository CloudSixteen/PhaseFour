--[[
	� 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "ItemThermalVision";
ITEM.cost = 4000;
ITEM.model = "models/props_lab/tpplug.mdl";
ITEM.weight = 1;
ITEM.category = "Equipment";
ITEM.uniqueID = "cw_thermalvision";
ITEM.business = true;
ITEM.isFakeWeapon = true;
ITEM.isMeleeWeapon = true;
ITEM.description = "ItemThermalVisionDesc";
Clockwork.item:Register(ITEM);