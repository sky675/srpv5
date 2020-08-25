ITEM.name = "IO7A Vest"
ITEM.desc = "A vest from a suit officially designated as 'Light Combat Suit', commonly worn by Mercenaries."
ITEM.model = "models/sky/seperate/male_io7a.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 6
ITEM.addWeight = 9
ITEM.width = 2
ITEM.height = 2
ITEM.outfitCategory = "armor"
ITEM.price = 9280
ITEM.flag = "2"


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
	return "models/sky/dropped/io7a.mdl"
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


ITEM.gsresetsubmat = true --this is annoying
--todo need a way to change forms, set rank to something at some point?
function ITEM:getCustomGS()
	local tbl = {
		type = "seperate",
		bg = 0,
	}

	local exskin = self:getData("exskin")
	if(exskin and TEXTURETABLE[exskin]) then
		tbl.submat = TEXTURETABLE[exskin]
	end
	--submat
	
	tbl.custombg = {[1] = 1}
	tbl.remove = {[1] = 0}
	tbl.removebg = -1
	
	
	return tbl
end
--should keep them?
ITEM.getBodygroupsKeep = function(item, ply)
	return {}
end
ITEM.getBodyGroups = function(item, ply)
	return {["arms"] = ply:isFemale() and 3 or 4,["hands"] = 3}
end

ITEM.upgradePath = "io7avest"
ITEM.armor = {
	chest = {level = ARMOR_IIIA},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.01,
	--electric --less
	[DMG_SHOCK] = 0.04,
	--ext rad
	[DMG_RADIATION] = 0.001,
	--chem
	[DMG_ACID] = 0.03,
	--psy
	[DMG_SONIC] = 0,
	["psy"] = 0,
	--explosion
	[DMG_BLAST] = 0.12,
	--bullet fire wound
	[DMG_BULLET] = 0.22,
	--phys
	[DMG_SLASH] = 0.15,
	[DMG_CLUB] = 0.15,
	[DMG_CRUSH] = 0.15,

	spd = 0.96,
}