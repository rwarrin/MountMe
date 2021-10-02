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
	local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();
	local currentzonename = GetRealZoneText();
	local numberofgroundmounts = GetMountCount(groundmounts);
	local numberofflyingmounts = GetMountCount(flyingmounts);
	local pathfinderachievementDraenor = select(4, GetAchievementInfo(10018));
	local pathfinderachievementLegion = select(4, GetAchievementInfo(11446));
	local pathfinderachievementBfA = select(4, GetAchievementInfo(13250));
	local pathfinderQuestShadowlands = C_QuestLog.IsQuestFlaggedCompleted(63727);

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
	if(instanceID == -1) then
		SummonMount("GROUND", numberofgroundmounts);
	end
	
	-- Check to see if the player can fly or not
	if(CHARACTER_CAN_FLY == true) then
		-- Check if the player is in Kalimdor
		if(instanceID == 1 and SKILL_OLDWORLD_FLYING == true) then
			SummonMount("FLYING", numberofflyingmounts)
		
		-- Check if the player is in Eastern Kingdoms
		elseif(instanceID == 2 and SKILL_OLDWORLD_FLYING == true) then
			SummonMount("FLYING", numberofflyingmounts);
					
		-- Check if the player is in Deepholm
		elseif(instanceID == 5 and SKILL_OLDWORLD_FLYING == true) then
			SummonMount("FLYING", numberofflyingmounts)
			
		-- Check if the player is in Outlands
		elseif(instanceID == 530) then
			SummonMount("FLYING", numberofflyingmounts)
		
		-- Check if the player is in Northrend
		elseif(instanceID == 571) then
			SummonMount("FLYING", numberofflyingmounts)

		-- Check if the player is in Panderia
		elseif(instanceID == 860 or instanceID == 870 or instanceID == 1064) then
				SummonMount("FLYING", numberofflyingmounts)

		-- Check if the player is in Draenor and has the Path Finder achievement
		elseif(instanceID == 1116 or instanceID == 1191 or instanceID == 1464) then
				if(pathfinderachievementDraenor == true) then
					SummonMount("FLYING", numberofflyingmounts)
				else
					SummonMount("GROUND", numberofgroundmounts)
				end

		-- Check if the player is in Broken Isles and has the Path Finder achievement
		elseif(instanceID == 1220 or instanceID == 1669) then
			if(pathfinderachievementLegion == true) then
				SummonMount("FLYING", numberofflyingmounts)
			else
				SummonMount("GROUND", numberofgroundmounts)
							end
									
		-- Check if the player is in Kul Tiras and Zandalar and has the Path Finder achievement
		elseif(instanceID == 1642 or instanceID == 1643 or instanceID == 1718) then
			if(pathfinderachievementBfA == true) then
					SummonMount("FLYING", numberofflyingmounts)
			else
					SummonMount("GROUND", numberofgroundmounts)
			end

		-- Check if the player is in Shadowlands zones and as the Path Finder quest complete
		elseif(instanceID == 2222) then
			if (pathfinderQuestShadowlands == true) then
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
