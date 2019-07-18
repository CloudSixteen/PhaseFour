--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("Refer");

COMMAND.tip = "CmdRefer";
COMMAND.text = "CmdReferDesc";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE, CMD_FALLENOVER);
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (!Clockwork.config:Get("referral_system"):Get()) then
		Clockwork.player:Notify("[Referral Program] The referral system is not currently active on this server!");
		return;
	end;
	
	local referCode = table.concat(arguments, " ");
	local referrer = nil;
	
	for k, v in ipairs(_player.GetAll()) do
		if (v:HasInitialized()) then
			if (util.CRC(v:SteamID()) == referCode) then
				referrer = v;
				break;
			end;
		end;
	end;
	
	if (!referrer) then
		Clockwork.player:Notify("[Referral Program] There are no players currently online with that referral code, make sure your referrer is in-game too!");
		return;
	end;
	
	if (player:GetData("WasReferred")) then
		Clockwork.player:Notify("[Referral Program] You have already been referred to play by another player, you cannot be referred twice!");
		return;
	end;
	
	local referCash = Clockwork.config:Get("referral_cash"):Get();
	local formatted = Clockwork.kernel:FormatCash(referCash);
	
	player:SetData("WasReferred", true);
	
	Clockwork.player:GiveCash(player, referCash, "Referred by "..referrer:Name());
	Clockwork.player:GiveCash(referrer, referCash, "Referred "..player:Name());
	
	PhaseFour:SendInfoHint(player, "Received "..formatted.." for being referred by "..referrer:Name().."!");
	PhaseFour:SendInfoHint(referrer, "Received "..formatted.." for referring "..player:Name().." to play!");
end;

COMMAND:Register();