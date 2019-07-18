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
	
	PhaseFour.titlesPanel = self;
	
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
	
	local unlockedTitle = false;
	
	local label = vgui.Create("cwInfoText", self);
		label:SetText(L("SomeVictoriesUnlockTitles"));
		label:SetInfoColor("blue");
	self.panelList:AddItem(label);
	
	local titleForm = vgui.Create("cwBasicForm", self);
	titleForm:SetPadding(4);
	titleForm:SetSpacing(4);
	titleForm:SetAutoSize(true);
	titleForm:SetText(L("UnlockedTitles"), nil, "basic_form_highlight");
	
	for k, v in pairs(PhaseFour.victory:GetAll()) do
		if (v.unlockTitle and PhaseFour.victories:Has(k)) then

			local label = vgui.Create("cwInfoText", self);
				label:SetText(string.Replace(L(v.unlockTitle), "%n", Clockwork.Client:Name()));
				label:SetButton(true);
				label:SetInfoColor("orange");
				label:SetShowIcon(false);
			titleForm:AddItem(label);
			
			if (Clockwork.Client:GetSharedVar("title") == k) then
				label:SetInfoColor("green");
			end;
			
			-- Called when the button is clicked.
			function label.DoClick(button)
				Derma_Query(L("AreYouSureSetTitle"), L("SetYourTitle"), L("Yes"), function()
					Clockwork.datastream:Start("SetTitle", k);
				end, L("No"), function() end);
			end;
			
			unlockedTitle = true;
		end;
	end;
	
	if (!unlockedTitle) then
		local label = vgui.Create("cwInfoText", self);
			label:SetText(L("NotUnlockedTitles"));
			label:SetInfoColor("red");
		titleForm:AddItem(label);
	end;

	self.panelList:AddItem(titleForm);
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

vgui.Register("cw_Titles", PANEL, "EditablePanel");