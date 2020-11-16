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
	
	PhaseFour.victories.panel = self;
	
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
	
	local victoryForm = vgui.Create("cwBasicForm", self);
	
	victoryForm:SetPadding(4);
	victoryForm:SetSpacing(4);
	victoryForm:SetAutoSize(true);
	victoryForm:SetText(L("Victories"), nil, "basic_form_highlight");
	
	for k, v in pairs(PhaseFour.victory:GetAll()) do
		self.currentVictory = v;
		victoryForm:AddItem(vgui.Create("cw_Victory"));
	end;
	
	self.panelList:AddItem(victoryForm);
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

vgui.Register("cw_Victories", PANEL, "EditablePanel");

local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), 34);
	
	self.victory = PhaseFour.victories:GetPanel().currentVictory;
	self.nameLabel = vgui.Create("DLabel", self);
	self.nameLabel:SetText(L(self.victory.name));
	self.nameLabel:SetDark(true);
	self.nameLabel:SizeToContents();
	
	self.progressBar = vgui.Create("DPanel", self);
	self.progressBar:SetPos(36, 20);
	self.progressBar:SetSize(self:GetWide() - 38, 12);
	
	self.progressLabel = vgui.Create("DLabel", self.progressBar);
	self.progressLabel:SetText(L("VictoryProgress", "0", "0"));
	self.progressLabel:SizeToContents();
	self.progressLabel:SetExpensiveShadow(1, Color(0, 0, 0, 150));
	
	self.spawnIcon = Clockwork.kernel:CreateMarkupToolTip(vgui.Create("DImageButton", self));
	
	if (self.victory.reward) then
		self.spawnIcon:SetToolTip(L(self.victory.description).."\n"..L("ReceiveRewardOf", self.victory.reward));
	else
		self.spawnIcon:SetToolTip(L(self.victory.description));
	end;
	
	self.spawnIcon:SetSize(32, 32);
	
	if (PhaseFour.victories:Has(self.victory.name)) then
		self.spawnIcon:SetImage("victories/achieved.png");
	else
		self.spawnIcon:SetImage(self.victory.image..".png");
	end;
	
	self.spawnIcon.OnMouseReleased = function() end;
	self.spawnIcon.OnMousePressed = function() end;
	self.spawnIcon:SetCursor("none");
	
	-- Called when the panel should be painted.
	function self.progressBar.Paint(progressBar)
		local color = table.Copy(derma.Color("bg_color", self) or Color(100, 100, 100, 255));
		
		if (color) then
			color.r = math.min(color.r - 25, 255);
			color.g = math.min(color.g - 25, 255);
			color.b = math.min(color.b - 25, 255);
		end;
		
		Clockwork.kernel:DrawSimpleGradientBox(0, 0, 0, progressBar:GetWide(), progressBar:GetTall(), color);
		
		local progress = PhaseFour.victories:Get(self.victory.name);
		local maximum = self.victory.maximum;
		local width = math.Clamp((progressBar:GetWide() / maximum) * progress, 0, progressBar:GetWide());
		
		Clockwork.kernel:DrawSimpleGradientBox(0, 0, 0, width, progressBar:GetTall(), Color(139, 215, 113, 255));
	end;
end;

-- Called each frame.
function PANEL:Think()
	self.progressLabel:SetText(L("VictoryProgress", PhaseFour.victories:Get(self.victory.name), self.victory.maximum));
	self.progressLabel:SizeToContents();
	self.spawnIcon:SetPos(1, 1);
	self.spawnIcon:SetSize(32, 32);
	
	self.progressLabel:SetPos(
		self.progressBar:GetWide() - self.progressLabel:GetWide() - 8,
		(self.progressBar:GetTall() / 2) - (self.progressLabel:GetTall() / 2) - 1
	);
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout()
	self.spawnIcon:SetPos(1, 1);
	self.spawnIcon:SetSize(32, 32);
	self.nameLabel:SetPos(36, 2);
	self.nameLabel:SizeToContents();
	self.progressBar:SetSize(self:GetWide() - 38, 12);
end;

vgui.Register("cw_Victory", PANEL, "DPanel");
