--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base", true);

ITEM.name = "ItemCustomWeapon";
ITEM.uniqueID = "custom_weapon";
ITEM.hasFlashlight = false;

-- A function to get the item's mark name.
function ITEM:GetMarkName()
	local level = self:GetData("Level");
	
	if (self.cannotUpgrade) then
		return L(self.name);
	else
		return L(self.name).." Mk. "..level;
	end;
end;

-- A function to get the item's mark plural.
function ITEM:GetMarkPlural()
	local level = self:GetData("Level");
	
	if (level > 1) then
		return self:GetMarkName().."s";
	else
		return self:GetMarkName();
	end;
end;

ITEM:AddData("Level", 1, true);
ITEM:AddQueryProxy("name", ITEM.GetMarkName);
ITEM:AddQueryProxy("plural", ITEM.GetMarkPlural);

if (CLIENT) then
	function ITEM:GetClientSideInfo()
		local weaponBaseClass = self:GetBaseClass("weapon_base");
		local clientSideInfo = weaponBaseClass.GetClientSideInfo(self);
		local itemLevel = self:GetData("Level");
		
		if (!clientSideInfo) then
			clientSideInfo = "";
		end;
		
		if (self("hasFlashlight")) then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Has Flashlight: Yes");
		else
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Has Flashlight: No");
		end;
		
		return (clientSideInfo != "" and clientSideInfo);
	end;
	
	-- Called when the item entity's menu options are needed.
	function ITEM:GetEntityMenuOptions(entity, options)
		local itemLevel = self:GetData("Level");
		local toolTip = "";
		
		if (itemLevel >= 10 or self.cannotUpgrade) then
			return;
		end;
		
		local engRequired = math.floor(math.Clamp(itemLevel * 5, 0, 50));
		local engineering = Clockwork.attributes:Fraction(ATB_ENGINEERING, 50, 50);
		
		if (engineering < engRequired) then
			toolTip = "Requires an engineering level of "..((100 / 50) * engRequired).."%.";
		else
			toolTip = "This upgrade will cost you "..Clockwork.kernel:FormatCash(itemLevel * 500, true)..".";
		end;
		
		local upgradeCost = (self("cost") / 4) * itemLevel;
		local optionTitle = "Upgrade ("..Clockwork.kernel:FormatCash(upgradeCost)..")";
		
		options[optionTitle] = {
			Callback = function()
				Clockwork.datastream:Start("UpgradeWeapon", Clockwork.item:GetSignature(self));
			end,
			isArgTable = true,
			toolTip = toolTip
		};
		
		local weaponBaseClass = self:GetBaseClass("weapon_base");
		
		if (weaponBaseClass) then
			weaponBaseClass.GetEntityMenuOptions(self, entity, options);
		end;
	end;
end;

Clockwork.item:Register(ITEM);