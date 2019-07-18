--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("NotifyBrokenWeapon");
COMMAND.tip = "Notify the client about their weapon being broken.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	Clockwork.player:Notify(player, "This weapon is broken and needs to be repaired!");
end;

COMMAND:Register();