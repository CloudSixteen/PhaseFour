--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

--[[
local ITEM = Clockwork.item:New();

ITEM.name = "ItemZipTie";
ITEM.uniqueID = "zip_tie";
ITEM.cost = 200;
ITEM.model = "models/items/crossbowrounds.mdl";
ITEM.weight = 0.1;
ITEM.useText = "Tie";
ITEM.category = "Consumables";
ITEM.business = true;
ITEM.description = "ItemZipTieDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if (player.isTying) then
		Clockwork.player:Notify(player, "You are already tying a character!");
		
		return false;
	end;
	
	local trace = player:GetEyeTraceNoCursor();
	local target = Clockwork.entity:GetPlayer(trace.Entity);
	
	if (target and target:Alive()) then
		if (!target:GetSharedVar("tied")) then
			if (target:GetShootPos():Distance(player:GetShootPos()) <= 192) then
				local canTie = (target:GetAimVector():DotProduct(player:GetAimVector()) > 0);
				local tieTime = PhaseFour:GetDexterityTime(player);
				
				if (PhaseFour.augments:Has(player, AUG_QUICKHANDS)) then
					tieTime = tieTime * 0.7;
				end;
				
				if (target:IsRagdolled(RAGDOLL_KNOCKEDOUT)) then
					Clockwork.player:Notify(player, "Players can not be tied when they are knocked out!");
					return false;
				end;
				
				if (canTie or target:IsRagdolled()) then
					Clockwork.player:SetAction(player, "tie", tieTime);
					
					target:SetSharedVar("beingTied", true);
					
					Clockwork.player:EntityConditionTimer(player, target, trace.Entity, tieTime, 192, function()
						local canTie = (target:GetAimVector():DotProduct(player:GetAimVector()) > 0);
						
						if (!player:Alive() or target:IsRagdolled(RAGDOLL_KNOCKEDOUT)) then
							return false;
						end;
						
						if (player:IsRagdolled()) then
							return false;
						end;
						
						if (target:GetSharedVar("tied")) then
							return false;
						end;
						
						if (canTie or target:IsRagdolled()) then
							return true;
						end;
					end, function(success)
						if (success) then
							player.isTying = nil;
							
							PhaseFour:TiePlayer(target, true);
							
							player:TakeItem(self);
							player:ProgressAttribute(ATB_DEXTERITY, 15, true);
							
							PhaseFour.victories:Progress(player, VIC_ZIPNINJA);
						else
							player.isTying = nil;
						end;
						
						Clockwork.player:SetAction(player, "tie", false);
						
						if (IsValid(target)) then
							target:SetSharedVar("beingTied", false);
						end;
					end);
				else
					Clockwork.player:Notify(player, "You cannot tie characters that are facing you!");
					
					return false;
				end;
				
				Clockwork.player:SetMenuOpen(player, false);
				
				player.cwNextDisconnect = CurTime() + 30;
				player.isTying = true;
				
				return false;
			else
				Clockwork.player:Notify(player, "This character is too far away!");
				
				return false;
			end;
		else
			Clockwork.player:RunClockworkCommand(player, "CharSearch");
			
			return false;
		end;
	else
		Clockwork.player:Notify(player, "That is not a valid character!");
		
		return false;
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position)
	if (player.isTying) then
		Clockwork.player:Notify(player, "You are currently tying a character!");
		
		return false;
	end;
end;

ITEM:Register();
--]]