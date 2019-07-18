--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

PhaseFour.victories = {};

if (SERVER) then
	function PhaseFour.victories:Progress(player, victory, progress)
		local victoryTable = PhaseFour.victory:Get(victory);
		local victories = player:GetCharacterData("victories");
		
		if (!progress) then
			progress = 1;
		end;
		
		if (victoryTable) then
			if (!victories[victoryTable.uniqueID]) then
				victories[victoryTable.uniqueID] = 0;
			end;
			
			local currentVictory = victories[victoryTable.uniqueID];
			
			if (currentVictory < victoryTable.maximum) then
				victories[victoryTable.uniqueID] = math.Clamp(currentVictory + progress, 0, victoryTable.maximum);
				
				if (victories[victoryTable.uniqueID] == victoryTable.maximum) then
					Clockwork.chatBox:Add(nil, player, "victory", victoryTable.name);
					
					if (victoryTable.reward) then
						Clockwork.player:GiveCash(player, victoryTable.reward, victoryTable.name);
					end;
					
					if (victoryTable.OnAchieved) then
						victoryTable:OnAchieved(player);
					end;
				end;
			end;
			
			Clockwork.datastream:Start(player, "VictoriesProgress", { victoryTable.index, victories[victoryTable.uniqueID] });
		else
			return false, {"NotValidVictory"};
		end;
	end;
	
	-- A function to get whether a player has a victory.
	function PhaseFour.victories:Has(player, victory)
		local victoryTable = PhaseFour.victory:Get(victory);
		
		if (victoryTable) then
			if (PhaseFour.victories:Get(player, victory) == victoryTable.maximum) then
				return true;
			end;
		end;
		
		return false;
	end;
	
	-- A function to get a player's victory.
	function PhaseFour.victories:Get(player, victory)
		local victoryTable = PhaseFour.victory:Get(victory);
		local victories = player:GetCharacterData("victories");
		
		if (victoryTable) then
			return victories[victoryTable.uniqueID] or 0;
		else
			return 0;
		end;
	end;
else
	PhaseFour.victories.stored = {};
	
	-- A function to get the victories panel.
	function PhaseFour.victories:GetPanel()
		return self.panel;
	end;
	
	-- A function to get the local player's victory.
	function PhaseFour.victories:Get(victory)
		local victoryTable = PhaseFour.victory:Get(victory);
		
		if (victoryTable) then
			return self.stored[victoryTable.uniqueID] or 0;
		else
			return 0;
		end;
	end;
	
	-- A function to get whether the local player has a victory.
	function PhaseFour.victories:Has(victory)
		local victoryTable = PhaseFour.victory:Get(victory);
		
		if (victoryTable) then
			if (PhaseFour.victories:Get(victory) == victoryTable.maximum) then
				return true;
			end;
		end;
		
		return false;
	end;

	Clockwork.datastream:Hook("VictoriesProgress", function(data)
		local victory = data[1];
		local progress = data[2];
		local victoryTable = PhaseFour.victory:Get(victory);
		
		if (victoryTable) then
			PhaseFour.victories.stored[victoryTable.uniqueID] = progress;
			
			if (Clockwork.menu:GetOpen()) then
				local panel = PhaseFour.victories:GetPanel();
				
				if (panel and Clockwork.menu:GetActivePanel() == panel) then
					panel:Rebuild();
				end;
			end;
		end;
	end);

	Clockwork.datastream:Hook("VictoriesClear", function(data)
		PhaseFour.victories.stored = {};
		
		if (Clockwork.menu:GetOpen()) then
			local panel = PhaseFour.victories:GetPanel();
			
			if (panel and Clockwork.menu:GetActivePanel() == panel) then
				panel:Rebuild();
			end;
		end;
	end);
end;