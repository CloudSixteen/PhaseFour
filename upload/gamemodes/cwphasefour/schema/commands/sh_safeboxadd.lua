--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("SafeboxAdd");
COMMAND.tip = "CmdSafeboxAdd";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local trace = player:GetEyeTraceNoCursor();
	local data = {
		position = trace.HitPos + Vector(0, 0, 16)
	};
	
	data.angles = player:EyeAngles();
	data.angles.pitch = 0;
	data.angles.roll = 0;
	data.angles.yaw = data.angles.yaw + 180;
	
	data.entity = ents.Create("cw_safebox");
	data.entity:SetAngles(data.angles);
	data.entity:SetPos(data.position);
	data.entity:Spawn();
	
	data.entity:GetPhysicsObject():EnableMotion(false);
	
	PhaseFour.personalStorage[#PhaseFour.personalStorage + 1] = data;
	PhaseFour:SavePersonalStorage();
	
	Clockwork.player:Notify(player, "You have added a safebox.");
end;

COMMAND:Register();