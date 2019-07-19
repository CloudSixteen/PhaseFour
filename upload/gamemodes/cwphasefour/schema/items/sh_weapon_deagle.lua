--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemDesertEagle";
ITEM.uniqueID = "desert_eagle";
ITEM.cost = 1800;
ITEM.model = "models/weapons/w_pist_deagle.mdl";
ITEM.weight = 1.5;
ITEM.business = true;
ITEM.weaponClass = "rcs_deagle";
ITEM.description = "ItemDesertEagleDesc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
ITEM.attachmentOffsetAngles = Angle(-180, 180, 90);

ITEM.attachmentOffsetVector = Vector(-4.19, 0, -8.54);

ITEM:Register();