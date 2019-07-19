--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemChloroform";
ITEM.uniqueID = "chloroform";
ITEM.cost = 500;
ITEM.model = "models/props_junk/garbage_newspaper001a.mdl";
ITEM.weight = 0.1;
ITEM.useText = "Knock Out";
ITEM.category = "Consumables";
ITEM.business = true;
ITEM.description = "ItemChloroformDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if (player.isChloroforming) then
		Clockwork.player:Notify(player, "You are already tying a character!");
		
		return false;
	else
		local trace = player:GetEyeTraceNoCursor();
		local target = Clockwork.entity:GetPlayer(trace.Entity);
		
		if (target and target:Alive()) then
			if (target:GetShootPos():Distance(player:GetShootPos()) <= 192) then
				local canChloroform = (target:GetAimVector():DotProduct(player:GetAimVector()) > 0);
				local chloroformTime = PhaseFour:GetDexterityTime(player);
				
				if (canChloroform or target:IsRagdolled()) then
					Clockwork.player:SetAction(player, "chloroform", chloroformTime);
					
					target:SetSharedVar("beingChloro", true);
					
					Clockwork.player:EntityConditionTimer(player, target, trace.Entity, chloroformTime, 192, function()
						local canChloroform = (target:GetAimVector():DotProduct(player:GetAimVector()) > 0);
						
						if ((canChloroform or target:IsRagdolled()) and player:Alive() and !player:IsRagdolled()) then
							return true;
						end;
					end, function(success)
						if (success) then
							player.isChloroforming = nil;
							
							Clockwork.player:SetRagdollState(target, RAGDOLL_KNOCKEDOUT, 60);
							
							player:TakeItem(self);
							player:ProgressAttribute(ATB_DEXTERITY, 15, true);
						else
							player.isChloroforming = nil;
						end;
						
						Clockwork.player:SetAction(player, "chloroform", false);
						
						if (IsValid(target)) then
							target:SetSharedVar("beingChloro", false);
						end;
					end);
				else
					Clockwork.player:Notify(player, "You cannot use chloroform characters that are facing you!");
					
					return false;
				end;
				
				Clockwork.player:SetMenuOpen(player, false);
				
				player.isChloroforming = true;
				
				return false;
			else
				Clockwork.player:Notify(player, "This character is too far away!");
				
				return false;
			end;
		else
			Clockwork.player:Notify(player, "That is not a valid character!");
			
			return false;
		end;
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();