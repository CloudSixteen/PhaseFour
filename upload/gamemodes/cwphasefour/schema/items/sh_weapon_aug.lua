--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemAUG";
ITEM.uniqueID = "aug";
ITEM.cost = 5000;
ITEM.model = "models/weapons/w_rif_aug.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.weaponClass = "rcs_aug";
ITEM.description = "ItemAUGDesc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();