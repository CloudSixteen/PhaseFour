--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_weapon");

ITEM.name = "ItemShovel";
ITEM.uniqueID = "shovel";
ITEM.cost = 300;
ITEM.model = "models/weapons/w_shovel.mdl";
ITEM.weight = 1.5;
ITEM.business = true;
ITEM.category = "Weapons";
ITEM.weaponClass = "cw_shovel";
ITEM.description = "ItemShovelDesc";
ITEM.isMeleeWeapon = true;
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(-12, 2, 0);

ITEM.loweredAngles = Angle(-25, 15, -80);

ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 255, 0);

ITEM.attachmentOffsetVector = Vector(5, 5, -8);

ITEM:Register();