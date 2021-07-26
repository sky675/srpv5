ITEM.name = "CS-1 Suit" --3a/medium
ITEM.desc = "Clear Sky's heavy armor without their colors."
ITEM.model = "models/sky/seperate/male_cs1.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 12
ITEM.addWeight = 14
ITEM.width = 2
ITEM.height = 3
ITEM.outfitCategory = "armor"
ITEM.price = 111120--47120--55120
ITEM.flag = "4"
ITEM.size = "medium" --helm, light, medium, heavy, mask, vest

--interface/inv_items_cloth_2.ogg super light (masks, addons)
--interface/inv_items_cloth_3.ogg light (spd >= .7)
--interface/inv_items_cloth_1.ogg med (rest, would like something more metal but eh)
ITEM.equipSound = "interface/inv_items_cloth_3.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_3.ogg"

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
	return "models/sky/dropped/cs1.mdl"
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

ITEM.canWear = function(self, ply)
	local model = ply:GetModel()
	if(nut.newchar.isBM(model)) then
		return true
	elseif(model:find("_mask")) then
		return false, "Please unequip the mask/helmet first!"
	else
		return false, "Your model cannot wear this item!"
	end
end
ITEM.canRemove = function(self, ply)
	local model = ply:GetModel()
	local inv = ply:getChar():getInv()
	local item
	local mask = false
	for k,v in pairs(inv:getItems()) do
		if(string.find(v.uniqueID, "helm_") and v:getData("equip")) then
			item = v
			mask = true
			break
		end
	end
	if(item) then
		if(mask) then
			return false, "You need to unequip your mask first!"
		else
			return false, "You need to unequip the addon on top of it first!"
		end
	else
		return true
	end
end


--ITEM.gsresetsubmat = true --this is annoying
--todo need a way to change forms, set rank to something at some point?
function ITEM:getCustomGS()
	local tbl = {
		type = "seperate",
		bg = 0,
	}

	if(self.player:isFemale()) then
		tbl.model = "models/sky/seperate/female_cs1.mdl"
	else
		tbl.model = "models/sky/seperate/male_cs1.mdl"
	end
	tbl.submat = {}
	local exskin = self:getData("exskin")
	if(exskin and TEXTURETABLE[exskin]) then
		tbl.submat = TEXTURETABLE[exskin]
	end
	--submat
	
	return tbl
end
--should keep them?
ITEM.getBodygroupsKeep = function(item, ply)
	return {}
end
ITEM.getBodyGroups = function(item, ply)
	return {["arms"] = ply:isFemale() and 3 or 4,["hands"] = 3}
end

ITEM.upgradePath = "cs1"
ITEM.armor = {
	chest = {level = ARMOR_III},
	larm = {level = ARMOR_II},
	rarm = {level = ARMOR_II},
	lleg = {level = ARMOR_II},
	rleg = {level = ARMOR_II},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.121,
	--electric
	[DMG_SHOCK] = 0.05,
	--ext rad
	[DMG_RADIATION] = 0.145,
	--chem
	[DMG_ACID] = 0.048,
	--psy
	[DMG_SONIC] = 0,
	["psy"] = 0,
	--explosion
	[DMG_BLAST] = 0.3,
	--bullet fire wound
	[DMG_BULLET] = 0.25,
	--phys
	[DMG_SLASH] = 0.136,
	[DMG_CLUB] = 0.136,
	[DMG_CRUSH] = 0.136,

	spd = 0.89,
}