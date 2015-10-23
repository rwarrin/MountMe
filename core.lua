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

local function SummonMount(mounttype, mountcount)
	if(mounttype == "FLYING") then
		CastSpellByName(flyingmounts[ChooseMount(mountcount)][1]);	
	else -- if(mounttype == "GROUND") then
		CastSpellByName(groundmounts[ChooseMount(mountcount)][1]);
	end
end

function RandomMount() 
	local isflyablezone = IsFlyableArea();
	local currentcontinent = GetCurrentMapContinent();
	local currentzonename = GetZoneText();
	local numberofgroundmounts = GetMountCount(groundmounts);
	local numberofflyingmounts = GetMountCount(flyingmounts);
        local pathfinderachievement = select(4, GetAchievementInfo(10018));

	if(IsMounted()) then
		Dismount();
	end
	
	-- Check to see if the zone is not flyable
	if(isflyablezone == 0) then
		SummonMount("GROUND", numberofgroundmounts);
	end
		
	-- Check if the player is in Vashj'ir
	if(currentzonename == "Abyssal Depths" or currentzonename == "Shimmering Expanse" or currentzonename == "Kelp'thar Forrest") then
		if(IsSwimming()) then
			CastSpellByName("Abyssal Seahorse");
		end
	end
	
	-- Check to see if the zone is a Battleground
	if(currentcontinent == -1) then
		SummonMount("GROUND", numberofgroundmounts);
	end
	
	-- Check to see if the player can fly or not
	if(CHARACTER_CAN_FLY == true) then
		-- Check if the player is in Kalimdor
		if(currentcontinent == 1 and SKILL_OLDWORLD_FLYING == true) then
			SummonMount("FLYING", numberofflyingmounts)
		
		-- Check if the player is in Eastern Kingdoms
		elseif(currentcontinent == 2 and SKILL_OLDWORLD_FLYING == true) then
			SummonMount("FLYING", numberofflyingmounts);
					
		-- Check if the player is in Deepholm
		elseif(currentcontinent == 5 and SKILL_OLDWORLD_FLYING == true) then
			SummonMount("FLYING", numberofflyingmounts)
			
		-- Check if the player is in Outlands
		elseif(currentcontinent == 3) then
			SummonMount("FLYING", numberofflyingmounts)
		
		-- Check if the player is in Northrend
		elseif(currentcontinent == 4) then
			SummonMount("FLYING", numberofflyingmounts)

                -- Check if the player is in Panderia
                elseif(currentcontinent == 6) then
                        SummonMount("FLYING", numberofflyingmounts)

                -- Check if the player is in Draenor and has the Path Finder achievement
                elseif(currentcontinent ==  7) then
                        if(pathfinderachievement == true) then
                            SummonMount("FLYING", numberofflyingmounts)
                        else
                            SummonMount("GROUND", numberofgroundmounts)
                        end
		
		-- Player can't fly anywhere
		else
			SummonMount("GROUND", numberofgroundmounts);
		end		
	else
		SummonMount("GROUND", numberofgroundmounts);
	end
end

-- Create frame for addon and register for events
local MountMe = CreateFrame("FRAME", "MountMe_Frame", UIParent);

-- Create slash command
SLASH_MOUNTME1 = "/mountme";
SLASH_MOUNTME2 = "/mm";
SlashCmdList["MOUNTME"] = function() RandomMount(); end
