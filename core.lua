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




