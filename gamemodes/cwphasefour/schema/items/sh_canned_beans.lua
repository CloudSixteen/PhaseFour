--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemCannedBeans";
ITEM.uniqueID = "canned_beans";
ITEM.cost = 30;
ITEM.model = "models/props_lab/jar01b.mdl";
ITEM.weight = 0.6;
ITEM.useText = "Eat";
ITEM.category = "Medical"
ITEM.business = true;
ITEM.description = "ItemCannedBeansDesc";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:SetHealth(math.Clamp(player:Health() + 5, 0, player:GetMaxHealth()));
	player:BoostAttribute(self.name, ATB_ENDURANCE, 1, 600);
	
	local stamina = player:GetCharacterData("Stamina");
	
	if (stamina) then
		player:SetCharacterData("Stamina", math.min(stamina + 50, 100));
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();