--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local PANEL = {};

AccessorFunc(PANEL, "m_bPaintBackground", "PaintBackground");
AccessorFunc(PANEL, "m_bgColor", "BackgroundColor");
AccessorFunc(PANEL, "m_bDisabled", "Disabled");

-- Called when the panel is initialized.
function PANEL:Init()
	self:SetSize(Clockwork.menu:GetWidth(), Clockwork.menu:GetHeight());
	
	self.panelList = vgui.Create("cwPanelList", self);
 	self.panelList:SetPadding(8);
 	self.panelList:SetSpacing(4);
 	self.panelList:StretchToParent(4, 4, 4, 4);
	self.panelList:HideBackground();
	self.panelList:EnableVerticalScrollbar();
	
	PhaseFour.alliancePanel = self;
	
	self:Rebuild();
end;

-- Called when the panel is painted.
function PANEL:Paint(w, h)
	DERMA_SLICED_BG:Draw(0, 0, w, h, 8, COLOR_WHITE);
	
	return true;
end;

-- A function to rebuild the panel.
function PANEL:Rebuild()
	self.panelList:Clear(true);
	
	local myAlliance = Clockwork.Client:GetAlliance();
	
	if (myAlliance) then
		local label = vgui.Create("cwInfoText", self);
			label:SetText("Click here if you want to leave the alliance permanently.");
			label:SetButton(true);
			label:SetInfoColor("red");
		self.panelList:AddItem(label);
		
		local allianceCash = 0;
		
		if (PhaseFour.allianceData) then
			PrintTable(PhaseFour.allianceData);
		end;
		
		if (PhaseFour.allianceData and PhaseFour.allianceData.cash != nil) then
			allianceCash = tonumber(PhaseFour.allianceData.cash);
		end;
	
		local bankWang = vgui.Create("DNumberWang", self);
		local bankForm = vgui.Create("cwBasicForm", self);
		
		bankForm:SetPadding(8);
		bankForm:SetSpacing(8);
		bankForm:SetAutoSize(true);
		bankForm:SetText("Bank: "..Clockwork.kernel:FormatCash(allianceCash), nil, "basic_form_highlight");
		bankForm:Help("Only members ranked Sergeant or above can withdraw from the bank.")
		
		local depositButton = vgui.Create("DButton", self);
		
		depositButton:SetText("Deposit");
		
		-- Called when the button is clicked.
		function depositButton.DoClick(depositButton)
			Clockwork.datastream:Start("BankDeposit", {
				amount = bankWang:GetValue()
			});
		end;
		
		local withdrawButton = nil;
		
		if (Clockwork.Client:GetSharedVar("rank") >= RANK_SGT) then
			withdrawButton = vgui.Create("DButton", self);
			withdrawButton:SetText("Withdraw");
			
			-- Called when the button is clicked.
			function withdrawButton.DoClick(depositButton)
				Clockwork.datastream:Start("BankWithdraw", {
					amount = bankWang:GetValue()
				});
			end;
		end;
		
		bankWang:SetDecimals(0);
		bankWang:SetValue(allianceCash);
		
		bankForm:AddItem(bankWang);
		bankForm:AddItem(depositButton);
		
		if (withdrawButton) then
			bankForm:AddItem(withdrawButton);
		end;
		
		self.panelList:AddItem(bankForm);
		
		-- Called when the button is clicked.
		function label.DoClick(button)
			Derma_Query("Are you sure that you want to leave the alliance?", "Leave the alliance.", "Yes", function()
				Clockwork.kernel:RunCommand("AllyLeave");
			end, "No", function() end);
		end;
		
		local alliancePlayers = {};
		
		for k, v in ipairs(_player.GetAll()) do
			if (v:HasInitialized()) then
				local playerAlliance = v:GetAlliance();
				
				if (playerAlliance and playerAlliance == myAlliance) then
					alliancePlayers[#alliancePlayers + 1] = v;
				end;
			end;
		end;
		
		table.sort(alliancePlayers, function(a, b)
			return a:GetRank() > b:GetRank();
		end);
		
		if (#alliancePlayers > 0) then
			local allianceForm = vgui.Create("cwBasicForm", self);
			allianceForm:SetPadding(4);
			allianceForm:SetSpacing(8);
			allianceForm:SetAutoSize(true);
			allianceForm:SetText(myAlliance, nil, "basic_form_highlight");
			
			local panelList = vgui.Create("DPanelList", self);
			
			for k, v in ipairs(alliancePlayers) do
				local label = vgui.Create("cwInfoText", self);
					label:SetText(v:GetRank(true)..". "..v:Name());
					label:SetInfoColor(_team.GetColor(v:Team()));
				panelList:AddItem(label);
				
				if (Clockwork.Client:IsLeader()) then
					label:SetButton(true);
					
					-- Called when the button is clicked.
					function label.DoClick(button)
						if (IsValid(v) and !v:IsLeader()) then
							local options = {};
							
							options["Kick"] = function()
								Clockwork.datastream:Start("AllyKick", v);
							end;
							
							options["Rank"] = {};
							options["Rank"]["1. Recruit"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_RCT});
							end;
							options["Rank"]["2. Private"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_PVT});
							end;
							options["Rank"]["3. Sergeant"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_SGT});
							end;
							options["Rank"]["4. Lieutenant"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_LT});
							end;
							options["Rank"]["5. Captain"] = function()
								Clockwork.datastream:Start("AllySetRank", {v, RANK_CPT});
							end;
							options["Rank"]["6. Major"] = function()
								Derma_Query("Are you sure that you want to make them a leader?", "Make them a leader.", "Yes", function()
									Clockwork.datastream:Start("AllyMakeLeader", v);
								end, "No", function() end);
							end;
							
							Clockwork.kernel:AddMenuFromData(nil, options);
						end;
					end;
				end;
			end;
			
			panelList:SetAutoSize(true);
			panelList:SetPadding(4);
			panelList:SetSpacing(4);
			
			allianceForm:AddItem(panelList);
			
			self.panelList:AddItem(allianceForm);
		else
			local label = vgui.Create("cwInfoText", self);
				label:SetText("No characters in your alliance are playing.");
				label:SetInfoColor("orange");
			self.panelList:AddItem(label);
		end;
	else
		local label = vgui.Create("cwInfoText", self);
			label:SetText("Creating an alliance will cost you "..Clockwork.kernel:FormatCash(Clockwork.config:Get("alliance_cost"):Get(), nil, true)..".");
			label:SetInfoColor("blue");
		self.panelList:AddItem(label);
		
		local createForm = vgui.Create("cwBasicForm", self);
		createForm:SetPadding(4);
		createForm:SetSpacing(8);
		createForm:SetAutoSize(true);
		createForm:SetText("Create Alliance", nil, "basic_form_highlight");
	
		local textEntry = createForm:TextEntry("Name");
			textEntry:SetToolTip("Choose a nice name for your alliance.");
		local okayButton = createForm:Button("Okay");
		
		-- Called when the button is clicked.
		function okayButton.DoClick(okayButton)
			Clockwork.datastream:Start("CreateAlliance", textEntry:GetValue());
		end;
		
		self.panelList:AddItem(createForm);
	end;

	self.panelList:InvalidateLayout(true);
end;

-- Called when the menu is opened.
function PANEL:OnMenuOpened()
	if (Clockwork.menu:GetActivePanel() == self) then
		self:Rebuild();
	end;
end;

-- Called when the panel is selected.
function PANEL:OnSelected() self:Rebuild(); end;

-- Called when the layout should be performed.
function PANEL:PerformLayout() end;

-- Called each frame.
function PANEL:Think()
	self:InvalidateLayout(true);
end;

vgui.Register("cw_Alliance", PANEL, "EditablePanel");