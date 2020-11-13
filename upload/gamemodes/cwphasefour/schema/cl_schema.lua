--[[
	 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

PhaseFour.lastHeartbeatAmount = 0;
PhaseFour.nextHeartbeatCheck = 0;
PhaseFour.heartbeatGradient = Material("gui/gradient_down");
PhaseFour.heartbeatOverlay = Material("effects/combine_binocoverlay");
PhaseFour.heatwaveMaterial = Material("sprites/heatwave");
PhaseFour.heatwaveMaterial:SetFloat("$refractamount", 0);
PhaseFour.fishEyeTexture = Material("models/props_c17/fisheyelens");
PhaseFour.shinyMaterial = Material("models/shiny");
PhaseFour.heartbeatPoints = {};
PhaseFour.allianceData = {};
PhaseFour.nextGetSnipers = 0;
PhaseFour.heartbeatPoint = Material("sprites/glow04_noz");
PhaseFour.targetOutlines = {};
PhaseFour.damageNotify = {};
PhaseFour.laserSprite = Material("sprites/glow04_noz");
PhaseFour.hotkeyItems = Clockwork.kernel:RestoreSchemaData("hotkeys");
PhaseFour.stunEffects = {};

Clockwork.option:SetKey("icon_data_classes", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_settings", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_donations", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_system", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_scoreboard", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_inventory", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_directory", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_attributes", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_business", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_titles", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_bounties", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_alliance", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_auguments", {path = "", size = nil});
Clockwork.option:SetKey("icon_data_victories", {path = "", size = nil});

Clockwork.config:AddToSystem("Intro text small","intro_text_small", "The small text displayed for the introduction.");
Clockwork.config:AddToSystem("Intro text big", "intro_text_big", "The big text displayed for the introduction.");
Clockwork.config:AddToSystem("Alliance cost", "alliance_cost", "The amount of cash it costs to create an alliance.", 0, 10000);
Clockwork.config:AddToSystem("Maximum safebox weight", "max_safebox_weight", "The maximum weight a player's safebox can hold.", 0, 300);

Clockwork.datastream:Hook("Frequency", function(data)
	Derma_StringRequest("Frequency", "What would you like to set the frequency to?", data, function(text)
		Clockwork.kernel:RunCommand("SetFreq", text);
	end);	
end);

Clockwork.datastream:Hook("ShowManual", function(data)
	vgui.Create("cw_Manual");
end);

Clockwork.datastream:Hook("AllyData", function(data)
	PhaseFour.allianceData = data;
	
	if (IsValid(PhaseFour.alliancePanel)) then
		PhaseFour.alliancePanel:Rebuild();
	end;
end);

Clockwork.datastream:Hook("Notepad", function(data)
	if (PhaseFour.notepadPanel and PhaseFour.notepadPanel:IsValid()) then
		PhaseFour.notepadPanel:Close();
		PhaseFour.notepadPanel:Remove();
	end;
	
	PhaseFour.notepadPanel = vgui.Create("cw_Notepad");
	PhaseFour.notepadPanel:Populate(data or "");
	PhaseFour.notepadPanel:MakePopup();
	
	gui.EnableScreenClicker(true);
end);

Clockwork.datastream:Hook("HotkeyMenu", function(data)
	local hotkeyItems = {};
	
	for k, v in pairs(PhaseFour.hotkeyItems) do
		local itemTable = Clockwork.item:FindByID(v);
		
		if (itemTable and itemTable.OnUse) then
			hotkeyItems[#hotkeyItems + 1] = itemTable;
		end;
	end;
	
	if (hotkeyItems) then
		local options = {};
		
		for k, v in ipairs(hotkeyItems) do
			options[k..". "..v.name] = function()
				if (v.OnHandleUse) then
					v:OnHandleUse(function()
						Clockwork.kernel:RunCommand("InvAction", "use", v.uniqueID);
					end);
				else
					Clockwork.kernel:RunCommand("InvAction", "use", v.uniqueID);
				end;
			end;
		end;
		
		PhaseFour.hotkeyMenu = Clockwork.kernel:AddMenuFromData(nil, options);
		
		if (IsValid(PhaseFour.hotkeyMenu)) then
			PhaseFour.hotkeyMenu:SetPos(
				(ScrW() / 2) - (PhaseFour.hotkeyMenu:GetWide() / 2),
				(ScrH() / 2) - (PhaseFour.hotkeyMenu:GetTall() / 2)
			);
		end;
	end;
end);

Clockwork.datastream:Hook("TargetOutline", function(data)
	local curTime = CurTime();
	
	PhaseFour.targetOutlines[data] = curTime + 60;
end);

Clockwork.datastream:Hook("DealDmg", function(data)
	local duration = 2;
	local curTime = UnPredictedCurTime();
	local entity = data[1];
	local amount = data[2];
	
	if (IsValid(entity) and entity:IsPlayer()) then
		PhaseFour.damageNotify[#PhaseFour.damageNotify + 1] = {
			position = entity:GetShootPos() + (Vector() * math.random(-5, 5)),
			duration = duration,
			endTime = curTime + duration,
			color = Color(179, 46, 49, 255),
			text = math.ceil(amount).."dmg"
		};
	end;
end);

Clockwork.datastream:Hook("TakeDmg", function(data)
	local duration = 2;
	local curTime = UnPredictedCurTime();
	local entity = data[1];
	local amount = data[2];
	
	if (IsValid(entity) and entity:IsPlayer()) then
		PhaseFour.damageNotify[#PhaseFour.damageNotify + 1] = {
			position = entity:GetShootPos() + (Vector() * math.random(-5, 5)),
			duration = duration,
			endTime = curTime + duration,
			color = Color(139, 174, 179, 255),
			text = math.ceil(amount).."dmg"
		};
	end;	
end);

Clockwork.datastream:Hook("Disguise", function(data)
	Derma_StringRequest("Disguise", "Enter part of the character's name that you'd like to disguise as.", "", function(text)
		Clockwork.kernel:RunCommand("DisguiseSet", text);
	end);
end);

Clockwork.datastream:Hook("InviteAlliance", function(data)
	Derma_Query("Do you want to join the '"..data.."' alliance?", "Join Alliance", "Yes", function()
		Clockwork.datastream:Start("JoinAlliance", data);
		
		gui.EnableScreenClicker(false);
	end, "No", function()
		gui.EnableScreenClicker(false);
	end);
	
	gui.EnableScreenClicker(true);
end);

Clockwork.datastream:Hook("AllyKick", function(data)
	data:SetSharedVar("alliance", "");
	data:SetSharedVar("rank", RANK_RCT);
	
	if (IsValid(PhaseFour.alliancePanel)) then
		PhaseFour.alliancePanel:Rebuild();
	end;
end);

Clockwork.datastream:Hook("AllySetRank", function(data)
	data[1]:SetSharedVar("rank", data[2]);
	
	if (IsValid(PhaseFour.alliancePanel)) then
		PhaseFour.alliancePanel:Rebuild();
	end;
end);

Clockwork.datastream:Hook("CreateAlliance", function(data)
	Derma_StringRequest("Alliance", "What is the name of the alliance?", nil, function(text)
		Clockwork.datastream:Start("CreateAlliance", text);
	end);
end);

Clockwork.datastream:Hook("Death", function(data)
	if (type(data) == "boolean" or !IsValid(data)) then
		PhaseFour.deathType = "UNKNOWN CAUSES";
	else
		local itemTable = Clockwork.item:GetByWeapon(data);
		local class = data:GetClass();
		
		if (itemTable) then
			PhaseFour.deathType = "A "..string.upper(itemTable("name"));
		elseif (class == "cw_hands") then
			PhaseFour.deathType = "BEING PUNCHED TO DEATH";
		else
			PhaseFour.deathType = "UNKNOWN CAUSES";
		end;
	end;
end);

Clockwork.datastream:Hook("ShotEffect", function(data)
	local curTime = CurTime();
	
	if (!data or data == 0) then
		data = 0.5;
	end;
	
	PhaseFour.shotEffect = {curTime + data, data};
end);

Clockwork.datastream:Hook("TearGassed", function(data)
	PhaseFour.tearGassed = CurTime() + 20;
end);

Clockwork.datastream:Hook("Stunned", function(data)
	local curTime = CurTime();
	local duration = 0.5;
	
	PhaseFour.stunEffects[#PhaseFour.stunEffects + 1] = {curTime + duration, duration};
	PhaseFour.flashEffect = {curTime + (duration * 2), duration * 2, true};
end);

Clockwork.datastream:Hook("Flashed", function(data)
	local curTime = CurTime();
	
	PhaseFour.stunEffects[#PhaseFour.stunEffects + 1] = {curTime + 10, 10};
	PhaseFour.flashEffect = {curTime + 20, 20};
	
	surface.PlaySound("hl1/fvox/flatline.wav");
end);

Clockwork.datastream:Hook("ClearEffects", function(data)
	PhaseFour.stunEffects = {};
	PhaseFour.flashEffect = nil;
	PhaseFour.tearGassed = nil;
	PhaseFour.shotEffect = nil;
end);

Clockwork.chatBox:RegisterClass("alliance", "ic", function(info)
	Clockwork.chatBox:Add(info.filtered, nil, "(Alliance) ", Color(209, 172, 238, 255), info.name.." says \""..info.text.."\"");
end);

Clockwork.chatBox:RegisterClass("advert", "ic", function(info)
	Clockwork.chatBox:Add(info.filtered, nil, "(Advert) ", Color(226, 98, 107, 255), info.text);
end);

Clockwork.chatBox:RegisterClass("radio", "ic", function(info)
	Clockwork.chatBox:Add(info.filtered, nil, Color(75, 150, 50, 255), info.name.." radios in \""..info.text.."\"");
end);

Clockwork.chatBox:RegisterClass("victory", "ooc", function(info)
	Clockwork.chatBox:Add(info.filtered, "icon16/star.png", info.speaker, " has achieved the ", Color(139, 174, 179, 255), info.text, " victory!");
end);

Clockwork.chatBox:RegisterClass("bounty", "ooc", function(info)
	Clockwork.chatBox:Add(info.filtered, nil, info.speaker, " has been given a new bounty. Their total bounty is ", Color(139, 174, 179, 255), tostring(Clockwork.kernel:FormatCash(tonumber(info.text), nil, true)), "!");
end);

Clockwork.chatBox:RegisterClass("killed", "ooc", function(info)
	local victim = info.data.victim;
	
	if (IsValid(victim)) then
		Clockwork.chatBox:Add(info.filtered, nil, victim, " has been killed by ", info.speaker, " (investigate the death).");
	end;
end);

local playerMeta = FindMetaTable("Player");

-- A function to get whether a player is good.
function playerMeta:IsGood()
	return self:GetSharedVar("honor") >= 50;
end;

-- A function to get whether a player is bad.
function playerMeta:IsBad()
	return self:GetSharedVar("honor") < 50;
end;

-- A function to get a player's bounty.
function playerMeta:GetBounty()
	return self:GetSharedVar("bounty");
end;

-- A function to get whether a player is wanted.
function playerMeta:IsWanted()
	return self:GetSharedVar("bounty") > 0;
end;

-- A function to get whether a player is a leader.
function playerMeta:IsLeader()
	return self:GetSharedVar("rank") == RANK_MAJ;
end;

-- A function to get a player's rank.
function playerMeta:GetRank(bString)
	local rank = self:GetSharedVar("rank");
	
	if (bString) then
		if (rank == RANK_PVT) then
			return "Pvt";
		elseif (rank == RANK_SGT) then
			return "Sgt";
		elseif (rank == RANK_LT) then
			return "Lt";
		elseif (rank == RANK_CPT) then
			return "Cpt";
		elseif (rank == RANK_MAJ) then
			return "Maj";
		else
			return "Rct";
		end;
	else
		return rank;
	end;
end;

-- A function to get a player's alliance.
function playerMeta:GetAlliance()
	local alliance = self:GetSharedVar("alliance");
	
	if (alliance != "") then
		return alliance;
	end;
end;

-- Called when a player presses a bind.
function PhaseFour:PlayerBindPress(player, bind, bPress)
	if (string.find(bind, "+attack") or string.find(bind, "+attack2")) then
		local activeWeapon = player:GetActiveWeapon();

		if (IsValid(activeWeapon)) then
			local weaponItem = Clockwork.item:GetByWeapon(activeWeapon);

			if (weaponItem) then
				local durability = weaponItem:GetData("Durability");

				if (durability and durability <= 0) then
					Clockwork.kernel:RunCommand("NotifyBrokenWeapon");
				end;
			end;
		end;
	end;
end;

-- A function to get whether a text entry is being used.
function PhaseFour:IsTextEntryBeingUsed()
	if (self.textEntryFocused) then
		if (self.textEntryFocused:IsValid() and self.textEntryFocused:IsVisible()) then
			return true;
		end;
	end;
end;

local OUTLINE_MATERIAL = Material("white_outline");

-- A function to draw a basic outline.
function PhaseFour:DrawBasicOutline(entity, forceColor, throughWalls)
	local entityColor = entity:GetColor();
	local outlineColor = forceColor or Color(255, 0, 255, 255);
	
	if (throughWalls) then
		cam.IgnoreZ(true);
	end;
	
	render.SuppressEngineLighting(true);
	render.SetColorModulation(outlineColor.r / 255, outlineColor.g / 255, outlineColor.b / 255);
	render.SetAmbientLight(1, 1, 1);
	render.SetBlend(outlineColor.a / 255);
		entity:SetModelScale(1.025, 0);
			render.MaterialOverride(OUTLINE_MATERIAL);
				entity:DrawModel();
			render.MaterialOverride(nil);
		entity:SetModelScale(1, 0);
	render.SetBlend(1);
	render.SetColorModulation(entityColor.r / 255, entityColor.g / 255, entityColor.b / 255);
	render.SuppressEngineLighting(false);
	
	if (!throughWalls) then
		entity:DrawModel();
	else
		cam.IgnoreZ(false);
	end;
end;
