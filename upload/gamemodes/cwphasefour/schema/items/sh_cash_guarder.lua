--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemCashGuarder";
ITEM.uniqueID = "cash_guarder";
ITEM.cost = 250;
ITEM.model = "models/props_combine/breenglobe.mdl";
ITEM.batch = 1;
ITEM.weight = 2;
ITEM.business = true;
ITEM.category = "Deployables";
ITEM.description = "ItemCashGuarderDesc";

-- Called when the item's shipment entity should be created.
function ITEM:OnCreateShipmentEntity(player, batch, position)
	local entity = ents.Create("cw_cashguarder");
	
	Clockwork.player:GiveProperty(player, entity, true);
	
	entity:SetAngles(Angle(0, 0, 0));
	entity:SetPos(position);
	entity:Spawn();
	
	return entity;
end;

-- Called when the item's drop entity should be created.
function ITEM:OnCreateDropEntity(player, position)
	return self:OnCreateShipmentEntity(player, 1, position);
end;

-- Called when a player attempts to order the item.
function ITEM:CanOrder(player)
	if (Clockwork.player:GetPropertyCount(player, "cw_cashguarder") >= 1) then
		Clockwork.player:Notify(player, "You have reached the maximum amount of this item!");
		
		return false;
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position)
	if (Clockwork.player:GetPropertyCount(player, "cw_cashguarder") >= 1) then
		Clockwork.player:Notify(player, "You have reached the maximum amount of this item!");
		
		return false;
	end;
end;

ITEM:Register();