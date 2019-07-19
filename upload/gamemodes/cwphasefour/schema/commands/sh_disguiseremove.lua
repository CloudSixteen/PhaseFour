--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("DisguiseRemove");
COMMAND.tip = "CmdDisguiseRemove";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (IsValid(player:GetSharedVar("disguise"))) then
		Clockwork.player:Notify(player, "You have taken off your disguise, your true identity is revealed!");
		
		player:SetSharedVar("disguise", NULL);
		player.cwCancelDisguise = nil;
	end;
end;

COMMAND:Register();