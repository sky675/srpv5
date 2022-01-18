PLUGIN.name = "Rarity Stuff"
PLUGIN.author = "sky"
PLUGIN.desc = "some backend stuff for rarity consistency and stuff"
--this was backend stuff for another project that i just left here lmao
--correct usage is to call RarityText(num) in item desc strings
local enableRarity = true --uh just in case lol

--rarity stuff
RARITY_JUNK = -1
RARITY_COMMON = 0
RARITY_UNCOMMON = 1
RARITY_RARE = 2
RARITY_EPIC = 3
RARITY_PROTOTYPE = 4

--um im just gonna use this lmao
RARITY_NOTWARN = 89
RARITY_NOTNOTIF = 90
RARITY_NOTATT = 91

RARITY_COLORS = {
	[RARITY_JUNK] = Color(96,96,96,255),
	[RARITY_COMMON] = Color(200,200,200,255),
	[RARITY_UNCOMMON] = Color(22,137,9),
	[RARITY_RARE] = Color(29,29,197),
	[RARITY_EPIC] = Color(96,8,147),
	[RARITY_PROTOTYPE] = Color(219,4,112),

	
	[RARITY_NOTWARN] = Color(255, 10, 0, 255),
	[RARITY_NOTATT] = Color(255, 215, 0, 255),
}
RARITY_NAMES = {
	[RARITY_JUNK] = "Junk",
	[RARITY_COMMON] = "Civilian", --common
	[RARITY_UNCOMMON] = "Aftermarket", --uncommon
	[RARITY_RARE] = "Blackmarket", --rare
	[RARITY_EPIC] = "Military", --epic
	[RARITY_PROTOTYPE] = "Prototype", --legendary/unique
}

--very quick util function thats out of place
function RarityText(rarity)
	if(!enableRarity) then return end
	if(RARITY_COLORS[rarity]) then
		local color = RARITY_COLORS[rarity] or color_white --doing it this way i guess
		return "Rarity: <color="..color.r..", "..color.g..", "..color.b..">"..(RARITY_NAMES[rarity] or "Unnamed").."</color>\n"
	end
end