
--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("custom_clothes");

ITEM.cost = 7000;
ITEM.name = "ItemBluemercGasmask";
ITEM.uniqueID = "bluemerc_gasmask";
ITEM.weight = 3;
ITEM.business = true;
ITEM.runSound = {
		"npc/metropolice/gear1.wav",
		"npc/metropolice/gear2.wav",
		"npc/metropolice/gear3.wav",
		"npc/metropolice/gear4.wav",
		"npc/metropolice/gear5.wav",
		"npc/metropolice/gear6.wav"
	};
ITEM.armorScale = 0.425;
ITEM.replacement = "models/napalm_atc/blue.mdl";
ITEM.description = "ItemBluemercGasmaskDesc";
ITEM.hasJetpack = true;
ITEM.tearGasProtection = true;
ITEM.requiresArmadillo = true;

ITEM:Register();