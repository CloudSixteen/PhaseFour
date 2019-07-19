--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemM249";
ITEM.uniqueID = "m249";
ITEM.cost = 6500;
ITEM.model = "models/weapons/w_mach_m249para.mdl";
ITEM.weight = 4;
ITEM.business = true;
ITEM.weaponClass = "rcs_m249";
ITEM.description = "ItemM249Desc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.loweredAngles = Angle(-10, 40, -40);

ITEM.requiresGunsmith = true;
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();