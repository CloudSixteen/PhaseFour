--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemUMP9";
ITEM.uniqueID = "ump9";
ITEM.cost = 3750;
ITEM.model = "models/weapons/w_smg_ump45.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.weaponClass = "rcs_ump";
ITEM.description = "ItemUMP9Desc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();