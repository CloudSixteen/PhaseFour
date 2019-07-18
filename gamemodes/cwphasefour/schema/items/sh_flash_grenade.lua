--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("grenade_base");

ITEM.name = "ItemFlashGrenade";
ITEM.cost = 150;
ITEM.model = "models/items/grenadeammo.mdl";
ITEM.weight = 0.8;
ITEM.uniqueID = "cw_flashgrenade";
ITEM.business = true;
ITEM.description = "ItemFlashGrenadeDesc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
ITEM.requiresExplosives = true;
ITEM.attachmentOffsetAngles = Angle(90, 180, 0);

ITEM.attachmentOffsetVector = Vector(0, 6.55, 8.72);

ITEM:Register();