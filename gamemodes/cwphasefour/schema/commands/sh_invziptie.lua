--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

--[[
local COMMAND = Clockwork.command:New("InvZipTie");

COMMAND.tip = "CmdInvZipTie";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.player:RunClockworkCommand(player, "InvAction", "zip_tie", "use");
end;

COMMAND:Register();
--]]