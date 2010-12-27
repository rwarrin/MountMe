MountMe
========================


About
------------------------
MountMe is an AddOn for World of Warcraft.

Its purpose is to give players the ability to summon random mounts of their choosing on a per-character basis.

It was created to be a lite version of other addons that also have the same purpose.


Configuration
------------------------
There is no in-game config menu, so all editing must be done in a text editor of your choice.

Adding support for a character is quite simple, follow these steps to make MountMe work for you.

1)    Add your characters name to config by editing one of these lines.  Replace 'PlayerName' with the name of the character you want to add support for.

		if(playername == "PlayerName") then  
	
		elseif(playername == "PlayerName") then 
		
2)    Fill in the names of mounts you want to randomly be mounted on:

		flyingmounts = {
			{"Vitreous Stone Drake"},
			{"Blue Proto-Drake"},		
		}

		groundmounts = {
			{"Swift Brown Steed"},
		}
		
3)    Finally configure your flying ability

	CHARACTER_CAN_FLY = true;
	SKILL_NORTHREND_FLYING = true;
	SKILL_OLDWORLD_FLYING = true;

	
Using it
-----------------------
There are two slash commands available to you to call a random mount.  You can type them each time you want to mount or if you want to add it to your action bar and hotkey it then you can add them to a macro.

They are:
	
	/mountme
	/mm
	
