--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("generator_base")
ITEM.name = "ItemCashPrinter";
ITEM.uniqueID = "cash_printer";
ITEM.cost = 175;
ITEM.model = "models/props_lab/reciever01b.mdl";
ITEM.business = true;
ITEM.category = "Cash Generators";
ITEM.description = "ItemCashPrinterDesc";

ITEM.generatorInfo = {
	powerPlural = "Batteries",
	powerName = "Battery",
	uniqueID = "cw_cashprinter",
	maximum = 1,
	health = 100,
	power = 9,
	cash = 125,
	name = "Cash Printer",
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