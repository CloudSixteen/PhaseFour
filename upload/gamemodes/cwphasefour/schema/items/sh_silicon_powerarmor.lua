--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 13000;
ITEM.name = "ItemSiliconPowerarmor";
ITEM.uniqueID = "silicon_powerarmor";
ITEM.weight = 4;
ITEM.business = true;
ITEM.runSound = {
		"npc/metropolice/gear1.wav",
		"npc/metropolice/gear2.wav",
		"npc/metropolice/gear3.wav",
		"npc/metropolice/gear4.wav",
		"npc/metropolice/gear5.wav",
		"npc/metropolice/gear6.wav"
	};
ITEM.armorScale = 0.8;
ITEM.replacement = "models/nailgunner/silc.mdl";
ITEM.description = "ItemSiliconPowerarmorDesc";
ITEM.hasJetpack = true;
ITEM.tearGasProtection = true;
ITEM.requiresArmadillo = true;

ITEM:Register();