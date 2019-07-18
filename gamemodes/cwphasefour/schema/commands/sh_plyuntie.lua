--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

--[[
local COMMAND = Clockwork.command:New("PlyUntie");

COMMAND.tip = "CmdPlyUntie";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local untieTime = PhaseFour:GetDexterityTime(player);
	local eyeTrace = player:GetEyeTraceNoCursor();
	local target = eyeTrace.Entity;
	local entity = target;
	
	if (PhaseFour.augments:Has(player, AUG_HURRYMAN)) then
		untieTime = untieTime * 0.5;
	end;
	
	if (IsValid(target)) then
		target = Clockwork.entity:GetPlayer(target);
		
		if (target and !player:GetSharedVar("tied")) then
			if (target:GetShootPos():Distance(player:GetShootPos()) <= 192) then
				if (target:GetSharedVar("tied") and target:Alive()) then
					Clockwork.player:SetAction(player, "untie", untieTime);
					
					target:SetSharedVar("beingUntied", true);
					
					Clockwork.player:EntityConditionTimer(player, target, entity, untieTime, 192, function()
						return player:Alive() and target:Alive() and !player:IsRagdolled() and !player:GetSharedVar("tied");
					end, function(success)
						if (success) then
							PhaseFour:TiePlayer(target, false);
							
							player:ProgressAttribute(ATB_DEXTERITY, 15, true);
						end;
						
						if (IsValid(target)) then
							target:SetSharedVar("beingUntied", false);
						end;
						
						Clockwork.player:SetAction(player, "untie", false);
					end);
				else
					Clockwork.player:Notify(player, "This character is either not tied, or not alive!");
				end;
			else
				Clockwork.player:Notify(player, "This character is too far away!");
			end;
		else
			Clockwork.player:Notify(player, "You don't have permission to do this right now!");
		end;
	else
		Clockwork.player:Notify(player, "You must look at a character!");
	end;
end;

COMMAND:Register();
--]]