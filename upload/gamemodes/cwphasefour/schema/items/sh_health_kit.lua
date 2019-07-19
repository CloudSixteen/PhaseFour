--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemHealthKit";
ITEM.uniqueID = "health_kit";
ITEM.cost = 150;
ITEM.model = "models/items/healthkit.mdl";
ITEM.weight = 1;
ITEM.useText = "Apply";
ITEM.category = "Medical"
ITEM.business = true;
ITEM.useSound = "items/medshot4.wav";
ITEM.description = "ItemHealthKitDesc";
ITEM.customFunctions = {"Give"};

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:SetHealth(math.Clamp(player:Health() + PhaseFour:GetHealAmount(player, 2), 0, player:GetMaxHealth()));
	
	Clockwork.plugin:Call("PlayerHealed", player, player, self);
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

-- Called when a custom function is used.
function ITEM:OnCustomFunction(player, name)
	if (name == "Give") then
		Clockwork.player:RunClockworkCommand(player, "CharHeal", "health_kit");
	end;
end;

ITEM:Register();