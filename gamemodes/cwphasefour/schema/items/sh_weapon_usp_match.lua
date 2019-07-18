--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemUSPM";
ITEM.uniqueID = "usp_m";
ITEM.cost = 1400;
ITEM.model = "models/weapons/w_pistol.mdl";
ITEM.weight = 1.5;
ITEM.business = true;
ITEM.weaponClass = "rcs_uspmatch";
ITEM.description = "ItemUSPMDesc";
ITEM.isAttachment = true;
ITEM.hasFlashlight = true;
ITEM.loweredOrigin = Vector(5, -4, -3);

ITEM.loweredAngles = Angle(0, 45, 0);

ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
ITEM.attachmentOffsetAngles = Angle(0, 0, 90);

ITEM.attachmentOffsetVector = Vector(0, 4, -8);

ITEM:Register();