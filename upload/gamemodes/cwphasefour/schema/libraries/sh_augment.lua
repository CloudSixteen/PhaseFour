--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

PhaseFour.augment = {};
PhaseFour.augment.stored = {};
PhaseFour.augment.buffer = {};

-- A function to get the augment buffer.
function PhaseFour.augment:GetBuffer()
	return self.buffer;
end;

-- A function to get all augments.
function PhaseFour.augment:GetAll()
	return self.stored;
end;

-- A function to register a new augment.
function PhaseFour.augment:Register(augment)
	augment.uniqueID = augment.uniqueID or string.lower(string.gsub(augment.name, "%s", "_"));
	augment.index = Clockwork.kernel:GetShortCRC(augment.name);
	
	self.stored[augment.uniqueID] = augment;
	self.buffer[augment.index] = augment;
	
	Clockwork.kernel:AddFile("materials/"..augment.image..".png");
	
	return augment.uniqueID;
end;

-- A function to get an augment by its name.
function PhaseFour.augment:Get(name)
	if (not name) then return; end;
	
	if (self.buffer[name]) then
		return self.buffer[name];
	elseif (self.stored[name]) then
		return self.stored[name];
	else
		local augment = nil;
		
		for k, v in pairs(self.stored) do
			if (string.find(string.lower(v.name), string.lower(name))) then
				if (augment) then
					if (string.len(v.name) < string.len(augment.name)) then
						augment = v;
					end;
				else
					augment = v;
				end;
			end;
		end;
		
		return augment;
	end;
end;

Clockwork.kernel:IncludeDirectory(Clockwork.kernel:GetSchemaFolder().."/schema/augments/");