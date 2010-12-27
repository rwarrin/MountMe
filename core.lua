-------------------- CONFIG --------------------

local flyingmounts = {
	{"Black Drake"},
	{"Vitreous Stone Drake"},
	{"Blue Proto-Drake"},
	{"Bronze Drake"},
	{"Violet Proto-Drake"},
	
}

local groundmounts = {
	{"Swift Brown Steed"},
	{"Swift Black War Horse"},
}

local PLAYERCANFLY = true;
local FLYABLEZONE_NORTHREND = true;
local FLYABLEZONE_OLDWORLD = true;

-------------------- CONFIG --------------------

local function ChooseMount(maximum)
	local number = random(1, maximum);	
	return number;	
end

local function GetMountCount(mountlist)
	local counter = 0;
	for i = 1, getn(mountlist) do
		counter = counter + 1;
	end
	return counter;
end

function RandomMount() 
	local isflyablezone = IsFlyableArea();
	local numberofgroundmounts = GetMountCount(groundmounts);
	local numberofflyingmounts = GetMountCount(flyingmounts);
	
	print("Flying Mount Count = " .. numberofflyingmounts .. "\nGround Mount Count = " .. numberofgroundmounts);
	
	-- Dismount player if they are already mounted
	if(IsMounted()) then
		Dismount();
	end
		
	if(isflyablezone == true) then
		-- Get the continent to see if the player can fly there
			-- if they can call a flying mount
			-- if they can't call a ground mount
	else
		-- Call a ground mount
		--CastSpellByName(groundmounts[ChooseMount(numberofgroundmounts)]);
	end	
	
end


-- Create frame for addon and register for events
local MountMe = CreateFrame("FRAME", "MountMe_Frame", UIParent);
DEFAULT_CHAT_FRAME:AddMessage("MountMe Loaded.");
