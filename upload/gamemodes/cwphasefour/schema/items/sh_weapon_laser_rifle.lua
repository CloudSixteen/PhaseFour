--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemLPR207X";
ITEM.uniqueID = "lpr_207x";
ITEM.cost = 7000;
ITEM.model = "models/weapons/w_rif_famas.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.weaponClass = "cw_laserrifle";
ITEM.description = "ItemLPR207XDesc";
ITEM.isAttachment = true;
ITEM.hasFlashlight = true;
ITEM.loweredAngles = Angle(0, 50, -30);

ITEM.loweredOrigin = Vector(0, 0, -6);

ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();