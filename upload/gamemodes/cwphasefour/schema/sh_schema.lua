--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

--[[
	You don't have to do this, but I think it's nicer.
	Alternatively, you can simply use the Schema variable.
--]]
Schema:SetGlobalAlias("PhaseFour");

--[[ You don't have to do this either, but I prefer to seperate the functions. --]]
Clockwork.kernel:IncludePrefixed("sv_schema.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_schema.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_theme.lua");

Clockwork.option:SetKey("description_business", "Craft a variety of equipment with your cash.");
Clockwork.option:SetKey("intro_image", "phasefour/phasefour_3");
Clockwork.option:SetKey("schema_logo", "phasefour/phasefour_3");
Clockwork.option:SetKey("name_business", "Crafting");
Clockwork.option:SetKey("menu_music", "music/hl2_song19.mp3");
Clockwork.option:SetKey("model_shipment", "models/items/item_item_exper.mdl");
Clockwork.option:SetKey("model_cash", "models/props_lab/exp01a.mdl");
Clockwork.option:SetKey("gradient", "phasefour/bg_gradient");

if (CLIENT) then
	Clockwork.config:AddToSystem("AttackSafeboxValue", "attack_safebox_value", "AttackSafeboxValueDesc");
	Clockwork.config:AddToSystem("AttackItemValue", "attack_item_value", "AttackItemValueDesc");
	Clockwork.config:AddToSystem("EnableDurability", "enable_durability", "EnableDurabilityDesc");
	Clockwork.config:AddToSystem("DropArmorOnDeath", "drop_armor_on_death", "DropArmorOnDeathDesc");
	Clockwork.config:AddToSystem("SafezoneRadius", "safezone_radius", "SafezoneRadiusDesc");
	Clockwork.config:AddToSystem("AllowPropDamage", "allow_prop_damage", "AllowPropDamageDesc");
	Clockwork.config:AddToSystem("AllowFlashlight", "allow_flashlight", "AllowFlashlightDesc");
	Clockwork.config:AddToSystem("AdvertCost", "advert_cost", "AdvertCostDesc");
else
	Clockwork.config:Add("attack_safebox_value", 10000, true);
	Clockwork.config:Add("attack_item_value", 1000, true);
	Clockwork.config:Add("safezone_radius", 768, true);
	Clockwork.config:Add("drop_armor_on_death", true, true);
	Clockwork.config:Add("enable_durability", true, true);
	Clockwork.config:Add("auto_show_manual", true);
	Clockwork.config:Add("referral_system", true);
	Clockwork.config:Add("daily_login_enabled", true);
	Clockwork.config:Add("daily_login_cash", 2000);
	Clockwork.config:Add("referral_cash", 500);
	Clockwork.config:Add("advert_cost", 100);
end;

Clockwork.config:ShareKey("attack_safebox_value");
Clockwork.config:ShareKey("attack_item_value");

-- Called when the Clockwork shared variables are added.
function PhaseFour:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("hideStealth");
	playerVars:Bool("thermal", true);
	playerVars:Bool("beingChloro", true);
	playerVars:Bool("newPlayer", true);
	playerVars:Bool("beingTied", true);
	playerVars:Bool("implant", true);
	playerVars:Number("safeboxValue");
	playerVars:Number("itemValue");
	playerVars:Number("ghostMode", true);
	playerVars:Number("knockOut", true);
	playerVars:Bool("safeZone");
	playerVars:Number("nextDC");
	playerVars:Number("fuel", true);
	playerVars:Bool("ghostheart");
	playerVars:Bool("skullMask");
	playerVars:String("alliance");
	playerVars:Entity("disguise");
	playerVars:Entity("jetpack");
	playerVars:Number("bounty");
	playerVars:String("title");
	playerVars:Number("honor");
	playerVars:Number("rank");
	playerVars:Bool("tied");
end;

Clockwork.quiz:SetName("QuizName");
Clockwork.quiz:SetEnabled(true);
Clockwork.quiz:AddQuestion("QuizOption1", 1, "QuizAnswerYes", "QuizAnswerNo");
Clockwork.quiz:AddQuestion("QuizOption2", 1, "QuizAnswerYes", "QuizAnswerNo");
Clockwork.quiz:AddQuestion("QuizOption3", 1, "QuizAnswerYes", "QuizAnswerNo");
Clockwork.quiz:AddQuestion("QuizOption4", 1, "QuizAnswerYes", "QuizAnswerNo");

RANK_RCT = 0;
RANK_PVT = 1;
RANK_SGT = 2;
RANK_LT = 3;
RANK_CPT = 4;
RANK_MAJ = 5;

-- A function to get a player's honor text.
function PhaseFour:PlayerGetHonorText(player, honor)
	if (honor >= 90) then
		return L("Honor90");
	elseif (honor >= 80) then
		return L("Honor80");
	elseif (honor >= 70) then
		return L("Honor70");
	elseif (honor >= 60) then
		return L("Honor60");
	elseif (honor >= 50) then
		return L("Honor50");
	elseif (honor >= 40) then
		return L("Honor40");
	elseif (honor >= 30) then
		return L("Honor30");
	elseif (honor >= 20) then
		return L("Honor20");
	elseif (honor >= 10) then
		return L("Honor10");
	else
		return L("Honor0");
	end;
end;

local modelGroups = {60, 61, 62};

for _, group in pairs(modelGroups) do
	for k, v in pairs(cwFile.Find("models/humans/group"..group.."/*.mdl", "GAME")) do
		if (string.find(string.lower(v), "female")) then
			Clockwork.animation:AddFemaleHumanModel("models/humans/group"..group.."/"..v);
		else
			Clockwork.animation:AddMaleHumanModel("models/humans/group"..group.."/"..v);
		end;
	end;
end;

for k, v in pairs(cwFile.Find("models/napalm_atc/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/napalm_atc/"..v);
end;

for k, v in pairs(cwFile.Find("models/nailgunner/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/nailgunner/"..v);
end;

for k, v in pairs(cwFile.Find("models/salem/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/salem/"..v);
end;

for k, v in pairs(cwFile.Find("models/bio_suit/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/bio_suit/"..v);
end;

for k, v in pairs(cwFile.Find("models/srp/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/srp/"..v);
end;

Clockwork.animation:AddMaleHumanModel("models/humans/group03/male_experim.mdl");
Clockwork.animation:AddMaleHumanModel("models/pmc/pmc_4/pmc__07.mdl");
Clockwork.animation:AddMaleHumanModel("models/tactical_rebel.mdl");
Clockwork.animation:AddMaleHumanModel("models/riot_ex2.mdl");

local MODEL_SPX7 = Clockwork.animation:AddMaleHumanModel("models/spx7.mdl");
local MODEL_SPX2 = Clockwork.animation:AddMaleHumanModel("models/spx2.mdl");
local MODEL_SPEX = Clockwork.animation:AddMaleHumanModel("models/spex.mdl");
local SPEX_MODELS = {MODEL_SPEX, MODEL_SPX2, MODEL_SPX7};

for k, v in ipairs(SPEX_MODELS) do
	Clockwork.animation:AddOverride(v, "stand_grenade_idle", "LineIdle03");
	Clockwork.animation:AddOverride(v, "stand_pistol_idle", "LineIdle03");
	Clockwork.animation:AddOverride(v, "stand_blunt_idle", "LineIdle03");
	Clockwork.animation:AddOverride(v, "stand_slam_idle", "LineIdle03");
	Clockwork.animation:AddOverride(v, "stand_fist_idle", "LineIdle03");
end;