--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("accessory_base");

ITEM.name = "ItemSkullMask";
ITEM.uniqueID = "skull_mask";
ITEM.cost = 300;
ITEM.model = "models/gibs/hgibs.mdl";
ITEM.weight = 0.25;
ITEM.business = true;
ITEM.category = "Equipment";
ITEM.description = "ItemSkullMaskDesc";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Head1";
ITEM.attachmentOffsetAngles = Angle(270, 270, 0);

ITEM.attachmentOffsetVector = Vector(0, 3, 3);

-- Called when the attachment offset info should be adjusted.
function ITEM:AdjustAttachmentOffsetInfo(player, entity, info)
	if (string.find(player:GetModel(), "female")) then
		info.offsetVector = Vector(0, 3, 1.75);
	end;
end;

-- A function to get whether the attachment is visible.
function ITEM:GetAttachmentVisible(player, entity)
	if (string.find(player:GetModel(), "group%d%d")) then
		if (player:GetSharedVar("skullMask")) then
			return true;
		end;
	end;
end;

-- Called when the item's local amount is needed.
-- function ITEM:GetLocalAmount(amount)
	-- if (Clockwork.Client:GetSharedVar("skullMask")) then
		-- return amount - 1;
	-- else
		-- return amount;
	-- end;
-- end;

-- Called to get whether a player has the item equipped.
-- function ITEM:HasPlayerEquipped(player, arguments)
	-- return player:GetSharedVar("skullMask");
-- end;

-- Called when a player wears the accessory.
function ITEM:OnWearAccessory(player, bIsWearing)
	if (bIsWearing) then
		Clockwork.player:CreateGear(player, "SkullMask", self);
		player:SetSharedVar("skullMask", true);
	else
		local skullMaskGear = Clockwork.player:GetGear(player, "SkullMask");
		
		if (IsValid(skullMaskGear)) then
			skullMaskGear:Remove();
		end;
		
		player:SetSharedVar("skullMask", false);
	end;
end;

-- Called when a player has unequipped the item.
-- function ITEM:OnPlayerUnequipped(player, arguments)
	-- local skullMaskGear = Clockwork.player:GetGear(player, "SkullMask");
		
	-- if (player:GetSharedVar("skullMask") and IsValid(skullMaskGear)) then
		-- player:SetCharacterData("skullmask", nil);
		-- player:SetSharedVar("skullMask", false);
			
		-- if (IsValid(skullMaskGear)) then
			-- skullMaskGear:Remove();
		-- end;
	-- end;
		
	-- player:GiveItem(self);
-- end;

-- -- Called when a player drops the item.
-- function ITEM:OnDrop(player, position)
	-- if (player:GetSharedVar("skullMask")) then
		-- if (player:HasItemByID(self.uniqueID) == 1) then
			-- Clockwork.player:Notify(player, "You cannot drop this while you are wearing it!");
			-- return false;
		-- end;
	-- end;
-- end;

-- -- Called when a player uses the item.
-- function ITEM:OnUse(player, itemEntity)
	-- if (player:Alive() and !player:IsRagdolled()) then
		-- Clockwork.player:CreateGear(player, "SkullMask", self);
		
		-- player:SetCharacterData("skullmask", true);
		-- player:SetSharedVar("skullMask", true);
		-- player:GiveItem(self.uniqueID);
		
		-- if (itemEntity) then
			-- return true;
		-- end;
	-- else
		-- Clockwork.player:Notify(player, "You don't have permission to do this right now!");
	-- end;
	
	-- return false;
-- end;

ITEM:Register();