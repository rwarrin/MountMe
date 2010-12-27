local playername = GetUnitName("player");
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