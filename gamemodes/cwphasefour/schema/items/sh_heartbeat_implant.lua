--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("accessory_base");

ITEM.name = "ItemHeartbeatImplant";
ITEM.uniqueID = "heartbeat_implant";
ITEM.cost = 2000;
ITEM.model = "models/gibs/shield_scanner_gib1.mdl";
ITEM.weight = 1;
ITEM.category = "Equipment";
ITEM.business = true;
ITEM.description = "ItemHeartbeatImplantDesc";

-- Called when the item's local amount is needed.
-- function ITEM:GetLocalAmount(amount)
	-- if (Clockwork.Client:GetSharedVar("implant")) then
		-- return amount - 1;
	-- else
		-- return amount;
	-- end;
-- end;

-- -- Called to get whether a player has the item equipped.
-- function ITEM:HasPlayerEquipped(player, arguments)
	-- return player:GetSharedVar("implant");
-- end;

-- -- Called when a player has unequipped the item.
-- function ITEM:OnPlayerUnequipped(player, arguments)
	-- player:SetCharacterData("implant", nil);
	-- player:SetSharedVar("implant", false);
	-- player:GiveItem(self);
-- end;

-- Called when a player uses the item.
-- function ITEM:OnUse(player, itemEntity)
	-- if (player:Alive() and !player:IsRagdolled()) then
		-- player:SetCharacterData("implant", true);
		-- player:SetSharedVar("implant", true);
		-- player:GiveItem(self);
		
		-- if (itemEntity) then
			-- return true;
		-- end;
	-- else
		-- Clockwork.player:Notify(player, "You don't have permission to do this right now!");
	-- end;
	
	-- return false;
-- end;

-- Called when a player drops the item.
-- function ITEM:OnDrop(player, position) end;

-- Called when a player wears the accessory.
function ITEM:OnWearAccessory(player, bIsWearing)
	if (bIsWearing) then
		player:SetSharedVar("implant", true);
	else
		player:SetSharedVar("implant", false);
	end;
end;

ITEM:Register();