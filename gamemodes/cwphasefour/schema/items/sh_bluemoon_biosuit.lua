--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 2750;
ITEM.name = "ItemBluemoonBiosuit";
ITEM.uniqueID = "bluemoon_biosuit";
ITEM.weight = 2;
ITEM.business = true;
ITEM.armorScale = 0.225;
ITEM.replacement = "models/bio_suit/slow_bio_suit.mdl";
ITEM.description = "ItemBluemoonBiosuitDesc";
ITEM.tearGasProtection = true;

ITEM:Register();