--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemBreach";
ITEM.uniqueID = "breach";
ITEM.cost = 500;
ITEM.model = "models/props_wasteland/prison_padlock001a.mdl";
ITEM.plural = "Breaches";
ITEM.weight = 0.3;
ITEM.useText = "Place";
ITEM.business = true;
ITEM.category = "Consumables";
ITEM.description = "ItemBreachDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	local trace = player:GetEyeTraceNoCursor();
	local entity = trace.Entity;
	
	if (IsValid(entity)) then
		if (entity:GetPos():Distance(player:GetShootPos()) <= 192) then
			if (Clockwork.plugin:Call("PlayerCanBreachEntity", player, entity)) then
				local breach = ents.Create("cw_breach");
				
				breach:Spawn();
				
				if (IsValid(entity.breach)) then
					entity.breach:Explode();
					entity.breach:Remove();
				end;
				
				breach:SetBreachEntity(entity, trace);
			else
				Clockwork.player:Notify(player, "This entity cannot be breached!");
				
				return false;
			end;
		else
			Clockwork.player:Notify(player, "You are not close enough to the entity!");
			
			return false;
		end;
	else
		Clockwork.player:Notify(player, "That is not a valid entity!");
		
		return false;
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();