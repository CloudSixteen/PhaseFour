--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local JETPACK_SOUNDS = {};
local JETPACK_SOUND = Sound("PhysicsCannister.ThrusterLoop");

function PhaseFour:PlayerCanUseLoweredWeapon(player, weapon, secondary)
	if (secondary and (weapon.SilenceTime or weapon.PistolBurst)) then
		return true;
	end;
end;

function PhaseFour:PlayerSwitchFlashlight(player, on)
	return Clockwork.config:Get("allow_flashlight"):Get();
end;

-- Called to modify the generator interval.
function PhaseFour:ModifyGeneratorInterval(info)
	info.interval = math.floor(info.interval / 3);
end;

-- Called to modify the wages interval.
function PhaseFour:ModifyWagesInterval(info)
	info.interval = math.floor(info.interval / 3);
end;

-- Called to modify a player's wages info.
function PhaseFour:PlayerModifyWagesInfo(player, info)
	info.wages = math.floor(info.wages / 3);
end;

function PhaseFour:PlayerCanFireWeapon(player, bIsRaised, weapon, bIsSecondary)
	local weaponItem = Clockwork.item:GetByWeapon(weapon);
	
	if (weaponItem) then
		local durability = weaponItem:GetData("Durability");
		
		if (durability and durability <= 0) then
			return false;
		end;
	end;
end;

function PhaseFour:PlayerAdjustDeathInfo(player, info)
	if (PhaseFour.augments:Has(player, AUG_REINCARNATION)) then
		info.spawnTime = info.spawnTime * 0.25;
	end;
end;

function PhaseFour:PlayerShouldSmoothSprint(player, infoTable)
	return false;
end;

function PhaseFour:PlayerCharacterUnloaded(player)
	local nextDisconnect = 0;
	local curTime = CurTime();
	
	if (player.cwNextDisconnect) then
		nextDisconnect = player.cwNextDisconnect;
	end;
	
	if (player:HasInitialized()) then
		if (player:GetSharedVar("tied") or curTime < nextDisconnect) then
			self:PlayerDropRandomItems(player, nil, true);
		end;
	end;
end;

function PhaseFour:PlayerCanOrderShipment(player, itemTable)
	if (itemTable("requiresExplosives") and !PhaseFour.augments:Has(player, AUG_EXPLOSIVES)) then
		Clockwork.player:Notify(player, "You need the Explosives augment to craft this!");
		
		return false;
	elseif (itemTable("requiresArmadillo") and !PhaseFour.augments:Has(player, AUG_ARMADILLO)) then
		Clockwork.player:Notify(player, "You need the Armadillo augment to craft this!");
		
		return false;
	elseif (itemTable("requiresGunsmith") and !PhaseFour.augments:Has(player, AUG_GUNSMITH)) then
		Clockwork.player:Notify(player, "You need the Gunsmith augment to craft this!");
		
		return false;
	end;
end;

function PhaseFour:Tick()
	local curTime = CurTime();
	
	if (!self.nextCleanDecals or curTime >= self.nextCleanDecals) then
		self.nextCleanDecals = curTime + 60;
		
		for k, v in ipairs(cwPlayer.GetAll()) do
			v:RunCommand("r_cleardecals");
		end;
	end;
	
	if (!self.nextCleanSounds or curTime >= self.nextCleanSounds) then
		self.nextCleanSounds = curTime + 2;
		
		for k, v in pairs(JETPACK_SOUNDS) do
			if (!IsValid(k)) then
				JETPACK_SOUNDS[k] = nil;
				v:Stop();
			end;
		end;
	end;
end;

function PhaseFour:PlayerUseUnknownItemFunction(player, itemTable, itemFunction)
	print(player:Name()..": "..itemFunction);
	
	if (string.lower(itemFunction) == "cash" and itemTable("cost")) then
		local useSounds = {"buttons/button5.wav", "buttons/button4.wav"};
		local cashBack = itemTable("cost");
		
		if (PhaseFour.augments:Has(player, AUG_BLACKMARKET)) then
			cashBack = cashBack * 0.2;
		elseif (PhaseFour.augments:Has(player, AUG_CASHBACK)) then
			cashBack = cashBack * 0.25;
		else
			return;
		end;
		
		player:TakeItem(itemTable);
		player:EmitSound(useSounds[math.random(1, #useSounds)]);
		
		Clockwork.player:GiveCash(player, cashBack, "cashed an item");
	elseif (string.lower(itemFunction) == "repair" and itemTable("cost")) then
		local durability = itemTable:GetData("Durability");
		
		if (durability) then
			local baseCost = itemTable("cost");
			local repairCost = math.floor((baseCost * (1 - (math.max(durability, 1) / 100))) * 0.3);
			
			if (Clockwork.player:CanAfford(player, repairCost)) then
				player:EmitSound("buttons/button4.wav");
				
				itemTable:SetData("Durability", 100);
				
				Clockwork.player:GiveCash(player, -repairCost, "repairing an item");
			else
				Clockwork.player:Notify(player, "You need another "..Clockwork.kernel:FormatCash(repairCost - player:GetCash(), nil, true).."!");
			end;
		end;
	end;
end;

-- Called when a player stuns an entity.
function PhaseFour:PlayerStunEntity(player, entity)
	local target = Clockwork.entity:GetPlayer(entity);
	local strength = Clockwork.attributes:Fraction(player, ATB_STRENGTH, 12, 6);
	local curTime = CurTime();
	
	if (target and target:Alive()) then
		if (self:IsNearSafebox(target)) then
			self:SendWarningHint(player, "Target is in range of a Safe Zone!");
			return;
		end;
		
		if (self:CanPlayerBeAttacked(target)) then
			self:SendWarningHint(player, "Cannot stun attackable players!");
			return;
		end;
		
		if (player.cwNextCanStun and player.cwNextCanStun > curTime) then
			local timeLeft = math.floor(player.cwNextCanStun - curTime);
			
			self:SendWarningHint(player, "Wait "..timeLeft.." second(s) to stun again!");
			return;
		end;
		
		player:ProgressAttribute(ATB_STRENGTH, 0.5, true);
		player.cwNextDisconnect = CurTime() + 30;
		
		if (target.cwNextStunInfo and curTime <= target.cwNextStunInfo[2]) then
			target.cwNextStunInfo[1] = target.cwNextStunInfo[1] + 1;
			target.cwNextStunInfo[2] = curTime + 3;
			
			if (target.cwNextStunInfo[1] >= 2) then
				target.cwNextKnockOut = curTime + 30;
				target.cwKnockOutAttacker = player;
				target.cwKnockOutPos = target:GetPos()
				target.cwNextStunInfo = nil;
				
				target:SetSharedVar("knockOut", target.cwNextKnockOut);
				
				player.cwNextCanStun = curTime + 60;
				
				self:SendInfoHint(player, "Target will be knocked out unless they escape!");
			else
				self:SendPlainHint(player, "Keep hitting target to stun them...");
			end;
		else
			target.cwNextStunInfo = {0, curTime + 3};
			
			self:SendPlainHint(player, "Keep hitting target to stun them...");
		end;
		
		target:ViewPunch(Angle(12 + strength, 0, 0));
		
		Clockwork.datastream:Start(target, "Stunned", 0.5);
	end;
end;

function PhaseFour:PlayerSpawnProp(player, model)
	model = string.Replace(model, "\\", "/");
	model = string.Replace(model, "//", "/");
	model = string.lower(model);
	
	if (string.find(model, "fence")) then
		Clockwork.player:Notify(player, "You cannot spawn fence props!");
		
		return false;
	end;
end;

function PhaseFour:PlayerAdjustDropWeaponInfo(player, info)
	if (Clockwork.player:GetWeaponClass(player) == info.itemTable("weaponClass")) then
		info.position = player:GetShootPos();
		info.angles = player:GetAimVector():Angle();
	else
		local gearTable = {
			Clockwork.player:GetGear(player, "Throwable"),
			Clockwork.player:GetGear(player, "Secondary"),
			Clockwork.player:GetGear(player, "Primary"),
			Clockwork.player:GetGear(player, "Melee")
		};
		
		for k, v in pairs(gearTable) do
			if (IsValid(v)) then
				local gearItemTable = v:GetItemTable();
				
				if (gearItemTable
				and gearItemTable.weaponClass == info.itemTable("weaponClass")) then
					local position, angles = v:GetRealPosition();
					
					if (position and angles) then
						info.position = position;
						info.angles = angles;
						break;
					end;
				end;
			end;
		end;
	end;
end;

function PhaseFour:EntityRemoved(entity)
	if (IsValid(entity) and entity:GetClass() == "prop_ragdoll") then
		if (entity.areBelongings) then
			if (table.Count(entity.inventory) > 0 or entity.cash > 0) then
				local belongings = ents.Create("cw_belongings");
				
				belongings:SetAngles(Angle(0, 0, -90));
				belongings:SetData(entity.inventory, entity.cash);
				belongings:SetPos(entity:GetPos() + Vector(0, 0, 32));
				belongings:Spawn();
				
				entity.inventory = nil;
				entity.cash = nil;
			end;
		end;
	end;
end;

function PhaseFour:ClockworkInitPostEntity()
	self:LoadBelongings();
	self:LoadPersonalStorage();
end;

function PhaseFour:PostSaveData()
	self:SaveBelongings();
	self:SavePersonalStorage();
end;

function PhaseFour:PlayerSpray(player)
	if (!player:HasItemByID("spray_can") or player:GetSharedVar("tied")) then
		return true;
	end;
end;

function PhaseFour:ShowSpare1(player)
	local trace = player:GetEyeTraceNoCursor();
	local target = Clockwork.entity:GetPlayer(trace.Entity);

	if (target and target:Alive()) then
		if (!target:GetSharedVar("tied")) then
			Clockwork.player:RunClockworkCommand(player, "InvAction", "zip_tie", "use");
		else
			Clockwork.player:RunClockworkCommand(player, "CharSearch");
		end;
	end;
end;

function PhaseFour:ShowSpare2(player)
	Clockwork.datastream:Start(player, "HotkeyMenu", false);
end;

function PhaseFour:PlayerSpawnObject(player)
	if (player:GetSharedVar("tied")) then
		Clockwork.player:Notify(player, "You don't have permission to do this right now!");
		
		return false;
	end;
end;

function PhaseFour:PlayerCanBreachEntity(player, entity)
	if (Clockwork.entity:IsDoor(entity)) then
		if (!Clockwork.entity:IsDoorHidden(entity)) then
			return true;
		end;
	end;
end;

function PhaseFour:PlayerCanRadio(player, text, listeners, eavesdroppers)
	if (player:HasItemByID("handheld_radio")) then
		if (!player:GetCharacterData("frequency")) then
			Clockwork.player:Notify(player, "You need to set the radio frequency first!");
			
			return false;
		end;
	else
		Clockwork.player:Notify(player, "You do not own a radio!");
		
		return false;
	end;
end;

function PhaseFour:PlayerCanUseEntityInVehicle(player, entity, vehicle)
	if (entity:IsPlayer() or Clockwork.entity:IsPlayerRagdoll(entity)) then
		return true;
	end;
end;

function PhaseFour:PlayerCanUseDoor(player, door)
	if (player:GetSharedVar("tied")) then
		return false;
	end;
end;

function PhaseFour:PhysgunPickup(player, entity)
	if (entity:GetClass() == "prop_ragdoll" and not Clockwork.player:IsAdmin(player)) then
		return false;
	end;
end;

function PhaseFour:PlayerAdjustRadioInfo(player, info)
	for k, v in ipairs(cwPlayer.GetAll()) do
		if (v:HasInitialized() and v:HasItemByID("handheld_radio")) then
			if (v:GetCharacterData("frequency") == player:GetCharacterData("frequency")) then
				if (!v:GetSharedVar("tied")) then
					info.listeners[v] = v;
				end;
			end;
		end;
	end;
end;

function PhaseFour:CanTool(player, trace, tool)
	if (!Clockwork.player:HasFlags(player, "w")) then
		if (string.sub(tool, 1, 5) == "wire_" or string.sub(tool, 1, 6) == "wire2_") then
			player:RunCommand("gmod_toolmode \"\"");
			return false;
		end;
	end;
end;

function PhaseFour:PlayerSaveCharacterData(player, data)
	if (data["safeboxitems"]) then
		data["safeboxitems"] = Clockwork.inventory:ToSaveable(data["safeboxitems"]);
	end;
end;

function PhaseFour:PlayerRestoreCharacterData(player, data)
	if (!data["victories"]) then data["victories"] = {}; end;
	if (!data["augments"]) then data["augments"] = {}; end;
	if (!data["playtime"]) then data["playtime"] = 0; end;
	if (!data["notepad"]) then data["notepad"] = ""; end;
	if (!data["bounty"]) then data["bounty"] = 0; end;
	if (!data["honor"]) then data["honor"] = 50; end;
	if (!data["title"]) then data["title"] = ""; end;
	if (!data["fuel"]) then data["fuel"] = 100; end;
	
	data["safeboxitems"] = Clockwork.inventory:ToLoadable(data["safeboxitems"] or {});
	data["safeboxcash"] = data["safeboxcash"] or 0;
end;

function PhaseFour:PlayerDoesHaveItem(player, itemTable)
	local safebox = player:GetCharacterData("safeboxitems");
	
	if (safebox and safebox[itemTable("uniqueID")]) then
		return safebox[itemTable("uniqueID")];
	end;
end;

function PhaseFour:PlayerAdjustEarnGeneratorInfo(player, info)
	local positiveHintColor = "positive_hint";
	local directCash = math.floor(info.cash * 0.25);
	
	if (info.entity:GetClass() == "cw_cashprinter") then
		if (PhaseFour.augments:Has(player, AUG_THIEVING)) then
			info.cash = info.cash + 30;
		end;
	elseif (info.entity:GetClass() == "cw_cashproducer") then
		if (PhaseFour.augments:Has(player, AUG_METALSHIP)) then
			info.cash = info.cash + 50;
		end;
	end;
	
	local level = info.entity:GetNetworkedInt("Level") or 0;
	local cashScale = 1;
	local maxScaleToTake = 0.1;
	local distanceScale = maxScaleToTake / 1024;
	local entityPosition = info.entity:GetPos();
	
	for k, v in pairs(ents.FindInSphere(entityPosition, 1024)) do
		local class = v:GetClass();
		
		if (class == "cw_cashprinter" or class == "cw_cashproducer") then
			if (Clockwork.entity:GetOwner(v) != player) then
				local distance = math.min(entityPosition:Distance(v:GetPos()), 1024);
				local scaleToTake = maxScaleToTake - (distanceScale * distance);
				
				cashScale = math.max(cashScale - scaleToTake, 0.1);
			end;
		end;
	end;
	
	info.cash = math.floor(info.cash * cashScale);
	
	if (self:IsNewPlayer(player)) then
		info.cash = math.floor(info.cash * 1.25);
	end;
	
	if (level > 0) then
		info.cash = math.floor(info.cash * (1 + (0.15 * level)));
	end;
	
	info.cash = math.floor(info.cash / 3);
	
	if (PhaseFour.augments:Has(player, AUG_RECKONER)) then
		Clockwork.player:GiveCash(player, directCash, info.name);
		
		info.cash = info.cash - directCash;
	elseif (PhaseFour.augments:Has(player, AUG_ACCOUNTANT)) then
		Clockwork.hint:Send(player, "Your character's safebox gained "..Clockwork.kernel:FormatCash(directCash)..".", 4, positiveHintColor);
		
		player:SetCharacterData("safeboxcash", player:GetCharacterData("safeboxcash") + directCash);
		
		info.cash = info.cash - directCash;
	end;
end;

function PhaseFour:PlayerHealed(player, healer, itemTable)
	local action = Clockwork.player:GetAction(player);
	
	if (player:IsGood()) then
		healer:HandleHonor(5);
	else
		healer:HandleHonor(-5);
	end;
	
	if (itemTable("uniqueID") == "health_vial") then
		healer:ProgressAttribute(ATB_DEXTERITY, 15, true);
	elseif (itemTable("uniqueID") == "health_kit") then
		healer:ProgressAttribute(ATB_DEXTERITY, 25, true);
	elseif (itemTable("uniqueID") == "bandage") then
		healer:ProgressAttribute(ATB_DEXTERITY, 5, true);
	end;
end;

function PhaseFour:PlayerSetSharedVars(player, curTime)
	player:SetSharedVar("safeboxValue", self:GetSafeboxItemValue(player));
	player:SetSharedVar("itemValue", self:GetItemValue(player));
	player:SetSharedVar("alliance", player:GetCharacterData("alliance", ""));
	player:SetSharedVar("newPlayer", self:IsNewPlayer(player));
	player:SetSharedVar("nextDC", player.cwNextDisconnect or 0);
	player:SetSharedVar("bounty", player:GetCharacterData("bounty"));
	player:SetSharedVar("honor", player:GetCharacterData("honor"));
	player:SetSharedVar("title", player:GetCharacterData("title"));
	player:SetSharedVar("fuel", player:GetCharacterData("fuel"));
	player:SetSharedVar("rank", player:GetCharacterData("rank"));
	
	if (PhaseFour.augments:Has(player, AUG_GHOSTHEART)) then
		player:SetSharedVar("ghostheart", true);
	else
		player:SetSharedVar("ghostheart", false);
	end;
	
	if (player.cwCancelDisguise) then
		if (curTime >= player.cwCancelDisguise or !IsValid(player:GetSharedVar("disguise"))) then
			Clockwork.player:Notify(player, "Your disguise has begun to fade away, your true identity is revealed.");
			
			player.cwCancelDisguise = nil;
			player:SetSharedVar("disguise", NULL);
		end;
	end;
	
	if (player:Alive() and !player:IsRagdolled() and player:GetVelocity():Length() > 0) then
		local inventoryWeight = Clockwork.inventory:CalculateWeight(player:GetInventory());

		if (inventoryWeight >= player:GetMaxWeight() / 4) then
			player:ProgressAttribute(ATB_STRENGTH, inventoryWeight / 400, true);
		end;
	end;
	
	if (player:GetCash() > 200) then
		PhaseFour.victories:Progress(player, VIC_CODEKGUY);
	end;
end;

function PhaseFour:PlayerUnragdolled(player, state, ragdoll)
	Clockwork.player:SetAction(player, "die", false);
end;

function PhaseFour:PlayerRagdolled(player, state, ragdoll)
	Clockwork.player:SetAction(player, "die", false);
end;

function PhaseFour:PlayerThink(player, curTime, infoTable)
	if (player:Alive() and !player:IsRagdolled()) then
		if (!player:InVehicle() and player:GetMoveType() == MOVETYPE_WALK) then
			if (player:IsInWorld()) then
				if (!player:IsOnGround() and player:GetGroundEntity() != game.GetWorld()) then
					player:ProgressAttribute(ATB_ACROBATICS, 0.25, true);
				elseif (infoTable.isRunning) then
					player:ProgressAttribute(ATB_AGILITY, 0.125, true);
				elseif (infoTable.isJogging) then
					player:ProgressAttribute(ATB_AGILITY, 0.0625, true);
				end;
			end;
		end;
	end;
	
	local acrobatics = Clockwork.attributes:Fraction(player, ATB_ACROBATICS, 100, 50);
	local aimVector = tostring(player:GetAimVector());
	local strength = Clockwork.attributes:Fraction(player, ATB_STRENGTH, 8, 4);
	local agility = Clockwork.attributes:Fraction(player, ATB_AGILITY, 50, 25);
	local velocity = player:GetVelocity():Length();
	local armor = player:Armor();
	
	if (!player.cwNextCheckAFK or (player.cwLastAimVector != aimVector and velocity < 1)) then
		if (!Clockwork.player:IsAdmin(player)) then
			player.cwNextCheckAFK = curTime + 1800;
			player.cwLastAimVector = aimVector;
		end;
	end;
	
	if (!player.cwNextSafeZoneCheck or curTime >= player.cwNextSafeZoneCheck) then
		player.cwNextSafeZoneCheck = curTime + 2;
		player:SetSharedVar("safeZone", self:IsNearSafebox(player));
	end;
	
	if (!player.cwNextPlayTime or curTime >= player.cwNextPlayTime) then
		player:SetCharacterData("playtime", player:GetCharacterData("playtime") + 2);
		player.cwNextPlayTime = curTime + 2;
	end;
	
	if (player.cwNextKnockOut) then
		if (curTime >= player.cwNextKnockOut) then
			Clockwork.player:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, 10);
			
			player.cwNextKnockOut = nil;
			player.cwKnockOutPos = nil;
			player.cwKnockOutAttacker = nil;
			player:SetSharedVar("knockOut", false);
		else
			local attacker = player.cwKnockOutAttacker;
			local clearKnockOut = false;
			local hasAttackTimer = (player.cwNextDisconnect and curTime > player.cwNextDisconnect);
			
			if (!hasAttackTimer and IsValid(attacker) and attacker:Alive()) then
				local distance = player.cwKnockOutPos:Distance(player:GetPos());
				local isSafeZone = player:GetSharedVar("safeZone");
				
				if (isSafeZone or distance >= 2048) then
					clearKnockOut = true;
				end;
			else
				clearKnockOut = true;
			end;
			
			if (clearKnockOut) then
				player.cwNextKnockOut = nil;
				player.cwKnockOutPos = nil;
				player.cwKnockOutAttacker = nil;
				player:SetSharedVar("knockOut", false);
			end;
		end;
	end;
	
	if (player.cwNextCheckAFK and curTime >= player.cwNextCheckAFK) then
		player:Kick("Kicked for being AFK");
	end;
	
	local holdingEntity = player:GetHoldingEntity();
	
	if (IsValid(holdingEntity)) then
		local owner = Clockwork.entity:GetOwner(holdingEntity);
		
		if (!self:IsFriendlyWith(player, owner)) then
			player.cwNextDisconnect = curTime + 60;
		end;
	end;
	
	if (clothes != "") then
		local itemTable = Clockwork.item:FindByID(clothes);
		
		if (itemTable and itemTable("pocketSpace")) then
			infoTable.inventoryWeight = infoTable.inventoryWeight + itemTable("pocketSpace");
		end;
	end;
	
	infoTable.inventoryWeight = infoTable.inventoryWeight + strength;
	infoTable.jumpPower = infoTable.jumpPower + acrobatics;
	infoTable.runSpeed = infoTable.runSpeed + agility;
	
	if (PhaseFour.augments:Has(player, AUG_GODSPEED)) then
		infoTable.runSpeed = infoTable.runSpeed * 1.1;
	end;
	
	if (player.cwIsJetpacking) then
		PhaseFour.victories:Progress(player, VIC_TAKETOTHESKIES, 0.5);
		
		if (PhaseFour.augments:Has(player, AUG_HIGHPOWERED)) then
			player:SetCharacterData("fuel", math.max(player:GetCharacterData("fuel") - 0.138888889, 0));
		else
			player:SetCharacterData("fuel", math.max(player:GetCharacterData("fuel") - 0.277777778, 0));
		end;
		
		if (!JETPACK_SOUNDS[player]) then
			JETPACK_SOUNDS[player] = CreateSound(player, JETPACK_SOUND);
			JETPACK_SOUNDS[player]:PlayEx(0.5, 100 + Clockwork.attributes:Fraction(player, ATB_AERODYNAMICS, 50, 50));
		end;
	elseif (JETPACK_SOUNDS[player]) then
		JETPACK_SOUNDS[player]:Stop();
		JETPACK_SOUNDS[player] = nil;
	end;
	
	local mediumKevlar = Clockwork.item:FindByID("medium_kevlar");
	local heavyKevlar = Clockwork.item:FindByID("heavy_kevlar");
	local lightKevlar = Clockwork.item:FindByID("kevlar_vest");
	local playerGear = Clockwork.player:GetGear(player, "KevlarVest");
	
	if (armor > 100) then
		if (!playerGear or playerGear:GetItemTable() != heavyKevlar) then
			Clockwork.player:CreateGear(player, "KevlarVest", heavyKevlar);
		end;
	elseif (armor > 50) then
		if (!playerGear or playerGear:GetItemTable() != mediumKevlar) then
			Clockwork.player:CreateGear(player, "KevlarVest", mediumKevlar);
		end;
	elseif (armor > 0) then
		if (!playerGear or playerGear:GetItemTable() != lightKevlar) then
			Clockwork.player:CreateGear(player, "KevlarVest", lightKevlar);
		end;
	end;
	
	self:HandlePlayerDevices(player);
end;

function PhaseFour:PlayerOrderShipment(player, itemTable, entity, itemTables)
	if (not itemTables) then
		itemTables = {itemTable};
	end;
	
	if (itemTable("batch") == 5) then
		self.victories:Progress(player, VIC_BULKBUYER);
	end;
	
	if (itemTable("uniqueID") == "cw_metalcrowbar") then
		self.victories:Progress(player, AUG_FREEMAN);
	end;
	
	local engineering = Clockwork.attributes:Fraction(player, ATB_ENGINEERING, 100, 100);
	
	player:ProgressAttribute(ATB_ENGINEERING, itemTable("cost") / 3, true);	
	
	if (Clockwork.config:Get("enable_durability"):Get()) then
		for k, v in pairs(itemTables) do
			if (Clockwork.item:IsWeapon(v)
			or v:IsBasedFrom("clothes_base")) then
				local durability = math.random(math.max(engineering, 25), 100);
				
				v:SetData("Durability", durability);
			end;
		end;
	end;
end;

-- Called when an entity fires some bullets.
function Schema:EntityFireBullets(entity, bulletInfo)
	if (entity:IsPlayer()) then
		local stealthCamo = entity:GetWeapon("cw_stealthcamo");
		local isUsingStealth = (IsValid(stealthCamo) and stealthCamo:IsActivated());
		
		if (isUsingStealth) then
			entity:SetSharedVar("HideStealth", CurTime() + 2);
			
			if (!entity.cwNextStealthOffSnd
			or CurTime() >= entity.cwNextStealthOffSnd) then
				entity.cwNextStealthOffSnd = CurTime() + 2;
				entity:EmitSound("buttons/combine_button5.wav");
			end;
		end;
	end;
	
	local weaponUsed = entity;
	
	if (weaponUsed:IsPlayer()) then
		weaponUsed = entity:GetActiveWeapon();
	end;
	
	if (weaponUsed and weaponUsed:IsWeapon()) then
		local itemTable = Clockwork.item:GetByWeapon(weaponUsed);
		local weaponOwner = weaponUsed:GetOwner();
		
		if (itemTable) then
			local originalDamage = bulletInfo.Damage;
			local durability = itemTable:GetData("Durability");
			local drainScale = 100;
			
			if (durability) then
				bulletInfo.Damage = (originalDamage / 100) * durability;
				bulletInfo.Spread = bulletInfo.Spread * (1 + (1 - ((1 / 100) * durability)));
				
				local newDurability = math.max(durability - (originalDamage / drainScale), 0);
				
				if (durability > 0 and newDurability == 0) then
					self:SendErrorHint(weaponOwner, "Your weapon is now completely broken!");
				end;
				
				itemTable:SetData("Durability", newDurability);
			end;
		end;
		
		if (IsValid(weaponOwner)) then
			weaponOwner.cwNextDisconnect = CurTime() + 60;
		end;
	end;
end;

function PhaseFour:PlayerCanUseCommand(player, commandTable, arguments)
	if (player:GetSharedVar("tied")) then
		local blacklisted = {
			"OrderShipment",
			"Radio"
		};
		
		if (table.HasValue(blacklisted, commandTable.name)) then
			Clockwork.player:Notify(player, "You cannot use this command when you are tied!");
			
			return false;
		end;
	end;
end;

function PhaseFour:PlayerUse(player, entity)
	local curTime = CurTime();
	
	if (entity.bustedDown) then
		return false;
	end;
	
	if (player:GetSharedVar("tied")) then
		if (entity:IsVehicle()) then
			if (Clockwork.entity:IsChairEntity(entity) or Clockwork.entity:IsPodEntity(entity)) then
				return;
			end;
		end;
		
		if (!player.cwNextTieNotify or player.cwNextTieNotify < CurTime()) then
			Clockwork.player:Notify(player, "You cannot use that when you are tied!");
			
			player.cwNextTieNotify = CurTime() + 2;
		end;
		
		return false;
	end;
end;

function PhaseFour:PlayerCanDestroyItem(player, itemTable, bNoMessage)
	if (player:GetSharedVar("tied")) then
		if (!bNoMessage) then
			Clockwork.player:Notify(player, "You cannot destroy items when you are tied!");
		end;
		
		return false;
	end;
end;

function PhaseFour:PlayerCanDropItem(player, itemTable, bNoMessage)
	if (player:GetSharedVar("tied")) then
		if (!bNoMessage) then
			Clockwork.player:Notify(player, "You cannot drop items when you are tied!");
		end;
		
		return false;
	end;
end;

function PhaseFour:PlayerCanUseItem(player, itemTable, bNoMessage)
	if (player:GetSharedVar("tied")) then
		if (!bNoMessage) then
			Clockwork.player:Notify(player, "You cannot use items when you are tied!");
		end;
		
		return false;
	end;
	
	if (Clockwork.item:IsWeapon(itemTable) and !itemTable("fakeWeapon")) then
		local throwableWeapon = nil;
		local secondaryWeapon = nil;
		local primaryWeapon = nil;
		local meleeWeapon = nil;
		local fault = nil;
		
		for k, v in ipairs(player:GetWeapons()) do
			local weaponTable = Clockwork.item:GetByWeapon(v);
			
			if (weaponTable and !weaponTable("fakeWeapon")) then
				if (!weaponTable:IsMeleeWeapon()
				and !weaponTable:IsThrowableWeapon()) then
					if (weaponTable.weight <= 2) then
						secondaryWeapon = true;
					else
						primaryWeapon = true;
					end;
				elseif (weaponTable:IsThrowableWeapon()) then
					throwableWeapon = true;
				else
					meleeWeapon = true;
				end;
			end;
		end;
		
		if (!itemTable:IsMeleeWeapon() and !itemTable:IsThrowableWeapon()) then
			if (itemTable.weight <= 2) then
				if (secondaryWeapon) then
					fault = "You cannot use another secondary weapon!";
				end;
			elseif (primaryWeapon) then
				fault = "You cannot use another secondary weapon!";
			end;
		elseif (itemTable:IsThrowableWeapon()) then
			if (throwableWeapon) then
				fault = "You cannot use another throwable weapon!";
			end;
		elseif (meleeWeapon) then
			fault = "You cannot use another melee weapon!";
		end;
		
		if (fault) then
			if (!noMessage) then
				Clockwork.player:Notify(player, fault);
			end;
			
			return false;
		end;
	end;
end;

function PhaseFour:PlayerCanSayLOOC(player, text)
	if (!player:Alive()) then
		Clockwork.player:Notify(player, "You don't have permission to do this right now!");
	end;
end;

function PhaseFour:ChatBoxAdjustInfo(info)
	if (IsValid(info.speaker) and info.speaker:HasInitialized()) then
		if (info.class != "ooc" and info.class != "looc") then
			if (IsValid(info.speaker) and info.speaker:HasInitialized()) then
				if (string.sub(info.text, 1, 1) == "?") then
					info.text = string.sub(info.text, 2);
					info.data.anon = true;
				end;
			end;
		end;
	end;
end;

function PhaseFour:PlayerDestroyGenerator(player, entity, generator)
	local owner = entity:GetPlayer();
	local level = 0;
	local cash = generator.cash;
	
	if (IsValid(entity)) then
		local level = entity:GetNetworkedInt("Level") or 0;
		
		if (level > 0) then
			cash = cash + (150 * level);
		end;
	end;
	
	if (IsValid(owner) and owner:IsGood()) then
		if (PhaseFour.augments:Has(player, AUG_PAYBACK)) then
			Clockwork.player:GiveCash(player, cash * 0.5, "destroying a level "..level.." "..string.lower(generator.name));
			
			return;
		end;
	end;
	
	Clockwork.player:GiveCash(player, cash * 0.8, "destroying a level "..level.." "..string.lower(generator.name));
end;

function PhaseFour:PlayerDeath(player, inflictor, attacker, damageInfo)
	self.victories:Progress(player, VIC_BULLYVICTIM);
	
	if (PhaseFour.augments:Has(player, AUG_FLASHMARTYR)) then
		self:SpawnFlash(player:GetPos());
	elseif (PhaseFour.augments:Has(player, AUG_TEARMARTYR)) then
		self:SpawnTearGas(player:GetPos());
	end;
	
	if (attacker:IsPlayer()) then
		local listeners = {};
		local weapon = attacker:GetActiveWeapon();
		
		for k, v in ipairs(cwPlayer.GetAll()) do
			if (v:HasInitialized() and Clockwork.player:IsAdmin(v)) then
				listeners[#listeners + 1] = v;
			end;
		end;
		
		if (#listeners > 0) then
			Clockwork.chatBox:Add(listeners, attacker, "killed", "", {victim = player});
		end;
		
		if (IsValid(weapon)) then
			Clockwork.datastream:Start(player, "Death", weapon);
		else
			Clockwork.datastream:Start(player, "Death", true);
		end;
		
		if (player:IsBad()) then
			self.victories:Progress(attacker, VIC_DEVILHUNTER);
			attacker:HandleHonor(5);
		else
			self.victories:Progress(attacker, VIC_SAINTHUNTER);
			attacker:HandleHonor(-5);
		end;
		
		if (player:IsWanted() and player:GetAlliance() != attacker:GetAlliance()
		or (player:GetAlliance() == nil and attacker:GetAlliance() == nil)) then
			self.victories:Progress(attacker, VIC_BOUNTYHUNTER);
				Clockwork.player:GiveCash(attacker, player:GetBounty(), "bounty hunting");
			player:RemoveBounty();
		end;
	else
		Clockwork.datastream:Start(player, "Death", true);
	end;
	
	if (damageInfo) then
		local miscellaneousDamage = damageInfo:IsBulletDamage() or damageInfo:IsFallDamage() or damageInfo:IsExplosionDamage();
		local meleeDamage = damageInfo:IsDamageType(DMG_CLUB) or damageInfo:IsDamageType(DMG_SLASH);
		
		if (miscellaneousDamage or meleeDamage) then
			self:PlayerDropRandomItems(player, player:GetRagdollEntity());
		end;
	end;
end;

function PhaseFour:DoPlayerDeath(player, attacker, damageInfo)
	self:TiePlayer(player, false, true);
	
	player.cwBeingSearched = nil;
	player.cwSearching = nil;
end;

function PhaseFour:PlayerAdjustOrderItemTable(player, itemTable)
	if (PhaseFour.augments:Has(player, AUG_MERCANTILE)) then
		itemTable.cost = itemTable("cost") * 0.9;
	end;
end;

function PhaseFour:PlayerStorageShouldClose(player, storage)
	local entity = player:GetStorageEntity();
	
	if (player.cwSearching and entity:IsPlayer() and !entity:GetSharedVar("tied")) then
		return true;
	end;
end;

function PhaseFour:PlayerAttributeUpdated(player, attributeTable, amount)
	local currentPoints = Clockwork.attributes:Get(player, attributeTable.uniqueID, true);
	
	if (!currentPoints) then
		return;
	end;
	
	if (currentPoints >= attributeTable.maximum) then
		if (attributeTable.uniqueID == ATB_ENDURANCE) then
			self.victories:Progress(player, VIC_SNAKESKIN);
		elseif (attributeTable.uniqueID == ATB_DEXTERITY) then
			self.victories:Progress(player, VIC_QUICKHANDS);
		elseif (attributeTable.uniqueID == ATB_AGILITY) then
			self.victories:Progress(player, VIC_GONZALES);
		elseif (attributeTable.uniqueID == ATB_STRENGTH) then
			self.victories:Progress(player, VIC_MIKETYSON);
		end;
	elseif (currentPoints >= 50) then
		if (attributeTable.uniqueID == ATB_ACROBATICS) then
			self.victories:Progress(player, VIC_FIDDYACRO);
		end;
	end;
end;

-- Called just before a player would take damage.
function Clockwork:PrePlayerTakeDamage(player, attacker, inflictor, damageInfo)
	local curTime = CurTime();
	
	if (attacker:IsPlayer() and attacker != player) then
		attacker.cwNextDisconnect = curTime + 60;
	end;
	
	if (inflictor:IsPlayer() and inflictor != player) then
		inflictor.cwNextDisconnect = curTime + 60;
	end;
end;

function PhaseFour:PlayerShouldTakeDamage(player, attacker, inflictor, damageInfo)
	local curTime = CurTime();
	
	if (player.cwGhostModeTime and player.cwGhostModeTime > curTime) then
		return false;
	end;
	
	if (attacker.cwGhostModeTime and attacker.cwGhostModeTime > curTime) then
		return false;
	end;
	
	if (!self:CanPlayerBeAttacked(player)) then
		return false;
	end;
end;

function PhaseFour:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	local team = player:Team();
	
	if (!lightSpawn) then
		Clockwork.datastream:Start(player, "ClearEffects", false);
		
		player.cwGhostModeTime = CurTime() + 60;
		player:SetSharedVar("ghostMode", player.cwGhostModeTime);
		player:SetSharedVar("disguise", NULL);
		player.cwCancelDisguise = nil;
		player.cwBeingSearched = nil;
		player.cwSearching = nil;
	end;
	
	if (player:GetSharedVar("tied")) then
		self:TiePlayer(player, true);
	end;
	
	if (firstSpawn) then
		local alliance = player:GetAlliance();
		
		if (alliance) then
			self:FetchAllianceData(alliance, function(allianceData)
				local steamId = player:SteamID64();
				local playerData = allianceData["_Players"][steamId];
				
				if (playerData) then
					player:SetAlliance(alliance);
					player:SetRank(playerData.rank);
					
					Clockwork.datastream:Start(player, "AllyData", allianceData["_Data"]);
				else
					--player:SetAlliance("");
					--player:SetRank(RANK_RCT);
				end;
			end, function()
				--player:SetAlliance("");
				--player:SetRank(RANK_RCT);
			end);
		else
			player:SetAlliance("");
			player:SetRank(RANK_RCT);
		end;
		
		if (Clockwork.config:Get("auto_show_manual"):Get()) then
			Clockwork.datastream:Start(player, "ShowManual", true);
		else
			player.cwPhaseFourReady = true;
			Clockwork.plugin:Call("PhaseFourPlayerReady", player);
		end;
	end;
end;

function PhaseFour:PhaseFourPlayerReady(player)
	if (Clockwork.config:Get("referral_system"):Get()) then
		local referCode = util.CRC(player:SteamID());
		
		Clockwork.player:Notify(player, {"ReferProgramInfo", referCode})
		
		self:SendInfoHint(player, {"ReferProgramHint"}, 4);
	end;
	
	if (!Clockwork.config:Get("daily_login_enabled"):Get()) then
		return;
	end;
	
	local lastJoinTime = player:GetData("LastJoinTime");
	local currentTime = os.time();
	
	if (!lastJoinTime) then
		player:SetData("LastJoinTime", currentTime);
		return;
	end;
	
	local difference = currentTime - lastJoinTime;
	local loginCash = Clockwork.config:Get("daily_login_cash"):Get();
	local formatted = Clockwork.kernel:FormatCash(loginCash);
	
	if (difference >= 64800) then
		Clockwork.player:GiveCash(player, loginCash, "Daily Login Bonus");
		
		self:SendWarningHint(player, "Daily login bonus reward: "..formatted, 4);
		
		player:SetData("LastJoinTime", currentTime);
	end;
end;

function PhaseFour:PlayerFootstep(player, position, foot, sound, volume, recipientFilter)
	local clothesItem = player:GetClothesItem();
	
	if (clothesItem) then
		if (player:IsRunning() or player:IsJogging()) then
			local runSound = clothesItem("runSound");
			
			if (runSound) then
				if (type(clothesItem.runSound) == "table") then
					sound = runSound[ math.random(1, #runSound) ];
				else
					sound = runSound;
				end;
			end;
		else
			local walkSound = clothesItem("walkSound");
			
			if (walkSound) then
				if (type(walkSound) == "table") then
					sound = walkSound[ math.random(1, #walkSound) ];
				else
					sound = walkSound;
				end;
			end;
		end;
	end;
	
	player:EmitSound(sound);
	return true;
end;

function PhaseFour:PlayerPunchThrown(player)
	player:ProgressAttribute(ATB_STRENGTH, 0.25, true);
end;

function PhaseFour:PlayerPunchEntity(player, entity)
	if (entity:IsPlayer() or entity:IsNPC()) then
		player:ProgressAttribute(ATB_STRENGTH, 1, true);
	else
		player:ProgressAttribute(ATB_STRENGTH, 0.5, true);
	end;
end;

function PhaseFour:EntityBreached(entity, activator)
	if (Clockwork.entity:IsDoor(entity)) then
		Clockwork.entity:OpenDoor(entity, 0, true, true);
		
		if (IsValid(activator)) then
			self.victories:Progress(activator, VIC_BLOCKBUSTER);
		end;
	end;
end;

function PhaseFour:PlayerTakeDamage(player, inflictor, attacker, hitGroup, damageInfo)
	local curTime = CurTime();
	local alliance = player:GetAlliance();
	local clothesItem = player:GetClothesItem();
	
	if (clothesItem) then
		local originalDamage = damageInfo:GetDamage();
		local durability = clothesItem:GetData("Durability");
		local drainScale = 100;
		
		if (durability) then
			local newDurability = math.max(durability - (originalDamage / drainScale), 0);
			
			if (durability > 0 and newDurability == 0) then
				self:SendErrorHint(player, "Your armor is now completely broken!");
			end;
			
			clothesItem:SetData("Durability", newDurability);
		end;
	end;
	
	if (damageInfo:IsBulletDamage()) then
		if (player:Armor() > 0) then
			Clockwork.datastream:Start(player, "ShotEffect", 0.25);
		else
			Clockwork.datastream:Start(player, "ShotEffect", 0.5);
		end;
	end;
	
	if (player:Health() <= 10 and math.random() <= 0.75) then
		if (Clockwork.player:GetAction(player) != "die") then
			Clockwork.player:SetRagdollState(player, RAGDOLL_FALLENOVER, nil, nil, Clockwork.kernel:ConvertForce(damageInfo:GetDamageForce() * 32));
			
			if (PhaseFour.augments:Has(player, AUG_ADRENALINE)) then
				local duration = 60;
				
				if (PhaseFour.augments:Has(player, AUG_LONGLASTER)) then
					duration = duration / 2;
				end;
				
				Clockwork.player:SetAction(player, "die", duration, 1, function()
					if (IsValid(player) and player:Alive()) then
						Clockwork.player:SetRagdollState(player, RAGDOLL_NONE);
						player:SetHealth(10);
					end;
				end);
				
				player.cwNextDisconnect = curTime + duration + 30;
			else
				local duration = 60;
				
				if (PhaseFour.augments:Has(player, AUG_LONGLASTER)) then
					duration = duration * 2;
				end;
				
				Clockwork.player:SetAction(player, "die", duration, 1, function()
					if (IsValid(player) and player:Alive()) then
						player:TakeDamage(player:Health() * 2, attacker, inflictor);
					end;
				end);
				
				player.cwNextDisconnect = curTime + duration + 30;
			end;
		end;
	end;
	
	if (attacker:IsPlayer()) then
		Clockwork.datastream:Start(player, "TakeDmg", { attacker, damageInfo:GetDamage() });
		Clockwork.datastream:Start(attacker, "DealDmg", { player, damageInfo:GetDamage() });
		
		if (attacker:IsGood() and player:IsBad()) then
			if (PhaseFour.augments:Has(attacker, AUG_BLOODDONOR)) then
				local health = math.Round(damageInfo:GetDamage() * 0.1);
				
				if (health > 0) then
					attacker:SetHealth(math.Clamp(attacker:Health() + health, 0, attacker:GetMaxHealth()));
				end;
			end;
		end;
		
		if (alliance and attacker:GetAlliance() != alliance) then
			for k, v in ipairs(cwPlayer.GetAll()) do
				if (v:HasInitialized() and v:GetAlliance() == alliance) then
					Clockwork.datastream:Start(v, "TargetOutline", attacker);
				end;
			end;
		end;
		
		if (damageInfo:IsBulletDamage()) then
			if (PhaseFour.augments:Has(attacker, AUG_INCENDIARY)) then
				if (math.random() >= 0.9 and player:IsBad()) then
					if (!player:IsOnFire()) then
						player:Ignite(5, 0);
					end;
				end;
			elseif (PhaseFour.augments:Has(attacker, AUG_FROZENROUNDS)) then
				if (math.random() >= 0.9 and player:IsGood()) then
					if (!player:IsRagdolled()) then
						Clockwork.player:SetRagdollState(player, RAGDOLL_FALLENOVER, 5);
						
						local ragdollEntity = player:GetRagdollEntity();
						
						if (IsValid(ragdollEntity)) then
							Clockwork.entity:StatueRagdoll(ragdollEntity);
						end;
					end;
				end;
			end;
		end;
	end;
	
	if (!player.cwNextDisconnect or curTime > player.cwNextDisconnect + 60) then
		player.cwNextDisconnect = curTime + 60;
	end;
end;

function PhaseFour:PlayerLimbDamageHealed(player, hitGroup, amount)
	if (hitGroup == HITGROUP_HEAD) then
		player:BoostAttribute("Limb Damage", ATB_DEXTERITY, false);
	elseif (hitGroup == HITGROUP_CHEST or hitGroup == HITGROUP_STOMACH) then
		player:BoostAttribute("Limb Damage", ATB_ENDURANCE, false);
	elseif (hitGroup == HITGROUP_LEFTLEG or hitGroup == HITGROUP_RIGHTLEG) then
		player:BoostAttribute("Limb Damage", ATB_ACROBATICS, false);
		player:BoostAttribute("Limb Damage", ATB_AGILITY, false);
	elseif (hitGroup == HITGROUP_LEFTARM or hitGroup == HITGROUP_RIGHTARM) then
		player:BoostAttribute("Limb Damage", ATB_STRENGTH, false);
	end;
end;

function PhaseFour:PlayerLimbDamageReset(player)
	player:BoostAttribute("Limb Damage", nil, false);
end;

function PhaseFour:PlayerLimbTakeDamage(player, hitGroup, damage)
	local limbDamage = Clockwork.limb:GetDamage(player, hitGroup);
	
	if (hitGroup == HITGROUP_HEAD) then
		player:BoostAttribute("Limb Damage", ATB_DEXTERITY, -limbDamage);
	elseif (hitGroup == HITGROUP_CHEST or hitGroup == HITGROUP_STOMACH) then
		player:BoostAttribute("Limb Damage", ATB_ENDURANCE, -limbDamage);
	elseif (hitGroup == HITGROUP_LEFTLEG or hitGroup == HITGROUP_RIGHTLEG) then
		player:BoostAttribute("Limb Damage", ATB_ACROBATICS, -limbDamage);
		player:BoostAttribute("Limb Damage", ATB_AGILITY, -limbDamage);
	elseif (hitGroup == HITGROUP_LEFTARM or hitGroup == HITGROUP_RIGHTARM) then
		player:BoostAttribute("Limb Damage", ATB_STRENGTH, -limbDamage);
	end;
end;

function PhaseFour:PlayerScaleDamageByHitGroup(player, attacker, hitGroup, damageInfo, baseDamage)
	local endurance = Clockwork.attributes:Fraction(player, ATB_ENDURANCE, 0.1, 0.2);
	local clothesItem = player:GetClothesItem();
	local curTime = CurTime();
	
	if (hitGroup == HITGROUP_HEAD and PhaseFour.augments:Has(player, AUG_HEADPLATE)) then
		if (math.random() <= 0.5) then
			damageInfo:SetDamage(0);
		end;
	end;
	
	if (damageInfo:GetDamage() > 0 and hitGroup == HITGROUP_HEAD) then
		if (attacker:IsPlayer() and PhaseFour.augments:Has(attacker, AUG_RECYCLER)) then
			if (math.random() <= 0.5) then
				attacker:SetHealth(math.Clamp(attacker:Health() + (damageInfo:GetDamage() / 2), 0, attacker:GetMaxHealth()));
			end;
		end;
	end;
	
	if (damageInfo:IsDamageType(DMG_CLUB) or damageInfo:IsDamageType(DMG_SLASH)) then
		if (PhaseFour.augments:Has(player, AUG_BLUNTDEFENSE)) then
			damageInfo:ScaleDamage(0.75);
		end;
	end;
	
	if (attacker:GetClass() == "entityflame") then
		if (!player.cwNextBurnDamage or curTime >= player.cwNextBurnDamage) then
			player.cwNextBurnDamage = curTime + 0.1;
			
			damageInfo:SetDamage(1);
		else
			damageInfo:SetDamage(0);
		end;
	end;
	
	if (damageInfo:IsFallDamage()) then
		if (PhaseFour.augments:Has(player, AUG_LEGBRACES)) then
			damageInfo:ScaleDamage(0.5);
		end;
	else
		damageInfo:ScaleDamage(1 - endurance);
	end;
	
	if (clothesItem) then
		local durability = clothesItem:GetData("Durability");
		local itemLevel = clothesItem:GetData("Level");
		local totalScale = 0;
	
		if (clothesItem("armorScale")) then
			totalScale = totalScale + (clothesItem("armorScale") * 0.4);
		end;
		
		if (itemLevel) then
			totalScale = totalScale + (itemLevel * 0.01);
		end;
		
		if (durability) then
			totalScale = (totalScale / 100) * durability;
		end;
		
		if (totalScale > 0) then
			damageInfo:ScaleDamage(1 - totalScale);
		end;
	end;
	
	if (attacker:IsPlayer() and attacker:IsBad() and player:IsGood()) then
		if (PhaseFour.augments:Has(attacker, AUG_HOLLOWPOINT)) then
			damageInfo:ScaleDamage(1.1);
		end;
	end;
	
	if (Clockwork.player:GetAction(player) == "die") then
		if (PhaseFour.augments:Has(player, AUG_BORNSURVIVOR)) then
			damageInfo:ScaleDamage(0);
		end;
	end;
	
	if (attacker:IsPlayer()) then
		local itemTable = Clockwork.item:GetByWeapon(attacker:GetActiveWeapon());
		
		if (itemTable) then
			local itemLevel = itemTable:GetData("Level");
			
			if (itemLevel) then
				damageInfo:ScaleDamage(1 + (0.1 * itemLevel));
			end;
		end;
	end;
end;

function PhaseFour:EntityTakeDamage(entity, damageInfo)
	local inflictor, attacker, amount = damageInfo:GetInflictor(), damageInfo:GetAttacker(), damageInfo:GetDamage();
	local curTime = CurTime();
	local player = Clockwork.entity:GetPlayer(entity);
	
	if (player) then
		if (!player.cwNextEnduranceTime or CurTime() > player.cwNextEnduranceTime) then
			player:ProgressAttribute(ATB_ENDURANCE, math.Clamp(damageInfo:GetDamage(), 0, 75) / 10, true);
			player.cwNextEnduranceTime = CurTime() + 2;
		end;
	end;
	
	if (attacker:IsPlayer()) then
		local weapon = Clockwork.player:GetWeaponClass(attacker);
		
		if (weapon == "weapon_crowbar") then
			if (entity:IsPlayer()) then
				damageInfo:ScaleDamage(0.1);
			else
				damageInfo:ScaleDamage(0.8);
			end;
		end;
		
		if (entity:GetClass() == "prop_physics") then
			for k, v in ipairs(ents.FindByClass("cw_propguarder")) do
				if (entity:GetPos():Distance(v:GetPos()) < 512) then
					damageInfo:ScaleDamage(0.5);
					break;
				end;
			end;
			
			if (damageInfo:IsBulletDamage()) then
				damageInfo:ScaleDamage(0.5);
			end;
			
			if (Clockwork.config:Get("allow_prop_damage"):Get()) then
    			local boundingRadius = entity:BoundingRadius() * 12;
    			entity.health = entity.health or boundingRadius;
    			entity.health = math.max(entity.health - damageInfo:GetDamage(), 0);
    			
    			local blackness = (255 / boundingRadius) * entity.health;
    			entity:SetColor(Color(blackness, blackness, blackness, 255));
    			
    			if (entity.health == 0 and !entity.isDead) then
    				if (entity:GetOwnerKey() != attacker:QueryCharacter("Key")) then
    					self.victories:Progress(attacker, AUG_HOOLIGAN);
    				end;
    				
    				Clockwork.entity:Decay(entity, 5);
    				
    				entity:SetCollisionGroup(COLLISION_GROUP_WEAPON);
    				entity:Ignite(5, 0);
    				entity.isDead = true;
    			end;
    		end;
		end;
		
		for k, v in ipairs(ents.FindByClass("cw_doorguarder")) do
			if (entity:GetPos():Distance(v:GetPos()) < 256) then
				local owner = v:GetPlayer();
				
				if (IsValid(owner) and PhaseFour.augments:Has(owner, AUG_REVERSEMAN)) then
					attacker:TakeDamageInfo(damageInfo);
				end;
				
				return;
			end;
		end;
		
		if (damageInfo:IsBulletDamage() and !IsValid(entity.breach)) then
			if (string.lower(entity:GetClass()) == "prop_door_rotating") then
				if (!Clockwork.entity:IsDoorFalse(entity)) then
					local damagePosition = damageInfo:GetDamagePosition();
					
					if (entity:WorldToLocal(damagePosition):Distance(Vector(-1.0313, 41.8047, -8.1611)) <= 8) then
						local effectData = EffectData();
						
						effectData:SetStart(damagePosition);
						effectData:SetOrigin(damagePosition);
						effectData:SetScale(8);
						
						util.Effect("GlassImpact", effectData, true, true);
						
						Clockwork.entity:OpenDoor(entity, 0, true, true, attacker:GetPos());
					end;
				end;
			end;
		end;
	end;
end;

function PhaseFour:Move(player, moveData)
	local isJetpacking = false;
	local isOnGround = player:IsOnGround() or (player:GetGroundEntity() == game.GetWorld());
	local clothesItem = player:GetClothesItem();
	local curTime = CurTime();

	if (player:Alive() and !player:IsRagdolled() and clothesItem
	and player:GetCharacterData("fuel") > 5) then
		if (clothesItem("hasJetpack")) then
			local currentVelocity = moveData:GetVelocity();
			local isHoldingSprint = player:KeyDown(IN_SPEED);
			local isHoldingJump = player:KeyDown(IN_JUMP);
			
			if (isHoldingJump and isHoldingSprint) then
				local speed = Clockwork.attributes:Fraction(player, ATB_AERODYNAMICS, 256, 128);
				
				if (!isOnGround) then
					moveData:SetVelocity(player:GetAimVector() * (384 + speed));
					player.wasJetpacking = true;
					
					if (!player.cwNextUpdateAero or curTime >= player.cwNextUpdateAero) then
						player.cwNextUpdateAero = curTime + 1;
						player:ProgressAttribute(ATB_AERODYNAMICS, 0.5, true);
					end;
					
					isJetpacking = true;
				end;
			elseif (isHoldingJump and player.wasJetpacking) then
				if (!isOnGround) then
					moveData:SetVelocity(Vector(currentVelocity.x, currentVelocity.y, 0));
					isJetpacking = true;
				end;
			end;
		end;
	end;
	
	player.cwIsJetpacking = isJetpacking;
	player:SetSharedVar("jetpack", player.cwIsJetpacking);
	
	if (isOnGround) then
		player.wasJetpacking = false;
	end;
end;

function PhaseFour:EntityHandleMenuOption(player, entity, option, arguments)
	local mineTypes = {"cw_firemine", "cw_freezemine", "cw_explomine"};
	local generator = Clockwork.generator:FindByID(entity:GetClass());
	
	if (generator and arguments == "cwUpgradeGenerator") then
		local level = entity:GetNetworkedInt("Level") or 0;
		
		if (level < 5) then
			local nextCost = 150 * (level + 1);
			
			if (Clockwork.player:CanAfford(player, nextCost)) then
				entity:SetNetworkedInt("Level", level + 1);
				player:EmitSound("buttons/button4.wav");
				
				Clockwork.player:GiveCash(player, -nextCost, "upgrading a generator");
				
				self:SendInfoHint(player, "Generator upgrade was successful.");
			else
				Clockwork.player:Notify(player, "You need another "..Clockwork.kernel:FormatCash(nextCost - player:GetCash(), nil, true).."!");
			end;
		end;
	end;
	
	if (table.HasValue(mineTypes, entity:GetClass())) then
		if (arguments == "cwMineDefuse" and !player:GetSharedVar("tied")) then
			if (entity.cwActivated) then
				local defuseTime = PhaseFour:GetDexterityTime(player);
				
				Clockwork.player:SetAction(player, "defuse", defuseTime);
				
				Clockwork.player:EntityConditionTimer(player, entity, entity, defuseTime, 80, function()
					return player:Alive() and !player:IsRagdolled() and !player:GetSharedVar("tied");
				end, function(success)
					Clockwork.player:SetAction(player, "defuse", false);
					
					if (success) then
						self:SendInfoHint(player, "Mine was successfully defused.");
						
						entity:Defuse();
						entity:Remove();
					end;
				end);
			end;
		elseif (arguments == "cwMineActivate" and !player:GetSharedVar("tied")) then
			if (!entity.cwActivated) then
				local activateTime = PhaseFour:GetDexterityTime(player);
				
				Clockwork.player:SetAction(player, "activate", activateTime);
				
				Clockwork.player:EntityConditionTimer(player, entity, entity, activateTime, 80, function()
					return player:Alive() and !player:IsRagdolled() and !player:GetSharedVar("tied");
				end, function(success)
					Clockwork.player:SetAction(player, "activate", false);
					
					if (success) then
						entity.cwActivated = true;
						entity:SetNetworkedBool("Activated", true);
						
						self:SendWarningHint(player, "Mine was successfully activated!");
						
						Clockwork.entity:MakeSafe(entity, true, true, true);
					end;
				end);
			end;
		end;
	elseif (entity:GetClass() == "cw_sign_post" and entity:GetNetworkedString("Text") == "") then
		entity:SetNetworkedString("Text", string.sub(string.gsub(arguments, "\n", ""), 0, 396));
	elseif (entity:GetClass() == "prop_ragdoll") then
		if (arguments == "cwCorpseLoot") then
			if (!entity.inventory) then entity.inventory = {}; end;
			if (!entity.cash) then entity.cash = 0; end;
			
			local entityPlayer = Clockwork.entity:GetPlayer(entity);
			
			if (!entityPlayer or !entityPlayer:Alive()) then
				player:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav");
				
				Clockwork.storage:Open(player, {
					name = "Corpse",
					weight = 8,
					entity = entity,
					distance = 192,
					cash = entity.cash,
					inventory = entity.inventory,
					OnTakeItem = function(player, storageTable, itemTable)
						if (entity.clothesData and itemTable("index") == entity.clothesData[1]) then
							if (!storageTable.inventory[itemTable("uniqueID")]) then
								entity:SetModel(entity.clothesData[2]);
								entity:SetSkin(entity.clothesData[3]);
							end;
						end;
					end,
					OnGiveCash = function(player, storageTable, cash)
						entity.cash = storageTable.cash;
					end,
					OnTakeCash = function(player, storageTable, cash)
						entity.cash = storageTable.cash;
						
						if (cash >= 1500) then
							self.victories:Progress(player, VIC_RANSACKED);
						end;
					end
				});
			end;
		elseif (arguments == "cwCorpseMutilate") then
			if (PhaseFour.augments:Has(player, AUG_MUTILATOR)) then
				local entityPlayer = Clockwork.entity:GetPlayer(entity);
				local trace = player:GetEyeTraceNoCursor();
				
				if (!entityPlayer or !entityPlayer:Alive()) then
					if (!entity.mutilated or entity.mutilated < 3) then
						entity.mutilated = (entity.mutilated or 0) + 1;
							player:SetHealth(math.Clamp(player:Health() + 5, 0, player:GetMaxHealth()));
							player:EmitSound("npc/barnacle/barnacle_crunch"..math.random(2, 3)..".wav");
						Clockwork.kernel:CreateBloodEffects(entity:NearestPoint(trace.HitPos), 1, entity);
					end;
				end;
			end;
		elseif (arguments == "cwCorpseRevive") then
			if (PhaseFour.augments:Has(player, AUG_LIFEBRINGER)) then
				local entityPlayer = Clockwork.entity:GetPlayer(entity);
				local curTime = CurTime();
				
				if (entityPlayer and !entityPlayer:Alive()) then
					if (!entityPlayer.nextCanBeRevived or curTime >= entityPlayer.nextCanBeRevived) then
						entityPlayer.nextCanBeRevived = curTime + 60;
						
						local position = Clockwork.entity:GetPelvisPosition(entity);
						local health = math.Clamp(player:Health() / 2, 1, 100);
						
						entityPlayer:Spawn();
						player:SetHealth(player:Health() - health);
						entityPlayer:SetHealth(health);
						player:EmitSound("ambient/energy/whiteflash.wav");
						
						local effectData = EffectData();
							effectData:SetStart(position);
							effectData:SetOrigin(position);
							effectData:SetScale(32);
						util.Effect("GlassImpact", effectData, true, true);
						
						Clockwork.datastream:Start(entityPlayer, "Flahsed");
						Clockwork.player:SetSafePosition(entityPlayer, position);
						
						if (IsValid(entity)) then
							entity:Remove();
						end;
					else
						Clockwork.player:Notify(player, "This character cannot be revived yet!");
					end;
				end;
			end;
		end;
	elseif (entity:GetClass() == "cw_safebox" and arguments == "cwSafeboxOpen") then
		local cash = player:GetCharacterData("safeboxcash");
		local weight = Clockwork.config:Get("max_safebox_weight"):Get();
		local inventory = player:GetCharacterData("safeboxitems");
		
		if (PhaseFour.augments:Has(player, AUG_OBSESSIVE)) then
			weight = weight * 3;
		end;
	
		Clockwork.storage:Open(player, {
			name = "Safebox",
			weight = weight,
			entity = entity,
			distance = 192,
			cash = cash,
			inventory = inventory,
			OnGiveCash = function(player, storageTable, cash)
				player:SetCharacterData("safeboxcash", storageTable.cash);
			end,
			OnTakeCash = function(player, storageTable, cash)
				player:SetCharacterData("safeboxcash", storageTable.cash);
			end
		});
	elseif (entity:GetClass() == "cw_breach" and arguments == "cwBreachCharge") then
		entity:CreateDummyBreach();
		entity:BreachEntity(player);
	end;
end;

function PhaseFour:PlayerCharacterInitialized(player)
	Clockwork.datastream:Start(player, "VictoriesClear", false);
	Clockwork.datastream:Start(player, "AugmentsClear", false);

	for k, v in pairs(player:GetCharacterData("victories")) do
		local victoryTable = self.victory:Get(k);
		
		if (victoryTable) then
			Clockwork.datastream:Start(player, "VictoriesProgress", {victoryTable.index, v});
		end;
	end;
	
	for k, v in pairs(player:GetCharacterData("augments")) do
		local augmentTable = PhaseFour.augment:Get(k);
		
		if (augmentTable) then
			Clockwork.datastream:Start(player, "AugmentsGive", augmentTable.index);
		end;
	end;
end;

function PhaseFour:ClockworkDatabaseConnected()
	local ALLIANCE_TABLE_QUERY = [[
	CREATE TABLE IF NOT EXISTS `alliances` (
		`_Key` smallint(11) NOT NULL AUTO_INCREMENT,
		`_Data` text NOT NULL,
		`_Name` text NOT NULL,
		`_Players` text NOT NULL,
		PRIMARY KEY (`_Key`));
	]];
	
	local LITE_ALLIANCE_TABLE_QUERY = [[
	CREATE TABLE IF NOT EXISTS `alliances` (
		`_Key` INTEGER PRIMARY KEY AUTOINCREMENT,
		`_Data` TEXT,
		`_Name` TEXT,
		`_Players` TEXT);
	]];

	if (Clockwork.database.liteSql) then
		Clockwork.database:Query(string.gsub(LITE_ALLIANCE_TABLE_QUERY, "%s", " "), nil, nil, true);
	else
		Clockwork.database:Query(string.gsub(ALLIANCE_TABLE_QUERY, "%s", " "), nil, nil, true);
	end;
end;
