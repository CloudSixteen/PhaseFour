--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "ItemDisguiseKit";
ITEM.uniqueID = "disguise_kit";
ITEM.cost = 1000;
ITEM.model = "models/props_lab/box01a.mdl";
ITEM.weight = 1;
ITEM.category = "Consumables"
ITEM.business = true;
ITEM.description = "ItemDisguiseKitDesc";
ITEM.customFunctions = {"Disguise"};

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

-- Called when the item's right click should be handled.
function ITEM:OnHandleRightClick()
	return "Disguise";
end;

if (SERVER) then
	function ITEM:OnCustomFunction(player, name)
		if (name == "Disguise") then
			local curTime = CurTime();
			
			if (!player.nextUseDisguise or curTime >= player.nextUseDisguise) then
				Clockwork.datastream:Start(player, "Disguise", true);
			else
				Clockwork.player:Notify(player, "You cannot use another disguise kit for "..math.Round(math.ceil(player.nextUseDisguise - curTime)).." second(s)!");
			end;
		end;
	end;
end;

ITEM:Register();