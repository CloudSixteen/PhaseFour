--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New("Survivor");
	CLASS.wages = 75;
	CLASS.color = Color(125, 206, 233, 255);
	CLASS.factions = {FACTION_CIVILIAN};
	CLASS.isDefault = true;
	CLASS.wagesName = "Salary";
	CLASS.description = "The survivor of an Aperture Science experiment.";
	CLASS.defaultPhysDesc = "Wearing tattered clothing";
CLASS_TESTSUBJECT = CLASS:Register();