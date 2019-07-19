--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemMagnum";
ITEM.uniqueID = "magnum";
ITEM.cost = 2200;
ITEM.model = "models/weapons/w_357.mdl";
ITEM.weight = 1.5;
ITEM.business = true;
ITEM.weaponClass = "rcs_magnum";
ITEM.description = "ItemMagnumDesc";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);

ITEM.loweredAngles = Angle(0, 45, 0);

ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
ITEM.attachmentOffsetAngles = Angle(-180, 180, 90);

ITEM.attachmentOffsetVector = Vector(-4.19, 0, -8.54);

ITEM:Register();