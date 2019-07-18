--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("AllyLeave");
COMMAND.tip = "CmdAllyLeave";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local alliance = player:GetAlliance();
	
	if (alliance) then
		player:SetAlliance("");
		player:SetRank(RANK_RCT);
		
		Clockwork.player:Notify(player, "You have left the '"..alliance.."' alliance.");
	else
		Clockwork.player:Notify(target, "You are not in an alliance!");
	end;
end;
COMMAND:Register();