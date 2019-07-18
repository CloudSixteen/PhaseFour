--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemSPAS12";
ITEM.uniqueID = "spas_12";
ITEM.cost = 6200;
ITEM.model = "models/weapons/w_shotgun.mdl";
ITEM.weight = 4;
ITEM.business = true;
ITEM.weaponClass = "rcs_spas12";
ITEM.description = "ItemSPAS12Desc";
ITEM.isAttachment = true;
ITEM.hasFlashlight = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.loweredOrigin = Vector(3, 0, -4);

ITEM.loweredAngles = Angle(0, 45, 0);

ITEM.requiresGunsmith = true;
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();