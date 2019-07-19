--[[
	� 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

ITEM = Clockwork.item:New();

ITEM.name = "ItemSignPost";
ITEM.uniqueID = "sign_post";
ITEM.cost = 100;
ITEM.batch = 1;
ITEM.model = "models/props_trainstation/tracksign07.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.category = "Deployables";
ITEM.description = "ItemSignPostDesc";

-- Called when the item's shipment entity should be created.
function ITEM:OnCreateShipmentEntity(player, batch, position)
	local entity = ents.Create("cw_sign_post");
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

Clockwork.item:Register(ITEM);