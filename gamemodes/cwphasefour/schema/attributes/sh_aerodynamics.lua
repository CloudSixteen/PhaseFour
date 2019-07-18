--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New("AttributeAerodynamics");

ATTRIBUTE.maximum = 100;
ATTRIBUTE.uniqueID = "aer";
ATTRIBUTE.category = "Skills";
ATTRIBUTE.description = "AttributeAerodynamicsDesc";

ATB_AERODYNAMICS = ATTRIBUTE:Register();