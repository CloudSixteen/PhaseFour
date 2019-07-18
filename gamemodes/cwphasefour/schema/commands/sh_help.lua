--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("Help");
COMMAND.tip = "CmdHelp";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.datastream:Start(player, "ShowManual", true);
end;

COMMAND:Register();