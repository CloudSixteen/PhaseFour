--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemAK47";
ITEM.uniqueID = "ak_47";
ITEM.cost = 4600;
ITEM.model = "models/weapons/w_rif_ak47.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.weaponClass = "rcs_ak47";
ITEM.description = "ItemAK47Desc";
ITEM.isAttachment = true;
ITEM.hasFlashlight = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();