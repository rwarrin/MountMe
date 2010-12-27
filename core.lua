local playername = GetUnitName("player");
local flyingmounts;
local groundmounts;
-------------------- CONFIG --------------------
--  HELP:
--  Put one of your characters names in the area
--  below.  Set up the mounts you would like to
--  choose from, as well as riding skills. If
--  you don't do this you probably won't like
--  the default configuration.

if(playername == "Astiroth") then
	flyingmounts = {
		{"Vitreous Stone Drake"},
		{"Blue Proto-Drake"},		
	}

	groundmounts = {
		{"Swift Brown Steed"},
	}
	
	CHARACTER_CAN_FLY = true;
	SKILL_NORTHREND_FLYING = true;
	SKILL_OLDWORLD_FLYING = true;
	
elseif(playername == "AnotherCharacter") then
	flyingmounts = {
			
		}

		groundmounts = {

		}
		
		CHARACTER_CAN_FLY = false;
		SKILL_NORTHREND_FLYING = false;
		SKILL_OLDWORLD_FLYING = false;
else
	flyingmounts = {
		{"Black Drake"},
		
	}

	groundmounts = {
		{"Swift Brown Steed"},
	}

	CHARACTER_CAN_FLY = false;
	SKILL_NORTHREND_FLYING = false;
	SKILL_OLDWORLD_FLYING = false;
end
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
	local currentcontinent = GetCurrentMapContinent();
	local numberofgroundmounts = GetMountCount(groundmounts);
	local numberofflyingmounts = GetMountCount(flyingmounts);
	
	-- Dismount player if they are already mounted
	if(IsMounted()) then
		Dismount();
	end
		
	if(CHARACTER_CAN_FLY == true) then
		if(isflyablezone == 1) then
			if(currentcontinent == -1) then -- Battleground
				CastSpellByName(groundmounts[ChooseMount(numberofgroundmounts)][1]);
			elseif(currentcontinent == 1 or currentcontinent == 2) then -- Kalimdor or Eastern Kingdoms
				if(SKILL_OLDWORLD_FLYING == true) then
					CastSpellByName(flyingmounts[ChooseMount(numberofflyingmounts)][1]);
				else
					CastSpellByName(groundmounts[ChooseMount(numberofgroundmounts)][1]);
				end
			elseif(currentcontinent == 3) then -- Outlands
					CastSpellByName(flyingmounts[ChooseMount(numberofflyingmounts)][1]);
			elseif(currentcontinent == 3) then -- Northrend
				if(SKILL_NORTHREND_FLYING == true) then
					CastSpellByName(flyingmounts[ChooseMount(numberofflyingmounts)][1]);
				else
					CastSpellByName(groundmounts[ChooseMount(numberofgroundmounts)][1]);
				end
			end
		else
			CastSpellByName(groundmounts[ChooseMount(numberofgroundmounts)][1]);
		end	
	else
		CastSpellByName(groundmounts[ChooseMount(numberofgroundmounts)][1]);
	end
end

-- Create frame for addon and register for events
local MountMe = CreateFrame("FRAME", "MountMe_Frame", UIParent);
DEFAULT_CHAT_FRAME:AddMessage("MountMe Loaded.");

-- Create slash command
SLASH_MOUNTME1 = "/mountme";
SLASH_MOUNTME2 = "/mm";
SlashCmdList["MOUNTME"] = function() RandomMount(); end




