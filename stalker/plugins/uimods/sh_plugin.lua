PLUGIN.name = "UI changes"
PLUGIN.author = "sky"
PLUGIN.desc = "does some ui stuff maybe idk (currently empty)"

--[[ideas:
	- implement stalker hud?
	- try and make the inv look more like stalker?
	- show hunger/thirst/etc bars in inv? idk
]]

nut.util.include("sh_invrefresh.lua")

if(SERVER) then

else --client
	--hook.Add("PostDrawInventory", "uidraw", function(panel)
	
	--end)

end