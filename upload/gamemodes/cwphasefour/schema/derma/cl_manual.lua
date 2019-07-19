--[[
	 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()
	local language = CW_CONVAR_LANG:GetString();
	local langCode = "en";
	
	for k, v in pairs(Clockwork.lang.codes) do
		if (v == language) then
			langCode = language;
			break;
		end;
	end;

	self.htmlPanel = vgui.Create("DHTML");
 	self.htmlPanel:SetParent(self);
	self.htmlPanel:OpenURL("http://haven.cloudsixteen.com/docs/phasefour?lang="..langCode);
	
	local width = ScrW() * 0.6;
	local height = ScrH() * 0.8;
	local halfW = ScrW() * 0.5;
	local halfH = ScrH() * 0.5;
	
	self:SetSize(width, height);
	self:SetPos(halfW - (width * 0.5), halfH - (height * 0.5));
	self:MakePopup();
	
	self.button = vgui.Create("DButton", self);
	self.button:SetText("Close");
	self.button:SetSize(100, 32);
	self.button:SetPos((width * 0.5) - 50, height - 48);

	-- Called when the button is clicked.
	function self.button.DoClick(button)
		Clockwork.datastream:Start("ClosedManual", true);
		self:Remove();
	end;
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout()
	local height = ScrH() * 0.8;
	local width = ScrW() * 0.6;
	
	self.htmlPanel:SetPos(4, 4);
	self.htmlPanel:SetSize(width - 8, height - 64);
	
	derma.SkinHook("Layout", "Frame", self);
end;

vgui.Register("cw_Manual", PANEL, "DPanel");