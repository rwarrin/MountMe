-------------------- CONFIG --------------------

local mounts = {
	{"Black Drake", true},
	{"Vitreous Stone Drake", true},
	{"Blue Proto-Drake", true},
	{"Bronze Drake", true},
	{"Violet Proto-Drake", true},
	
}
-------------------- CONFIG --------------------

local function ChooseMount(maximum)
	local number = random(1, maximum);	
	return number;	
end

function RandomMount() 
	local counter = 0;
	for key, value in pairs(mounts) do
		counter = counter + 1;
	end
	DEFAULT_CHAT_FRAME:AddMessage("Mounts = " .. counter);
	
	local choice = ChooseMount(counter);
	DEFAULT_CHAT_FRAME:AddMessage("Choice = " .. choice);
	
	DEFAULT_CHAT_FRAME:AddMessage("Name = " .. mounts[choice][1]);
	CastSpellByName(mounts[choice][1]);
	
	if(IsFlyableArea() == false and mounts[choice][2] == true) then
		choice = ChooseMount(counter);
	else
		
	end
	
end


-- Create frame for addon and register for events
local MountMe = CreateFrame("FRAME", "MountMe_Frame", UIParent);
DEFAULT_CHAT_FRAME:AddMessage("MountMe Loaded.");


