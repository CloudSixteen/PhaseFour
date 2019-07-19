--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local function GetClientSideInfo(itemTable)
	local durability = itemTable:GetData("Durability");
	local clientSideInfo = "";
	local durabilityColor = Color((255 / 100) * (100 - durability), (255 / 100) * durability, 0, 255);
	
	if (itemTable:IsInstance()) then
		clientSideInfo = Clockwork.kernel:AddMarkupLine(
			clientSideInfo, "Durability: "..math.floor(durability).."%", durabilityColor
		);
	end;
	
	return (clientSideInfo != "" and clientSideInfo);
end;

local ITEM_RANK_SCALE = 0.02;

function PhaseFour:ClockworkPostItemsInitialized(itemsTable)
	local weaponItems = {};
	local clothingItems = {};
	
	for k, v in pairs(itemsTable) do
		if (Clockwork.item:IsWeapon(v)) then
			table.insert(weaponItems, v);
		end;
		
		if (v:IsBasedFrom("clothes_base")) then
			table.insert(clothingItems, v);
		end;
	end;
	
	table.sort(weaponItems, function(a, b)
		return a.cost < b.cost;
	end);
	
	table.sort(clothingItems, function(a, b)
		return a.cost < b.cost;
	end);
	
	for i = 1, #weaponItems do
		local itemTable = weaponItems[i];
		
		itemTable.cost = math.floor((itemTable.cost * 0.6) * (1 + (i * ITEM_RANK_SCALE)));
		itemTable.cost = 100 * math.floor((itemTable.cost + 50) / 100);
	end;
	
	for i = 1, #clothingItems do
		local itemTable = clothingItems[i];
		
		itemTable.cost = math.floor((itemTable.cost * 0.6) * (1 + (i * ITEM_RANK_SCALE)));
		itemTable.cost = 100 * math.floor((itemTable.cost + 50) / 100);
	end;
end;

-- Called when a Clockwork item has initialized.
function PhaseFour:ClockworkItemInitialized(itemTable)
	if (Clockwork.item:IsWeapon(itemTable) or itemTable:IsBasedFrom("clothes_base")) then
		if (itemTable.GetClientSideInfo) then
			itemTable.OldGetClientSideInfo = itemTable.GetClientSideInfo;
			itemTable.NewGetClientSideInfo = GetClientSideInfo;
			itemTable.GetClientSideInfo = function(itemTable)
				local existingText = itemTable:OldGetClientSideInfo();
				local additionText = itemTable:NewGetClientSideInfo() or "";
				local totalText = (existingText and existingText.."\n" or "")..additionText;
				
				return (totalText != "" and totalText);
			end;
		else
			itemTable.GetClientSideInfo = GetClientSideInfo;
		end;
		
		itemTable:AddData("Durability", 100, true);
	end;
	
	if (!itemTable.batch or itemTable.batch == 5) then
		itemTable.batch = 3;
	end;
end;