--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New("AttributeStrength");

ATTRIBUTE.maximum = 100;
ATTRIBUTE.uniqueID = "str";
ATTRIBUTE.description = "AttributeStrengthDesc";
ATTRIBUTE.characterScreen = true;

ATB_STRENGTH = ATTRIBUTE:Register();