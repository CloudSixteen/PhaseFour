--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 3500;
ITEM.name = "ItemBluemercArmor";
ITEM.uniqueID = "bluemerc_armor";
ITEM.weight = 2;
ITEM.business = true;
ITEM.armorScale = 0.275;
ITEM.replacement = "models/salem/blue.mdl";
ITEM.description = "ItemBluemercArmorDesc";
ITEM.tearGasProtection = true;

ITEM:Register();