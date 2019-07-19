--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("DisguiseSet");
COMMAND.tip = "CmdDisguiseSet";
COMMAND.text = "CmdDisguiseSetDesc";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (player:HasItemByID("disguise_kit")) then
		local curTime = CurTime();
		
		if (!player.nextUseDisguise or curTime >= player.nextUseDisguise) then
			local target = Clockwork.player:Get(arguments[1]);
			
			if (target) then
				if (player != target) then
					local itemTable = player:FindItemByID("disguise_kit");
					local success, fault = player:TakeItem(itemTable);
					
					if (success) then
						Clockwork.player:Notify(player, "You are now disguised as "..target:Name().." for two minutes!");
						
						player.nextUseDisguise = curTime + 600;
						player:SetSharedVar("disguise", target);
						player.cwCancelDisguise = curTime + 120;
					end;
				else
					Clockwork.player:Notify(player, "You cannot disguise yourself as yourself!");
				end;
			else
				Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
			end;
		else
			Clockwork.player:Notify(player, "You cannot use another disguise kit for "..math.Round(math.ceil(player.nextUseDisguise - curTime)).." second(s)!");
		end;
	else
		Clockwork.player:Notify(player, "You do not own a disguise kit!");
	end;
end;
COMMAND:Register();