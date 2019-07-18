--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New("AttributeDexterity");

ATTRIBUTE.maximum = 100;
ATTRIBUTE.uniqueID = "dex";
ATTRIBUTE.description = "AttributeDexterityDesc";
ATTRIBUTE.characterScreen = true;

ATB_DEXTERITY = ATTRIBUTE:Register();