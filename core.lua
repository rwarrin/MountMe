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

local function SummonGroundMount(numberofgroundmounts)
	CastSpellByName(groundmounts[ChooseMount(numberofgroundmounts)][1]);
end

local function SummonFlyingMount(numberofflyingmounts)
	CastSpellByName(flyingmounts[ChooseMount(numberofflyingmounts)][1]);
end

function RandomMount() 
	local isflyablezone = IsFlyableArea();
	local currentcontinent = GetCurrentMapContinent();
	local currentzonename = GetZoneText();
	local numberofgroundmounts = GetMountCount(groundmounts);
	local numberofflyingmounts = GetMountCount(flyingmounts);

	if(IsMounted()) then
		Dismount();
	end
	
	-- Check if the player is in Vashj'ir
	if(currentzonename == "Abyssal Depths" or currentzonename == "Shimmering Expanse" or currentzonename == "Kelp'thar Forrest") then
		if(IsSwimming()) then
			CastSpellByName("Abyssal Seahorse");
		end
	end
		
	if(CHARACTER_CAN_FLY == true) then
		if(isflyablezone == 1) then
			if(currentcontinent == -1) then -- Battleground
				SummonGroundMount(numberofgroundmounts);
			elseif(currentcontinent == 1 or currentcontinent == 2 or currentcontinent == 5) then -- Kalimdor or Eastern Kingdoms or Deepholm
				if(SKILL_OLDWORLD_FLYING == true) then
					SummonFlyingMount(numberofflyingmounts);
				else
					SummonGroundMount(numberofgroundmounts);
				end
			elseif(currentcontinent == 3) then -- Outlands
					SummonFlyingMount(numberofflyingmounts);
			elseif(currentcontinent == 4) then -- Northrend
				if(SKILL_NORTHREND_FLYING == true) then
					SummonFlyingMount(numberofflyingmounts);
				else
					SummonGroundMount(numberofgroundmounts);
				end
			end
		else
			SummonGroundMount(numberofgroundmounts);
		end	
	else
		SummonGroundMount(numberofgroundmounts);
	end
end

-- Create frame for addon and register for events
local MountMe = CreateFrame("FRAME", "MountMe_Frame", UIParent);
DEFAULT_CHAT_FRAME:AddMessage("MountMe Loaded.");

-- Create slash command
SLASH_MOUNTME1 = "/mountme";
SLASH_MOUNTME2 = "/mm";
SlashCmdList["MOUNTME"] = function() RandomMount(); end