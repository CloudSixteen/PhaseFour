--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("CharHeal");
COMMAND.tip = "CmdCharHeal";
COMMAND.text = "CmdCharHealDesc";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (!player:GetSharedVar("tied")) then
		local itemTable = player:FindItemByID(arguments[1]);
		local entity = player:GetEyeTraceNoCursor().Entity;
		local healed = nil;
		local target = Clockwork.entity:GetPlayer(entity);
		
		if (target) then
			if (entity:GetPos():Distance(player:GetShootPos()) <= 192) then
				if (itemTable and arguments[1] == "health_vial") then
					if (player:HasItemByID("health_vial")) then
						target:SetHealth(math.Clamp(target:Health() + PhaseFour:GetHealAmount(player, 1.5), 0, target:GetMaxHealth()));
						target:EmitSound("items/medshot4.wav");
						
						player:TakeItem(itemTable, true);
						
						healed = true;
					else
						Clockwork.player:Notify(player, "You do not own a health vial!");
					end;
				elseif (itemTable and arguments[1] == "health_kit") then
					if (player:HasItemByID("health_kit")) then
						target:SetHealth(math.Clamp(target:Health() + PhaseFour:GetHealAmount(player, 2), 0, target:GetMaxHealth()));
						target:EmitSound("items/medshot4.wav");
						
						player:TakeItem(itemTable, true);
						
						healed = true;
					else
						Clockwork.player:Notify(player, "You do not own a health kit!");
					end;
				elseif (itemTable and arguments[1] == "bandage") then
					if (player:HasItemByID("bandage")) then
						target:SetHealth(math.Clamp(target:Health() + PhaseFour:GetHealAmount(player), 0, target:GetMaxHealth()));
						target:EmitSound("items/medshot4.wav");
						
						player:TakeItem(itemTable, true);
						
						healed = true;
					else
						Clockwork.player:Notify(player, "You do not own a bandage!");
					end;
				else
					Clockwork.player:Notify(player, "This is not a valid item!");
				end;
				
				if (healed) then
					Clockwork.plugin:Call("PlayerHealed", target, player, itemTable);
					
					if (Clockwork.player:GetAction(target) == "die") then
						Clockwork.player:SetRagdollState(target, RAGDOLL_NONE);
						PhaseFour.victories:Progress(player, VIC_PARAMEDIC);
					end;
					
					player:FakePickup(target);
				end;
			else
				Clockwork.player:Notify(player, "This character is too far away!");
			end;
		else
			Clockwork.player:Notify(player, "You must look at a character!");
		end;
	else
		Clockwork.player:Notify(player, "You don't have permission to do this right now!");
	end;
end;
COMMAND:Register();
