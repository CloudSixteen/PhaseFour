--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemM3Super90";
ITEM.uniqueID = "m3_super_90";
ITEM.cost = 5800;
ITEM.model = "models/weapons/w_shot_m3super90.mdl";
ITEM.weight = 4;
ITEM.business = true;
ITEM.weaponClass = "rcs_m3";
ITEM.description = "ItemM3Super90Desc";
ITEM.isAttachment = true;
ITEM.hasFlashlight = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.requiresGunsmith = true;
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();