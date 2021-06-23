ITEM.name = "Armored Anorak"
ITEM.desc = "An anorak with light armor."
ITEM.model = "models/sky/seperate/male_anorak.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 3
ITEM.addWeight = 0
ITEM.width = 2
ITEM.height = 2
ITEM.outfitCategory = "armor"
ITEM.price = 12230--2280
ITEM.flag = "2"
ITEM.size = "vest" --helm, light, medium, heavy, mask, vest

--interface/inv_items_cloth_2.ogg super light (masks, addons)
--interface/inv_items_cloth_3.ogg light (spd >= .7)
--interface/inv_items_cloth_1.ogg med (rest, would like something more metal but eh)
ITEM.equipSound = "interface/inv_items_cloth_2.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_2.ogg"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(80.053802490234, 0, 49.822090148926),
	ang = Angle(0, 180, 0),
	entAng = Angle(0, 0, 0),
	fov = 14.763357201488,
	
	drawHook = function(ent, w, h)
		
	end,
}
ITEM.onGetDropModel = function(item, ent)
	return "models/sky/dropped/anorak.mdl"
end

--ITEM.upgradePath = "eyes"

--[[
function ITEM:getName()
	--todo change name depending on rank?
	
	local dataRank = self:getData("rank", "default")
	local name = ""

	if(SCHEMA.rankMods[dataRank]) then
		name = SCHEMA.rankMods[dataRank].name
	else
		name = SCHEMA.rankMods["RCT"].name --idk
	end

	return name.." (Male)"
end
]]

ITEM.upgradePath = "anorakarmor"
ITEM.armor = {
	chest = {level = ARMOR_I},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.105,
	--electric --less
	[DMG_SHOCK] = 0.1075,
	--ext rad
	[DMG_RADIATION] = 0,
	--chem
	[DMG_ACID] = 0.152,
	--psy
	[DMG_SONIC] = 0,
	["psy"] = 0,
	--explosion
	[DMG_BLAST] = 0.1,
	--bullet fire wound
	[DMG_BULLET] = 0.18,
	--phys
	[DMG_SLASH] = 0.1,
	[DMG_CLUB] = 0.1,
	[DMG_CRUSH] = 0.1,

	spd = 0.99,
}