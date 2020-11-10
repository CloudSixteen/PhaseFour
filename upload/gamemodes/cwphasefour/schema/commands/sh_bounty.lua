--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("Bounty");
COMMAND.tip = "CmdBounty";
COMMAND.text = "CmdBountyDesc";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	local bounty = tonumber(arguments[2]);
	
	if (!bounty) then
		Clockwork.player:Notify(player, {"InvalidBounty"});
		
		return;
	end;
	
	if (target) then
		local minimumBounty = 100;
		
		if (target:IsGood()) then
			minimumBounty = 200;
		end;
		
		if (bounty < minimumBounty) then
			if (target:IsGood()) then
				Clockwork.player:Notify(player, {"IsGoodHasMinBounty", target:Name(), Clockwork.kernel:FormatCash(minimumBounty, nil, true)});
			else
				Clockwork.player:Notify(player, {"IsBadHasMinBounty", target:Name(), Clockwork.kernel:FormatCash(minimumBounty, nil, true)});
			end;
			
			return;
		end;
		
		if (Clockwork.player:CanAfford(player, bounty)) then
			Clockwork.player:Notify(player, {"PlacedBounty", Clockwork.kernel:FormatCash(bounty, nil, true), target:Name()});
			Clockwork.player:GiveCash(player, -bounty, "placing a bounty");
			
			target:AddBounty(bounty);
			
			Clockwork.chatBox:Add(nil, target, "bounty", tostring(target:GetBounty()));
		else
			Clockwork.player:Notify(player, {"SalesmenYouNeedAnother", Clockwork.kernel:FormatCash(bounty - player:GetCash(), nil, true)});
		end;
	end;
end;

COMMAND:Register();
