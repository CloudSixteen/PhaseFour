--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("SafeboxRemove");
COMMAND.tip = "CmdSafeboxRemove";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local trace = player:GetEyeTraceNoCursor();
	local removed = 0;
	
	for k, v in pairs(PhaseFour.personalStorage) do
		if (v.position:Distance(trace.HitPos) <= 256) then
			if (IsValid(v.entity)) then
				v.entity:Remove();
			end;
			
			PhaseFour.personalStorage[k] = nil;
			
			removed = removed + 1;
		end;
	end;
	
	if (removed > 0) then
		if (removed == 1) then
			Clockwork.player:Notify(player, "You have removed "..removed.." safebox.");
		else
			Clockwork.player:Notify(player, "You have removed "..removed.." safeboxs.");
		end;
	else
		Clockwork.player:Notify(player, "There were no safeboxs near this position.");
	end;
	
	PhaseFour:SavePersonalStorage();
end;

COMMAND:Register();