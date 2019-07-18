--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("AllyInvite");
COMMAND.tip = "CmdAllyInvite";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local alliance = player:GetAlliance();
	local target = Clockwork.entity:GetPlayer(player:GetEyeTraceNoCursor().Entity);
	
	if (target) then
		if (alliance) then
			if (player:IsLeader()) then
				if (target:GetVelocity():Length() == 0) then
					target.allianceAuthenticate = alliance;
					target.allianceInviter = player;
					
					Clockwork.datastream:Start({target}, "InviteAlliance", alliance);
					
					Clockwork.player:Notify(player, "You have invited this character to your alliance.");
					Clockwork.player:Notify(target, "A character has invited you to their alliance.");
				else
					Clockwork.player:Notify(target, "You cannot invite a character while they are moving!");
				end;
			else
				Clockwork.player:Notify(target, "You are not a leader of this alliance!");
			end;
		else
			Clockwork.player:Notify(target, "You are not in an alliance!");
		end;
	else
		Clockwork.player:Notify(player, "You must look at a character!");
	end;
end;

COMMAND:Register();