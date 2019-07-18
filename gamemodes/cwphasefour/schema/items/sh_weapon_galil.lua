--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemGalil";
ITEM.uniqueID = "galil";
ITEM.cost = 4000;
ITEM.model = "models/weapons/w_rif_galil.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.weaponClass = "rcs_galil";
ITEM.description = "ItemGalilDesc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();