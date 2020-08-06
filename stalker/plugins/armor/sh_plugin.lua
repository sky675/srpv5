local PLUGIN = PLUGIN
PLUGIN.name = "armor"
PLUGIN.author = "sky"
PLUGIN.desc = "armor classes, and other combat related things"

--armor bullet stuff
nut.util.include("sh_armor.lua")
--downing
nut.util.include("sh_downing.lua")
--movement related stuff, disable stamina plugin, do it here instead
nut.util.include("sh_movement.lua")
--mass item creation for suits
nut.util.include("sh_itemconfig.lua")


--todo: figure out modifications i had to make to base ns?
