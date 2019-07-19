--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

PhaseFour.victory = {};
PhaseFour.victory.stored = {};
PhaseFour.victory.buffer = {};

-- A function to get the victory buffer.
function PhaseFour.victory:GetBuffer()
	return self.buffer;
end;

-- A function to get all victorys.
function PhaseFour.victory:GetAll()
	return self.stored;
end;

-- A function to register a new victory.
function PhaseFour.victory:Register(victory)
	victory.uniqueID = victory.uniqueID or string.lower(string.gsub(victory.name, "%s", "_"));
	victory.index = Clockwork.kernel:GetShortCRC(victory.name);
	
	if (victory.reward and victory.description) then
		victory.description = victory.description;
	end;
	
	self.stored[victory.uniqueID] = victory;
	self.buffer[victory.index] = victory;
	
	Clockwork.kernel:AddFile("materials/"..victory.image..".png");
	
	return victory.uniqueID;
end;

-- A function to get an victory by its name.
function PhaseFour.victory:Get(name)
	if (name) then
		if (self.buffer[name]) then
			return self.buffer[name];
		elseif (self.stored[name]) then
			return self.stored[name];
		else
			local victory = nil;
			
			for k, v in pairs(self.stored) do
				if (string.find(string.lower(v.name), string.lower(name))) then
					if (victory) then
						if (string.len(v.name) < string.len(victory.name)) then
							victory = v;
						end;
					else
						victory = v;
					end;
				end;
			end;
			
			return victory;
		end;
	end;
end;

Clockwork.kernel:IncludeDirectory(Clockwork.kernel:GetSchemaFolder().."/schema/victories/");