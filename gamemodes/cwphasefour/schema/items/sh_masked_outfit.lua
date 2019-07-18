--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 1500;
ITEM.name = "ItemMaskedOutfit";
ITEM.uniqueID = "masked_outfit";
ITEM.weight = 1;
ITEM.business = true;
ITEM.armorScale = 0.125;
ITEM.replacement = "models/humans/group03/male_experim.mdl";
ITEM.description = "ItemMaskedOutfitDesc";

ITEM:Register();