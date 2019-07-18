--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemSledgehammer";
ITEM.uniqueID = "sledgehammer";
ITEM.cost = 400;
ITEM.model = "models/weapons/w_sledgehammer.mdl";
ITEM.weight = 2;
ITEM.business = true;
ITEM.category = "Weapons";
ITEM.weaponClass = "cw_sledgehammer";
ITEM.description = "ItemSledgehammerDesc";
ITEM.isMeleeWeapon = true;
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(-12, 2, 0);

ITEM.loweredAngles = Angle(-25, 15, -80);

ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 255, 0);

ITEM.attachmentOffsetVector = Vector(5, 5, -8);

ITEM:Register();