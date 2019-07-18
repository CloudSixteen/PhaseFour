--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemMAC10";
ITEM.uniqueID = "mac_10";
ITEM.cost = 2400;
ITEM.model = "models/weapons/w_smg_mac10.mdl";
ITEM.weight = 2;
ITEM.business = true;
ITEM.weaponClass = "rcs_mac10";
ITEM.description = "ItemMAC10Desc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
ITEM.attachmentOffsetAngles = Angle(-180, 180, 90);

ITEM.attachmentOffsetVector = Vector(-4.19, 0, -8.54);

ITEM:Register();