--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("SetFreq");
COMMAND.tip = "CmdSetFreq";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local frequency = arguments[1];
	
	if (string.find(frequency, "^%d%d%d%.%d$")) then
		local start, finish, decimal = string.match(frequency, "(%d)%d(%d)%.(%d)");
		
		start = tonumber(start);
		finish = tonumber(finish);
		decimal = tonumber(decimal);
		
		if (start == 1 and finish > 0 and finish < 10 and decimal > 0 and decimal < 10) then
			player:SetCharacterData("frequency", frequency);
			
			Clockwork.player:Notify(player, "You have set your radio frequency to "..frequency..".");
		else
			Clockwork.player:Notify(player, "The radio frequency must be between 101.1 and 199.9!");
		end;
	else
		Clockwork.player:Notify(player, "The radio frequency must look like xxx.x!");
	end;
end;

COMMAND:Register();