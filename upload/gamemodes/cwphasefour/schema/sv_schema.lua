--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

Clockwork.kernel:AddFile("materials/models/weapons/temptexture/handsmesh1.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/temptexture/handsmesh1.vmt");
Clockwork.kernel:AddFile("models/weapons/v_sledgehammer/v_sledgehammer.mdl");
Clockwork.kernel:AddFile("materials/models/props_lab/exp_objects01.vtf");
Clockwork.kernel:AddFile("materials/models/props_lab/exp_objects01.vmt");
Clockwork.kernel:AddFile("materials/models/items/ammocrate_safebox.vtf");
Clockwork.kernel:AddFile("materials/models/items/ammocrate_safebox.vmt");
Clockwork.kernel:AddFile("materials/models/items/itemcrate_exper.vtf");
Clockwork.kernel:AddFile("materials/models/items/itemcrate_exper.vmt");
Clockwork.kernel:AddFile("models/humans/group03/male_experim.mdl");
Clockwork.kernel:AddFile("materials/models/weapons/v_katana/katana.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/v_katana/katana.vmt");
Clockwork.kernel:AddFile("models/items/ammocrate_safebox.mdl");
Clockwork.kernel:AddFile("models/items/item_item_exper.mdl");
Clockwork.kernel:AddFile("materials/victories/achieved.png");
Clockwork.kernel:AddFile("materials/augments/augmented.png");
Clockwork.kernel:AddFile("models/weapons/v_shovel/v_shovel.mdl");
Clockwork.kernel:AddFile("models/weapons/v_axe/v_axe.mdl");
Clockwork.kernel:AddFile("materials/models/weapons/sledge.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/sledge.vmt");
Clockwork.kernel:AddFile("materials/models/weapons/shovel.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/shovel.vmt");
Clockwork.kernel:AddFile("materials/models/weapons/axe.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/axe.vmt");
Clockwork.kernel:AddFile("models/weapons/w_sledgehammer.mdl");
Clockwork.kernel:AddFile("materials/phasefour/infotext/red.png");
Clockwork.kernel:AddFile("materials/phasefour/infotext/green.png");
Clockwork.kernel:AddFile("materials/phasefour/infotext/orange.png");
Clockwork.kernel:AddFile("materials/phasefour/infotext/blue.png");
Clockwork.kernel:AddFile("materials/phasefour/bg_gradient.png");
Clockwork.kernel:AddFile("materials/phasefour/scratch.png");
Clockwork.kernel:AddFile("materials/phasefour/simpledark2.png");
Clockwork.kernel:AddFile("materials/phasefour/simpledark.png");
Clockwork.kernel:AddFile("materials/phasefour/simplered.png");
Clockwork.kernel:AddFile("materials/phasefour/simpletint.png");
Clockwork.kernel:AddFile("materials/phasefour/dirty.png");
Clockwork.kernel:AddFile("materials/icon16/star.png");
Clockwork.kernel:AddFile("resource/fonts/rakesly.ttf");
Clockwork.kernel:AddFile("models/pmc/pmc_4/pmc__07.mdl");
Clockwork.kernel:AddFile("models/props_lab/exp01a.mdl");
Clockwork.kernel:AddFile("models/weapons/w_katana.mdl");
Clockwork.kernel:AddFile("models/weapons/v_katana.mdl");
Clockwork.kernel:AddFile("models/weapons/w_shovel.mdl");
Clockwork.kernel:AddFile("models/tactical_rebel.mdl");
Clockwork.kernel:AddFile("models/weapons/w_axe.mdl");
Clockwork.kernel:AddFile("models/riot_ex2.mdl");
Clockwork.kernel:AddFile("models/sprayca2.mdl");
Clockwork.kernel:AddFile("models/spx7.mdl");
Clockwork.kernel:AddFile("models/spx2.mdl");
Clockwork.kernel:AddFile("models/spex.mdl");

Clockwork.kernel:AddDirectory("materials/models/player/slow/aot/salem/");
Clockwork.kernel:AddDirectory("materials/models/player/slow/napalm_atc/");
Clockwork.kernel:AddDirectory("materials/models/player/slow/nailgunner/");
Clockwork.kernel:AddDirectory("materials/models/player/slow/bio_suit/");
Clockwork.kernel:AddDirectory("materials/models/humans/male/group01/labcit*.*");
Clockwork.kernel:AddDirectory("materials/models/humans/female/group01/labcit*.*");
Clockwork.kernel:AddDirectory("materials/models/humans/male/experim/");
Clockwork.kernel:AddDirectory("materials/models/player/riex/");
Clockwork.kernel:AddDirectory("materials/models/pmc/pmc_shared/");
Clockwork.kernel:AddDirectory("materials/models/gasmask/tac_rbe/");
Clockwork.kernel:AddDirectory("materials/models/kevlarvest/");
Clockwork.kernel:AddDirectory("materials/models/stalker/sx/");
Clockwork.kernel:AddDirectory("materials/models/stalker/mx/");
Clockwork.kernel:AddDirectory("materials/models/stalker/fx/");
Clockwork.kernel:AddDirectory("materials/models/stalker/dx/");
Clockwork.kernel:AddDirectory("materials/models/banditv/");
Clockwork.kernel:AddDirectory("materials/models/pmc/pmc_4/");
Clockwork.kernel:AddDirectory("materials/phasefour/menuitems/");
Clockwork.kernel:AddDirectory("materials/phasefour/icons/");
Clockwork.kernel:AddDirectory("materials/models/h3_spartan/");
Clockwork.kernel:AddDirectory("models/humans/group60/*.mdl");
Clockwork.kernel:AddDirectory("models/humans/group61/*.mdl");
Clockwork.kernel:AddDirectory("models/humans/group62/*.mdl");
Clockwork.kernel:AddDirectory("models/kevlarvest/*.mdl");
Clockwork.kernel:AddDirectory("materials/victories/");
Clockwork.kernel:AddDirectory("models/napalm_atc/*.mdl");
Clockwork.kernel:AddDirectory("models/nailgunner/*.mdl");
Clockwork.kernel:AddDirectory("materials/augments/");
Clockwork.kernel:AddDirectory("models/salem/*.mdl");
Clockwork.kernel:AddDirectory("models/bio_suit/*.mdl");
Clockwork.kernel:AddDirectory("models/srp/*.mdl");

Clockwork.config:Add("intro_text_small", "You find it's just as screwed up outside.", true);
Clockwork.config:Add("intro_text_big", "WHEN YOU LEAVE THE CONFINES OF THE LAB", true);
Clockwork.config:Add("enable_prop_damage", true);
Clockwork.config:Add("alliance_cost", 1000, true);
Clockwork.config:Add("allow_flashlight", true);
Clockwork.config:Add("max_safebox_weight", 60, true);

Clockwork.config:Get("scale_attribute_progress"):Set(0.5);
Clockwork.config:Get("enable_gravgun_punt"):Set(false);
Clockwork.config:Get("default_inv_weight"):Set(8);
Clockwork.config:Get("armor_chest_only"):Set(false);
Clockwork.config:Get("enable_crosshair"):Set(false);
Clockwork.config:Get("minimum_physdesc"):Set(16);
Clockwork.config:Get("scale_prop_cost"):Set(0.2);
Clockwork.config:Get("scale_head_dmg"):Set(2);
Clockwork.config:Get("disable_sprays"):Set(false);
Clockwork.config:Get("wages_interval"):Set(360);
Clockwork.config:Get("default_cash"):Set(120);

Clockwork.hint:Add("Admins", "The admins are here to help you, please respect them.");
Clockwork.hint:Add("Grammar", "Try to speak correctly in-character, and don't use emoticons.");
Clockwork.hint:Add("Healing", "You can heal players by using the Give command in your belongings.");
Clockwork.hint:Add("Healing", "You will gain honor for healing good characters with medical equipment.");
--Clockwork.hint:Add("Zip Tie", "Press F3 while looking at a character to use a zip tie.");
Clockwork.hint:Add("Alliance", "You can create an alliance by using the command $command_prefix$AllyCreate.");
Clockwork.hint:Add("F4 Hotkey", "Press F4 to open up the hotkey menu, you can bind hotkeys in your belongings.");
Clockwork.hint:Add("Search Char", "Press F3 while looking at a tied character to search them.");

Clockwork.datastream:Hook("ClosedManual", function(player, data)
	if (!player.cwPhaseFourReady) then
		player.cwPhaseFourReady = true;
		Clockwork.plugin:Call("PhaseFourPlayerReady", player);
	end;
end);

Clockwork.datastream:Hook("JoinAlliance", function(player, data)
	if (player.allianceAuthenticate != data) then
		return;
	end;
	
	local allianceName = Clockwork.database:Escape(string.gsub(string.sub(data, 1, 32), "[%p%d]", ""));
	
	PhaseFour:LeaveAlliance(player, function()
		PhaseFour:JoinAlliance(player, allianceName, function()
			local alliances = player:GetTempData("alliances");
			
			if (!alliances) then
				player:SetTempData("alliances", {});
				alliances = player:GetTempData("alliances");
			end;
			
			if (!alliances[data] and IsValid(player.allianceInviter)) then
				PhaseFour.victories:Progress(player.allianceInviter, VIC_THEDON);
				PhaseFour.victories:Progress(player.allianceInviter, VIC_CONFEDERACY);
				alliances[data] = true;
			end;
			
			Clockwork.player:Notify(player, "You have joined the '"..data.."' alliance.");
		end);
	end);
end);

Clockwork.datastream:Hook("Notepad", function(player, data)
	if (type(data) == "string" and player:HasItemByID("notepad")) then
		player:SetCharacterData("notepad", string.sub(data, 0, 500));
	end;
end);

Clockwork.datastream:Hook("SetTitle", function(player, data)
	if (type(data) == "string") then
		local victoryTable = PhaseFour.victory:Get(data);
		
		if (victoryTable and victoryTable.unlockTitle) then
			if (PhaseFour.victories:Has(player, data)) then
				player:SetCharacterData("title", victoryTable.uniqueID);
				Clockwork.player:Notify(player, "You have set your title to "..string.Replace(victoryTable.unlockTitle, "%n", player:Name())..".");
			end;
		end;
	end;
end);

Clockwork.datastream:Hook("UpgradeWeapon", function(player, data)
	local itemTable = Clockwork.item:FindInstance(data.itemID);
	if (not itemTable) then return; end;
	
	local itemLevel = itemTable:GetData("Level");
	
	if (itemLevel >= 10) then
		return;
	end;
	
	local cost = (itemTable("cost") / 4) * itemLevel;
	
	if (!Clockwork.player:CanAfford(player, cost)) then
		Clockwork.player:Notify(player, {"SalesmenYouNeedAnother", Clockwork.kernel:FormatCash(cost - player:GetCash(), nil, true)});
	else
		Clockwork.player:GiveCash(player, -cost, "upgrading a weapon");
		Clockwork.player:Notify(player, "You have upgraded this weapon to level "..(itemLevel + 1)..".");
		itemTable:SetData("Level", itemLevel + 1);
	end;
end);

Clockwork.datastream:Hook("UpgradeArmor", function(player, data)
	local itemTable = Clockwork.item:FindInstance(data.itemID);
	if (not itemTable) then return; end;
	
	local itemLevel = itemTable:GetData("Level");
	if (itemLevel >= 10) then return; end;
	
	local engRequired = math.floor(math.Clamp(itemLevel * 5, 0, 50));
	local engineering = Clockwork.attributes:Fraction(player, ATB_ENGINEERING, 50, 50);
	local cost = itemLevel * 500;
	
	if (engineering < engRequired) then
		Clockwork.player:Notify(player, "You need an engineering level of "..((100 / 50) * engRequired).."% to upgrade this!");
	elseif (!Clockwork.player:CanAfford(player, cost)) then
		Clockwork.player:Notify(player, "You need another "..Clockwork.kernel:FormatCash(cost - player:GetCash(), nil, true).."!");
	else
		Clockwork.player:GiveCash(player, -cost, "upgrading some armor");
		Clockwork.player:Notify(player, "You have upgraded this armor to level "..(itemLevel + 1)..".");
		itemTable:SetData("Level", itemLevel + 1);
	end;
end);

Clockwork.datastream:Hook("BountyAdd", function(player, data)
	Clockwork.player:RunClockworkCommand(player, "Bounty", tostring(data.name), tostring(data.bounty));
end);

Clockwork.datastream:Hook("GetAugment", function(player, data)
	local augmentTable = PhaseFour.augment:Get(data);
	
	if (augmentTable) then
		if (Clockwork.player:CanAfford(player, augmentTable.cost)) then
			if (!PhaseFour.augments:Has(player, augmentTable.uniqueID)) then
				PhaseFour.augments:Give(player, augmentTable.uniqueID);
				
				Clockwork.player:GiveCash(player, -augmentTable.cost, augmentTable.name);
				Clockwork.player:Notify(player, "You have gotten the '"..augmentTable.name.."' augment.");
			end;
		else
			Clockwork.player:Notify(player, "You need another "..Clockwork.kernel:FormatCash(augmentTable.cost - player:GetCash(), nil, true).."!");
		end;
	end;
end);

Clockwork.datastream:Hook("AllyKick", function(player, data)
	if (player:IsLeader() and IsValid(data) and !data:IsLeader()) then
		local alliance = player:GetAlliance();
		
		if (alliance == data:GetAlliance()) then
			PhaseFour:LeaveAlliance(player, function()
				Clockwork.player:Notify(player, "You have kicked "..data:Name().." from the '"..alliance.."' alliance.");
				Clockwork.player:Notify(data, player:Name().." has kicked you from the '"..alliance.."' alliance.");
			
				Clockwork.datastream:Start(player, "AllyKick", data);
			end);
		end;
	end;
end);

Clockwork.datastream:Hook("BankDeposit", function(player, data)
	local alliance = player:GetAlliance();
	local canDeposit = false;
	
	for k, v in ipairs(ents.FindByClass("cw_safebox")) do
		if (player:GetPos():Distance(v:GetPos()) < 192) then
			canDeposit = true;
			break;
		end;
	end;
	
	if (canDeposit) then
		if (tonumber(data.amount) and data.amount > 0 and alliance != "") then
			if (not Clockwork.player:CanAfford(player, data.amount)) then
				return;
			end;
			
			PhaseFour:AddAllianceCash(alliance, data.amount, function()
				if (Clockwork.player:CanAfford(player, data.amount)) then
					Clockwork.player:GiveCash(player, -data.amount, "deposit to bank");
				end;
			end);
		end;
	else
		Clockwork.player:Notify(player, "You need to be within range of a Safebox to deposit!");
	end;
end);

Clockwork.datastream:Hook("BankWithdraw", function(player, data)
	local alliance = player:GetAlliance();
	local canDeposit = false;
	
	for k, v in ipairs(ents.FindByClass("cw_safebox")) do
		if (player:GetPos():Distance(v:GetPos()) < 192) then
			canDeposit = true;
			break;
		end;
	end;
	
	if (canDeposit) then
		if (tonumber(data.amount) and data.amount > 0 and alliance != ""
		and player:GetRank() >= RANK_SGT) then
			PhaseFour:GetAllianceCash(alliance, function(cash)
				if (cash >= data.amount) then
					PhaseFour:AddAllianceCash(alliance, -data.amount, function()
						Clockwork.player:GiveCash(player, data.amount, "withdraw from bank");
					end);
				end;
			end);
		end;
	else
		Clockwork.player:Notify(player, "You need to be within range of a Safebox to withdraw!");
	end;
end);

Clockwork.datastream:Hook("AllyMakeLeader", function(player, data)
	if (player:IsLeader() and IsValid(data) and !data:IsLeader()) then
		local alliance = player:GetAlliance();
		
		if (alliance == data:GetAlliance()) then
			PhaseFour:SetAllianceRank(player, RANK_MAJ, function()
				Clockwork.player:Notify(player, "You have made "..data:Name().." a leader of the '"..alliance.."' alliance.");
				Clockwork.player:Notify(data, player:Name().." has made you a leader of the '"..alliance.."' alliance.");
			
				Clockwork.datastream:Start(player, "AllySetRank", {data, RANK_MAJ});
			end);
		end;
	end;
end);

Clockwork.datastream:Hook("AllySetRank", function(player, data)
	if (player:IsLeader() and IsValid(data[1]) and !data[1]:IsLeader()) then
		if (player:GetAlliance() == data[1]:GetAlliance()) then
			local rank = tonumber(data[2]);
			
			if (rank and rank >= 0 and rank < 5) then
				PhaseFour:SetAllianceRank(data[1], rank, function()
					Clockwork.player:Notify(player, "You have set "..data[1]:Name().."'s rank to "..data[1]:GetRank(true)..".");
					Clockwork.player:Notify(data[1], player:Name().." has set your rank within the alliance to "..data[1]:GetRank(true)..".");
					Clockwork.datastream:Start(player, "AllySetRank", data);
				end);
			end;
		end;
	end;
end);

Clockwork.datastream:Hook("CreateAlliance", function(player, data)
	if (type(data) == "string") then
		local charactersTable = Clockwork.config:Get("mysql_characters_table"):Get();
		local schemaFolder = Clockwork.kernel:GetSchemaFolder();
		local allianceName = Clockwork.database:Escape(string.gsub(string.sub(data, 1, 32), "[%p%d]", ""));
		local allianceCost = Clockwork.config:Get("alliance_cost"):Get();
		
		if (not Clockwork.player:CanAfford(player, allianceCost)) then
			Clockwork.player:Notify(player, "You need another "..Clockwork.kernel:FormatCash(allianceCost - player:GetCash(), nil, true).."!");
			return;
		end;
		
		PhaseFour:CreateAllianceData(player, allianceName, function(allianceData)
			Clockwork.player:GiveCash(player, -allianceCost, "creating an alliance");
			Clockwork.player:Notify(player, "You have created the '"..allianceName.."' alliance.");
		end, function()
			Clockwork.player:Notify(player, "An alliance with the name '"..allianceName.."' already exists!");
		end);
	end;
end);

local playerMeta = FindMetaTable("Player");

function playerMeta:IsGood()
	return self:GetCharacterData("honor") >= 50;
end;

function playerMeta:IsBad()
	return self:GetCharacterData("honor") < 50;
end;

function playerMeta:GetBounty()
	return self:GetCharacterData("bounty");
end;

function playerMeta:IsWanted()
	return self:GetCharacterData("bounty") > 0;
end;

function playerMeta:AddBounty(bounty)
	self:SetCharacterData("bounty", self:GetCharacterData("bounty") + bounty);
end;

function playerMeta:RemoveBounty()
	self:SetCharacterData("bounty", 0);
end;

function playerMeta:HandleHonor(honor)
	if (honor < 0 and PhaseFour.augments:Has(self, AUG_CURSED)) then
		honor = honor * 2;
	elseif (honor > 0 and PhaseFour.augments:Has(self, AUG_FAVORED)) then
		honor = honor * 2;
	end;
	
	self:SetCharacterData("honor", math.Clamp(self:GetCharacterData("honor") + honor, 0, 100));
	
	if (self:GetCharacterData("honor") == 100) then
		PhaseFour.victories:Progress(self, VIC_ANGELIC);
	elseif (self:GetCharacterData("honor") == 0) then
		PhaseFour.victories:Progress(self, VIC_INCARNATE);
	end;
end;

function playerMeta:IsLeader()
	return self:GetCharacterData("rank") == RANK_MAJ;
end;

function playerMeta:SetRank(rank)
	self:SetCharacterData("rank", rank);
	self:SetSharedVar("rank", rank);
end;

function playerMeta:SetAlliance(alliance)
	self:SetCharacterData("alliance", alliance);
	self:SetSharedVar("alliance", alliance);
end;

function playerMeta:GetAlliance()
	local alliance = self:GetCharacterData("alliance");
	
	if (alliance != "") then
		return alliance;
	end;
end;

function playerMeta:GetRank(bString)
	local rank = self:GetCharacterData("rank");
	
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

function PhaseFour:MakeExplosion(position, scale)
	local explosionEffect = EffectData();
	local smokeEffect = EffectData();
	
	explosionEffect:SetOrigin(position);
	explosionEffect:SetScale(scale);
	smokeEffect:SetOrigin(position);
	smokeEffect:SetScale(scale);
	
	util.Effect("explosion", explosionEffect, true, true);
	util.Effect("cw_effect_smoke", smokeEffect, true, true);
end;

function PhaseFour:SpawnFlash(position)
	local effectData = EffectData();
	local curTime = CurTime();
	
	effectData:SetStart(position);
	effectData:SetOrigin(position);
	effectData:SetScale(16);
	
	util.Effect("Explosion", effectData, true, true);
	
	local effectData = EffectData();
		effectData:SetOrigin(position);
		effectData:SetScale(2);
	util.Effect("cw_effect_smoke", effectData, true, true);
	
	for k, v in ipairs(_player.GetAll()) do
		if (v:HasInitialized() and v:GetPos():Distance(position) <= 768) then
			if (Clockwork.player:CanSeePosition(v, position, 0.9, true)) then
				Clockwork.datastream:Start(v, "Flashed", false);
			end;
		end;
	end;
end;

function PhaseFour:SpawnTearGas(position)
	local effectData = EffectData();
	local curTime = CurTime();
	
	effectData:SetStart(position);
	effectData:SetOrigin(position);
	effectData:SetScale(16);
	
	util.Effect("Explosion", effectData, true, true);
	
	local effectData = EffectData();
		effectData:SetOrigin(position);
		effectData:SetScale(2);
	util.Effect("cw_effect_smoke", effectData, true, true);
	
	for k, v in ipairs(ents.FindInSphere(position, 512)) do
		if (v:IsPlayer() and v:HasInitialized()) then
			if (Clockwork.player:CanSeePosition(v, position, 0.9, true)) then
				local clothesItem = v:GetClothesItem();
				
				if (!clothesItem or !clothesItem("tearGasProtection")) then
					if (!v.nextTearGas or curTime >= v.nextTearGas) then
						v.nextTearGas = curTime + 30;
						Clockwork.datastream:Start(v, "TearGas", false);
					end;
				end;
			end;
		end;
	end;
end;

function PhaseFour:SendErrorHint(player, hint, duration)
	if (IsValid(player)) then
		Clockwork.hint:SendCenter(player, hint, duration or 3, Color(255, 0, 0, 255));
	end;
end;

function PhaseFour:SendWarningHint(player, hint, duration)
	if (IsValid(player)) then
		Clockwork.hint:SendCenter(player, hint, duration or 3, Color(255, 235, 255, 255));
	end;
end;

function PhaseFour:SendInfoHint(player, hint, duration)
	if (IsValid(player)) then
		Clockwork.hint:SendCenter(player, hint, duration or 3, Color(148, 248, 255, 255));
	end;
end;

function PhaseFour:SendPlainHint(player, hint, duration)
	if (IsValid(player)) then
		Clockwork.hint:SendCenter(player, hint, duration or 3, Color(255, 255, 255, 255));
	end;
end;

function PhaseFour:IsFriendlyWith(a, b)
	if (!IsValid(a)) then return false; end;
	
	if (!IsValid(b)) then return false; end;
	
	if (a == b) then return true; end;
	
	local allianceA = a:GetAlliance();
	local allianceB = b:GetAlliance();
	
	if (!allianceA or allianceB) then
		return false;
	end;
	
	return (allianceA == allianceB);
end;

function PhaseFour:IsNewPlayer(player)
	return (player:GetCharacterData("playtime") < 14400);
end;

function PhaseFour:GetSafeboxItemValue(player)
	local itemValue = player:GetCharacterData("safeboxcash");
	local inventory = player:GetCharacterData("safeboxitems");
	
	for k, v in pairs(inventory) do
		for k2, v2 in pairs(v) do
			itemValue = itemValue + v2("cost");
		end;
	end;
	
	return itemValue;
end;

function PhaseFour:GetItemValue(player)
	local itemValue = player:GetCash();
	local inventory = player:GetInventory();
	
	for k, v in pairs(inventory) do
		for k2, v2 in pairs(v) do
			itemValue = itemValue + v2("cost");
		end;
	end;
	
	for k, v in pairs(player:GetWeapons()) do
		local itemTable = Clockwork.item:GetByWeapon(v);
		
		if (itemTable and itemTable.HasPlayerEquipped
		and itemTable:HasPlayerEquipped(player, true)) then
			itemValue = itemValue + itemTable("cost");
		end;
	end;
	
	return itemValue;
end;

function PhaseFour:IsNearSafebox(player)
	local safeZoneRadius = Clockwork.config:Get("safezone_radius"):Get();
	local safeboxes = ents.FindByClass("cw_safebox");
	local position = player:GetPos();
	
	for k, v in pairs(safeboxes) do
		if (position:Distance(v:GetPos()) < safeZoneRadius) then
			return true;
		end;
	end;
	
	return false;
end;

function PhaseFour:CanPlayerBeAttacked(player)
	if (player.cwNextDisconnect and player.cwNextDisconnect > CurTime()) then
		return true;
	end;
	
	if (player:GetSharedVar("safeZone")) then
		return false;
	end;
	
	local activeWeapon = player:GetActiveWeapon();
	local weaponItem = Clockwork.item:GetByWeapon(activeWeapon);
	
	if (weaponItem) then
		return true;
	end;
	
	local attackSafeboxValue = Clockwork.config:Get("attack_safebox_value"):Get();
	
	if (player:GetSharedVar("safeboxValue") >= attackSafeboxValue) then
		return true;
	end;
	
	local itemValue = player:GetCash();
	
	for k, v in pairs(player:GetInventory()) do
		for k2, v2 in pairs(v) do
			itemValue = itemValue + v2("cost");
		end;
	end;
	
	for k, v in pairs(player:GetWeapons()) do
		local itemTable = Clockwork.item:GetByWeapon(v);
		
		if (itemTable and itemTable.HasPlayerEquipped
		and itemTable:HasPlayerEquipped(player, true)) then
			itemValue = itemValue + itemTable("cost");
		end;
	end;
	
	return (itemValue >= Clockwork.config:Get("attack_item_value"):Get());
end;

function PhaseFour:GetHealAmount(player, scale)
	return (15 + Clockwork.attributes:Fraction(player, ATB_DEXTERITY, 35)) * (scale or 1);
end;

function PhaseFour:GetDexterityTime(player)
	return 12 - Clockwork.attributes:Fraction(player, ATB_DEXTERITY, 5, 5);
end;

function PhaseFour:BustDownDoor(player, door, force)
	door.bustedDown = true;
	door:SetNotSolid(true);
	door:DrawShadow(false);
	door:SetNoDraw(true);
	door:EmitSound("physics/wood/wood_box_impact_hard3.wav");
	door:Fire("Unlock", "", 0);
	
	local fakeDoor = ents.Create("prop_physics");
	
	fakeDoor:SetCollisionGroup(COLLISION_GROUP_WORLD);
	fakeDoor:SetAngles(door:GetAngles());
	fakeDoor:SetModel(door:GetModel());
	fakeDoor:SetSkin(door:GetSkin());
	fakeDoor:SetPos(door:GetPos());
	fakeDoor:Spawn();
	
	local physicsObject = fakeDoor:GetPhysicsObject();
	
	if (IsValid(physicsObject)) then
		if (!force) then
			if (IsValid(player)) then
				physicsObject:ApplyForceCenter((door:GetPos() - player:GetPos()):GetNormal() * 10000);
			end;
		else
			physicsObject:ApplyForceCenter(force);
		end;
	end;
	
	Clockwork.entity:Decay(fakeDoor, 300);
	
	Clockwork.kernel:CreateTimer("reset_door_"..door:EntIndex(), 300, 1, function()
		if (IsValid(door)) then
			door:SetNotSolid(false);
			door:DrawShadow(true);
			door:SetNoDraw(false);
			door.bustedDown = nil;
		end;
	end);
end;

function PhaseFour:LoadBelongings()
	local belongings = Clockwork.kernel:RestoreSchemaData("plugins/belongings/"..game.GetMap());
	
	for k, v in pairs(belongings) do
		local entity = ents.Create("cw_belongings");
		
		if (v.inventory["human_meat"]) then
			v.inventory["human_meat"] = nil;
		end;
		
		entity:SetAngles(v.angles);
		entity:SetData(
			Clockwork.inventory:ToLoadable(v.inventory), v.cash
		);
		entity:SetPos(v.position);
		entity:Spawn();
		
		if (!v.moveable) then
			local physicsObject = entity:GetPhysicsObject();
			
			if (IsValid(physicsObject)) then
				physicsObject:EnableMotion(false);
			end;
		end;
	end;
end;

function PhaseFour:SaveBelongings()
	local belongings = {};
	
	for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
		if (v.areBelongings and (v.cash > 0 or table.Count(v.inventory) > 0)) then
			belongings[#belongings + 1] = {
				cash = v.cash,
				angles = Angle(0, 0, -90),
				moveable = true,
				position = v:GetPos() + Vector(0, 0, 32),
				inventory = Clockwork.inventory:ToSaveable(v.inventory)
			};
		end;
	end;
	
	for k, v in pairs(ents.FindByClass("cw_belongings")) do
		if (v.cash and v.inventory and (v.cash > 0 or table.Count(v.inventory) > 0)) then
			local physicsObject = v:GetPhysicsObject();
			local moveable;
			
			if (IsValid(physicsObject)) then
				moveable = physicsObject:IsMoveable();
			end;
			
			belongings[#belongings + 1] = {
				cash = v.cash,
				angles = v:GetAngles(),
				moveable = moveable,
				position = v:GetPos(),
				inventory = Clockwork.inventory:ToSaveable(v.inventory)
			};
		end;
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/belongings/"..game.GetMap(), belongings);
end;

function PhaseFour:SavePersonalStorage()
	local personalStorage = {};
	
	for k, v in pairs(self.personalStorage) do
		personalStorage[#personalStorage + 1] = {
			position = v.position,
			angles = v.angles
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/personal/"..game.GetMap(), personalStorage);
end;

function PhaseFour:LoadPersonalStorage()
	self.personalStorage = {};
	
	local personalStorage = Clockwork.kernel:RestoreSchemaData("plugins/personal/"..game.GetMap());
	
	for k, v in pairs(personalStorage) do
		local data = {
			position = v.position,
			angles = v.angles
		};
		
		data.entity = ents.Create("cw_safebox");
		data.entity:SetAngles(data.angles);
		data.entity:SetPos(data.position);
		data.entity:Spawn();
		
		data.entity:GetPhysicsObject():EnableMotion(false);
		self.personalStorage[#self.personalStorage + 1] = data;
	end;
end;

function PhaseFour:PlayerDropRandomItems(player, ragdoll, bEvenClothes)
	Clockwork.player:HolsterAll(player);
	local inventory = player:GetInventory();
	local cash = player:GetCash();
	local info = {
		inventory = {},
		cash = cash
	};
	
	--if (!IsValid(ragdoll)) then
		--info.entity = ents.Create("cw_belongings");
	--end;
	
	local dropArmor = Clockwork.config:Get("drop_armor_on_death"):Get();
	
	for k, v in pairs(inventory) do
		info.inventory[k] = {};
		
		for k2, v2 in pairs(v) do
			if (v2 and v2("allowStorage") != false and !v2("isRareItem")) then
				if (dropArmor or !v2:IsBasedFrom("clothes_base")) then
					local success, fault = player:TakeItem(v2);
					
					if (success) then
						info.inventory[k][k2] = v2;
					end;
				end;
			end;
		end;
	end;
	
	Clockwork.player:GiveCash(player, -cash, nil, true);
	
	--[[
	if (!IsValid(ragdoll)) then
		if (table.Count(info.inventory) > 0 or info.cash > 0) then
			info.entity:SetAngles(Angle(0, 0, -90));
			info.entity:SetData(info.inventory, info.cash);
			info.entity:SetPos(player:GetPos() + Vector(0, 0, 48));
			info.entity:Spawn();
		else
			info.entity:Remove();
		end;
	else
		ragdoll.areBelongings = true;
		ragdoll.inventory = info.inventory;
		ragdoll.cash = info.cash;
	end;
	--]]
	
	Clockwork.entity:DropItemsAndCash(info.inventory, info.cash, player:GetPos());
	
	player:SaveCharacter();
end;

function PhaseFour:TiePlayer(player, isTied, reset, government)
	player:SetSharedVar("tied", isTied == true);
	
	if (isTied) then
		Clockwork.player:DropWeapons(player);
		Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name().." has been tied.");
		
		player:Flashlight(false);
		player:StripWeapons();
	elseif (!reset) then
		if (player:Alive() and !player:IsRagdolled()) then 
			Clockwork.player:LightSpawn(player, true, true);
		end;
		
		Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name().." has been untied.");
	end;
end;

PhaseFour.allianceData = {};

function PhaseFour:LeaveAlliance(player, callback)
	local alliance = player:GetAlliance();
	
	if (!alliance or alliance == "") then
		if (callback) then
			callback();
		end;
		
		return;
	end;
	
	self:FetchAllianceData(alliance, function(allianceData)
		local steamId = player:SteamID64();
			allianceData["_Players"][steamId] = nil;
		self:UpdateAllianceData(allianceData);
		
		player:SetAlliance("");
		player:SetRank(RANK_RCT);
		player:SaveCharacter();
		
		if (callback) then
			callback();
		end;
	end,
	function()
		if (callback) then
			callback();
		end;
	end);
end;

function PhaseFour:SetAllianceRank(player, rank, callback)
	local alliance = player:GetAlliance();
	
	self:FetchAllianceData(alliance, function(allianceData)
		local steamId = player:SteamID64();
		local playerData = allianceData["_Players"];
		
		if (playerData[steamId]) then
			playerData[steamId].rank = rank;
		else
			playerData[steamId] = {rank = rank};
		end;
		
		self:UpdateAllianceData(allianceData);
		
		player:SetRank(rank);
		player:SaveCharacter();
		
		if (callback) then
			callback();
		end;
	end);
end;

function PhaseFour:AddAllianceCash(alliance, amount, callback)
	self:FetchAllianceData(alliance, function(allianceData)
		allianceData["_Data"].cash = (allianceData["_Data"].cash or 0) + amount;
		
		self:UpdateAllianceData(allianceData);
		
		if (callback) then
			callback();
		end;
	end);
end;

function PhaseFour:GetAllianceCash(alliance, callback)
	self:FetchAllianceData(alliance, function(allianceData)
		if (allianceData and callback) then
			callback(allianceData["_Data"].cash or 0);
		end;
	end);
end;

function PhaseFour:JoinAlliance(player, name, callback)
	self:FetchAllianceData(name, function(allianceData)
		local steamId = player:SteamID64();
			allianceData["_Players"][steamId] = {rank = RANK_RCT};
		self:UpdateAllianceData(allianceData);
		
		player:SetRank(RANK_RCT);
		player:SetAlliance(name);
		player:SaveCharacter();
		
		if (callback) then
			callback();
		end;
	end);
end;

function PhaseFour:UpdateAllianceData(data)
	local query = Clockwork.database:Update("alliances");
	
	for k, v in pairs(data) do
		if (k != "_Key") then
			if (type(v) == "table") then
				query:SetValue(k, Clockwork.json:Encode(v));
			else
				query:SetValue(k, tostring(v));
			end;
		end;
	end;
	
	local allianceName = data["_Name"];
	local playerList = {};
	
	for k, v in pairs(_player.GetAll()) do
		if (v:HasInitialized()) then
			if (v:GetAlliance() == allianceName) then
				playerList[#playerList + 1] = v;
			end;
		end;
	end;
	
	query:AddWhere("_Name = ?", allianceName);
	query:Push();
	
	if (#playerList > 0) then
		Clockwork.datastream:Start(playerList, "AllyData", data["_Data"]);
	end;
end;

-- A function to get a player's stamina.
function PhaseFour:GetStamina(player)
	if (cwStamina) then
		return player:GetCharacterData("Stamina");
	else
		return 100;
	end;
end;

-- A function to set a player's stamina.
function PhaseFour:SetStamina(player, value)
	if (cwStamina) then
		player:SetCharacterData("Stamina", value);
	end;
end;

-- A function to handle devices for a player.
function PhaseFour:HandlePlayerDevices(player)
	local thermalVision = player:GetWeapon("cw_thermalvision");
	local stealthCamo = player:GetWeapon("cw_stealthcamo");
	local reduceStamina = false;
	local isRagdolled = player:IsRagdolled();
	local isAlive = player:Alive();
	
	if (IsValid(thermalVision) and thermalVision:IsActivated()
	and isAlive and !isRagdolled) then
		if (self:GetStamina(player) > 15) then
			player:SetSharedVar("thermal", true);
			reduceStamina = true;
		else
			player:EmitSound("items/nvg_off.wav");
			thermalVision:SetActivated(false);
		end;
	else
		player:SetSharedVar("thermal", false);
	end;
	
	if (IsValid(stealthCamo) and stealthCamo:IsActivated()
	and isAlive and !isRagdolled) then
		if (self:GetStamina(player) > 15) then
			if (!player.cwLastMaterial) then
				player.cwLastMaterial = player:GetMaterial();
			end;
			
			if (!player.cwLastColor) then
				player.cwLastColor = {player:GetColor()};
			end;
			
			player:SetMaterial("sprites/heatwave");
			player:SetColor(255, 255, 255, 0);
			
			reduceStamina = true;
		else
			player:EmitSound("items/nvg_off.wav");
			stealthCamo:SetActivated(false);
		end;
	elseif (player.cwLastMaterial and player.cwLastColor) then
		player:SetMaterial(player.cwLastMaterial);
		player:SetColor(unpack(player.cwLastColor));
		player.cwLastMaterial = nil;
		player.cwLastColor = nil;
	end;
	
	if (reduceStamina) then
		self:SetStamina(player, math.Clamp(self:GetStamina(player) - 0.35, 0, 100));
	end;
end;

function PhaseFour:FetchAllianceData(name, onSuccess, onFail)
	if (PhaseFour.allianceData[name]) then
		onSuccess(PhaseFour.allianceData[name]);
		return;
	end;
	
	name = Clockwork.database:Escape(string.gsub(string.sub(name, 1, 32), "[%p%d]", ""));
	
	self:GetAllianceSQL(name, function(result)
		local data = {};
		
		for k, v in pairs(result) do
			if (k == "_Data" or k == "_Players") then
				data[k] = Clockwork.json:Decode(v);
				
				if (type(data[k]) != "table") then
					data[k] = {};
				end;
			elseif (tonumber(v)) then
				data[k] = tonumber(v);
			else
				data[k] = v;
			end;
		end;
		
		PhaseFour.allianceData[name] = data;
		
		onSuccess(data);
	end, onFail);
end;

function PhaseFour:CreateAllianceData(player, name, onSuccess, onFail)
	name = Clockwork.database:Escape(string.gsub(string.sub(name, 1, 32), "[%p%d]", ""));

	self:FetchAllianceData(name, function()
		if (onFail) then
			onFail();
		end;
	end, function()
		local players = {};
		local steamId = player:SteamID64();
		
		players[steamId] = {rank = RANK_MAJ};
		
		local allianceData = {};
		
		allianceData["_Name"] = name;
		allianceData["_Data"] = {cash = 0};
		allianceData["_Players"] = players;
		
		local query = Clockwork.database:Insert("alliances");
			query:SetValue("_Data", Clockwork.json:Encode(allianceData["_Data"]));
			query:SetValue("_Name", name);
			query:SetValue("_Players", Clockwork.json:Encode(allianceData["_Players"]));
			query:SetCallback(function()
				player:SetAlliance(name);
				player:SetRank(RANK_MAJ);
				player:SaveCharacter();
			end);
		query:Push();
		
		self.allianceData[name] = allianceData;
		
		if (onSuccess) then
			onSuccess(allianceData);
		end;
	end);
end;

function PhaseFour:GetAllianceData(name)
	return self.allianceData[name];
end;

function PhaseFour:GetAllianceSQL(name, onSuccess, onFail)
	name = Clockwork.database:Escape(string.gsub(string.sub(name, 1, 32), "[%p%d]", ""));
	
	local query = Clockwork.database:Select("alliances");
		query:AddWhere("_Name = ?", name);
		query:SetCallback(function(result)
			if (Clockwork.database:IsResult(result)) then
				if (type(result) == "table") then
					onSuccess(result[1]);
				else
					onSuccess(result);
				end;
			elseif (onFail) then
				onFail();
			end;
		end);
	query:Pull();
end;
