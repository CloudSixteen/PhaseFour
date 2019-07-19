--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("generator_base")
ITEM.name = "ItemCashProducer";
ITEM.uniqueID = "cash_producer";
ITEM.cost = 200;
ITEM.model = "models/props_lab/reciever01a.mdl";
ITEM.business = true;
ITEM.category = "Cash Generators";
ITEM.description = "ItemCashProducerDesc";

ITEM.generatorInfo = {
	powerPlural = "Batteries",
	powerName = "Battery",
	uniqueID = "cw_cashproducer",
	maximum = 1,
	health = 125,
	power = 9,
	cash = 150,
	name = "Cash Producer",
};

-- Called before a player orders the item.
function ITEM:PreOrder(player)
	local entities = Clockwork.player:GetPropertyEntities(player, self("generatorInfo").uniqueID);
	
	for k, v in ipairs(entities) do
		v:Explode(); v:Remove();
		Clockwork.entity:ClearProperty(v);
	end;
end;

-- Called before a player drops the item.
function ITEM:PreDrop(player)
	self:PreOrder(player);
end;

ITEM:Register();