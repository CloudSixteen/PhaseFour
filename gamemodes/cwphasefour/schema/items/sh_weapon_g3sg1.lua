--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemG3SG1";
ITEM.uniqueID = "g3sg1";
ITEM.cost = 7600;
ITEM.model = "models/weapons/w_snip_g3sg1.mdl";
ITEM.weight = 4;
ITEM.business = true;
ITEM.weaponClass = "rcs_g3sg1";
ITEM.description = "ItemG3SG1Desc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.requiresGunsmith = true;
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);

ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();