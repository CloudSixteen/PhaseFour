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
	
	PhaseFour.bountyPanel = self;
	
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
	
	local highestBounties = {};
	local bountyPlayers = {};
	
	for k, v in ipairs(_player.GetAll()) do
		if (v:HasInitialized() and v:IsWanted()) then
			bountyPlayers[#bountyPlayers + 1] = {
				bounty = v:GetBounty(),
				player = v
			};
		end;
	end;
	
	table.sort(bountyPlayers, function(a, b)
		return a.bounty > b.bounty;
	end);
	
	for k, v in ipairs(bountyPlayers) do
		if (k <= 10) then
			highestBounties[#highestBounties + 1] = v;
		end;
	end;
	
	local addForm = vgui.Create("cwBasicForm", self);
	addForm:SetPadding(4);
	addForm:SetSpacing(4);
	addForm:SetAutoSize(true);
	addForm:SetText(L("AddBounty"), nil, "basic_form_highlight");
	
	local textEntry = addForm:TextEntry("Name");
	textEntry:SetToolTip(L("TypePlayerNameHere"));
	
	local bountyWang = addForm:NumberWang("Bounty", nil, 100, 10000, 0);
	bountyWang:SetValue(100);
	
	local okayButton = addForm:Button("Okay");
	
	-- Called when the button is clicked.
	function okayButton.DoClick(okayButton)
		Clockwork.datastream:Start("BountyAdd", {
			name = textEntry:GetValue(),
			bounty = bountyWang:GetValue()
		});
	end;
	
	self.panelList:AddItem(addForm);
	
	if (#highestBounties > 0) then
		local label = vgui.Create("cwInfoText", self);
			label:SetText(L("BountyCollectHelp"));
			label:SetInfoColor("blue");
		self.panelList:AddItem(label);
		
		local bountyForm = vgui.Create("cwBasicForm", self);
		bountyForm:SetPadding(4);
		bountyForm:SetSpacing(4);
		bountyForm:SetAutoSize(true);
		bountyForm:SetText(L("TopTenBounties"), nil, "basic_form_highlight");
		
		local panelList = vgui.Create("DPanelList", self);
		
		for k, v in ipairs(highestBounties) do
			local label = vgui.Create("cwInfoText", self);
				label:SetText(v.player:Name());
				label:SetToolTip(L("PlayerHasBountyOf", Clockwork.kernel:FormatCash(v.bounty, nil, true)));
				label:SetInfoColor(_team.GetColor(v.player:Team()));
			panelList:AddItem(label);
		end;
		
		panelList:SetAutoSize(true);
		panelList:SetPadding(4);
		panelList:SetSpacing(4);
		
		bountyForm:AddItem(panelList);
		
		self.panelList:AddItem(bountyForm);
	else
		local label = vgui.Create("cwInfoText", self);
			label:SetText(L("NoBountiesAssigned"));
			label:SetInfoColor("orange");
		self.panelList:AddItem(label);
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

vgui.Register("cw_Bounties", PANEL, "EditablePanel");