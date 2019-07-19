--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New("AttributeEndurance");

ATTRIBUTE.maximum = 100;
ATTRIBUTE.uniqueID = "end";
ATTRIBUTE.description = "AttributeEnduranceDesc";
ATTRIBUTE.characterScreen = true;

ATB_ENDURANCE = ATTRIBUTE:Register();