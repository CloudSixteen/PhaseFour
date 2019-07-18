--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemFNP90";
ITEM.uniqueID = "fn_p90";
ITEM.cost = 3500;
ITEM.model = "models/weapons/w_smg_p90.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.weaponClass = "rcs_p90";
ITEM.description = "ItemFNP90Desc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();