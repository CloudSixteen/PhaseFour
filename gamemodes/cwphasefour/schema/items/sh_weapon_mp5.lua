--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemMP5";
ITEM.uniqueID = "mp5";
ITEM.cost = 3000;
ITEM.model = "models/weapons/w_smg_mp5.mdl";
ITEM.weight = 2.5;
ITEM.business = true;
ITEM.weaponClass = "rcs_mp5";
ITEM.description = "ItemMP5Desc";
ITEM.isAttachment = true;
ITEM.hasFlashlight = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();