--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemHandheldRadio";
ITEM.uniqueID = "handheld_radio";
ITEM.cost = 100;
ITEM.model = "models/deadbodies/dead_male_civilian_radio.mdl";
ITEM.weight = 1;
ITEM.category = "Equipment";
ITEM.business = true;
ITEM.isRareItem = true;
ITEM.description = "ItemHandheldRadioDesc";
ITEM.customFunctions = {"Frequency"};

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

-- Called when the item's right click should be handled.
function ITEM:OnHandleRightClick()
	return "Frequency";
end;

if (SERVER) then
	function ITEM:OnCustomFunction(player, name)
		if (name == "Frequency") then
			Clockwork.datastream:Start(player, "Frequency", player:GetCharacterData("frequency", ""));
		end;
	end;
end;

ITEM:Register();