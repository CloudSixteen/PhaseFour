--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("Ally");
COMMAND.tip = "CmdAlly";
COMMAND.text = "CmdAllyDesc";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE, CMD_FALLENOVER);
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local message = table.concat(arguments, " ");
	local alliance = player:GetAlliance();
	
	if (!alliance) then
		Clockwork.player:Notify(target, "You are not in an alliance!");
		return;
	end;
	
	local listeners = {};
	
	for k, v in pairs(cwPlayer.GetAll()) do
		if (v:HasInitialized()) then
			if (v:GetAlliance() == alliance) then
				table.insert(listeners, v);
			end;
		end;
	end;
	
	Clockwork.chatBox:Add(listeners, player, "alliance", message);
end;

COMMAND:Register();
