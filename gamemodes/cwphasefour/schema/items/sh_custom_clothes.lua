--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base", true);

ITEM.name = "ItemCustomClothes";
ITEM.uniqueID = "custom_clothes";

-- A function to get the item's mark name.
function ITEM:GetMarkName()
	local level = self:GetData("Level");
	return L(self.name).." Mk. "..level
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
		local clothesBaseClass = self:GetBaseClass("clothes_base");
		local clientSideInfo = clothesBaseClass.GetClientSideInfo(self);
		local armorScale = self("armorScale");
		local resistance = math.floor(armorScale * 100);
		local itemLevel = self:GetData("Level");
		
		if (!clientSideInfo) then
			clientSideInfo = "";
		end;
		
		local resistanceColor = Color((255 / 100) * (100 - resistance), (255 / 100) * resistance, 0, 255);
		clientSideInfo = Clockwork.kernel:AddMarkupLine(
			clientSideInfo, "Resistance: "..resistance.."%", resistanceColor
		);
	
		if (self("tearGasProtection")) then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Tear Gassable: No");
		else
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Tear Gassable: Yes");
		end;
		
		return (clientSideInfo != "" and clientSideInfo);
	end
	
	-- Called when the item entity's menu options are needed.
	function ITEM:GetEntityMenuOptions(entity, options)
		local itemLevel = self:GetData("Level");
		local toolTip = "";
		if (itemLevel >= 10) then return; end;
		
		local engRequired = math.floor(math.Clamp(itemLevel * 5, 0, 50));
		local engineering = Clockwork.attributes:Fraction(ATB_ENGINEERING, 50, 50);
		
		if (engineering < engRequired) then
			toolTip = "Requires an engineering level of "..((100 / 50) * engRequired).."%.";
		else
			toolTip = "This upgrade will cost you "..Clockwork.kernel:FormatCash(itemLevel * 500, true)..".";
		end;
		
		options["Upgrade"] = {
			Callback = function()
				Clockwork.datastream:Start("UpgradeArmor", Clockwork.item:GetSignature(self));
			end,
			isArgTable = true,
			toolTip = toolTip
		};
	
		local clothesBaseClass = self:GetBaseClass("clothes_base");
		
		if (clothesBaseClass
		and clothesBaseClass.GetEntityMenuOptions) then
			clothesBaseClass.GetEntityMenuOptions(self, entity, options);
		end;
	end;
end;

Clockwork.item:Register(ITEM);