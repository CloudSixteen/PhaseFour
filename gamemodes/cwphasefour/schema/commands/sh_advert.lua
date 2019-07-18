--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("Advert");

COMMAND.tip = "CmdAdvert";
COMMAND.text = "CmdAdvertDesc";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE, CMD_FALLENOVER);
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local message = table.concat(arguments, " ");
	local advertCost = Clockwork.config:Get("advert_cost"):Get();
	
	if (Clockwork.player:CanAfford(player, advertCost)) then
		Clockwork.chatBox:Add(nil, player, "advert", message);
		Clockwork.player:GiveCash(player, -advertCost, "advertisement");
	else
		Clockwork.player:Notify(player, "You need another "..Clockwork.kernel:FormatCash(advertCost - player:GetCash(), nil, true).."!");
	end;
end;

COMMAND:Register();