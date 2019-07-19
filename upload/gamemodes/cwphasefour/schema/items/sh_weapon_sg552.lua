--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemSG552";
ITEM.uniqueID = "sg_552";
ITEM.cost = 5400;
ITEM.model = "models/weapons/w_rif_sg552.mdl";
ITEM.weight = 4;
ITEM.business = true;
ITEM.weaponClass = "rcs_sg552";
ITEM.description = "ItemSG552Desc";
ITEM.isAttachment = true;
ITEM.hasFlashlight = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.requiresGunsmith = true;
ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();