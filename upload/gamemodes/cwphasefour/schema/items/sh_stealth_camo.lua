--[[
	� 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "ItemStealthCamo";
ITEM.cost = 6000;
ITEM.model = "models/Items/combine_rifle_cartridge01.mdl";
ITEM.weight = 1;
ITEM.category = "Equipment";
ITEM.uniqueID = "cw_stealthcamo";
ITEM.business = true;
ITEM.isFakeWeapon = true;
ITEM.isMeleeWeapon = true;
ITEM.description = "ItemStealthCamoDesc";
Clockwork.item:Register(ITEM);