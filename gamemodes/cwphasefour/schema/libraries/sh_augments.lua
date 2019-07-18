--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

PhaseFour.augments = {};

if (SERVER) then
	function PhaseFour.augments:Give(player, augment)
		local augmentTable = PhaseFour.augment:Get(augment);
		local augments = player:GetCharacterData("augments");
		
		if (augmentTable) then
			augments[augmentTable.uniqueID] = true;
			Clockwork.datastream:Start(player, "AugmentsGive", augmentTable.index);

			if (augmentTable.OnGiven) then
				augmentTable:OnGiven(player);
			end;
			
			if (table.Count(augments) >= 5) then
				PhaseFour.victories:Progress(player, VIC_TESTSUBJECT);
			end;
		else
			return false, L("NotValidAugment");
		end;
	end;
	
	-- A function to get whether a player has an augment.
	function PhaseFour.augments:Has(player, augment)
		local augmentTable = PhaseFour.augment:Get(augment);
		local augments = player:GetCharacterData("augments");
		
		if (augmentTable) then
			if (augments[augmentTable.uniqueID]) then
				if (augmentTable.honor == "perma") then
					return true;
				elseif (augmentTable.honor == "good") then
					return player:IsGood();
				else
					return player:IsBad();
				end;
			else
				return false;
			end;
		else
			return false;
		end;
	end;
else
	PhaseFour.augments.stored = {};
	
	-- A function to get the augments panel.
	function PhaseFour.augments:GetPanel()
		return self.panel;
	end;
	
	-- A function to get whether the local player has an augment.
	function PhaseFour.augments:Has(augment, bRegardless)
		local augmentTable = PhaseFour.augment:Get(augment);
		
		if (augmentTable) then
			if (self.stored[augmentTable.uniqueID]) then
				if (bRegardless) then
					return true;
				end;
				
				if (augmentTable.honor == "perma") then
					return true;
				elseif (augmentTable.honor == "good") then
					return Clockwork.Client:IsGood();
				else
					return Clockwork.Client:IsBad();
				end;
			else
				return false;
			end;
		else
			return false;
		end;
	end;

	Clockwork.datastream:Hook("AugmentsGive", function(data)
		local augmentTable = PhaseFour.augment:Get(data);
		if (not augmentTable) then return; end;
		
		PhaseFour.augments.stored[augmentTable.uniqueID] = true;
		
		if (Clockwork.menu:GetOpen()) then
			local panel = PhaseFour.augments:GetPanel();
			
			if (panel and Clockwork.menu:GetActivePanel() == panel) then
				panel:Rebuild();
			end;
		end;
	end);

	Clockwork.datastream:Hook("AugmentsClear", function(data)
		PhaseFour.augments.stored = {};
		
		if (Clockwork.menu:GetOpen()) then
			local panel = PhaseFour.augments:GetPanel();
			
			if (panel and Clockwork.menu:GetActivePanel() == panel) then
				panel:Rebuild();
			end;
		end;
	end);
end;