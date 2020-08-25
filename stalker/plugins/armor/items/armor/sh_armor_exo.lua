ITEM.name = "Exoskeleton"
ITEM.desc = "An exoskeleton."
ITEM.model = "models/sky/seperate/male_radsuit.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 48
ITEM.addWeight = 113
ITEM.width = 2
ITEM.height = 3
ITEM.outfitCategory = "armor"
ITEM.price = 136680
ITEM.flag = "5"


ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(80.053802490234, 0, 49.822090148926),
	ang = Angle(0, 180, 0),
	entAng = Angle(0, 0, 0),
	fov = 14.763357201488,
	
	drawHook = function(ent, w, h)
		ent:SetBodygroup(1,1)
	end,
}
ITEM.onGetDropModel = function(item, ent)
	return "models/sky/dropped/exo.mdl"
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

	if(self.player:isFemale()) then
		tbl.model = "models/sky/seperate/female_radsuit.mdl"
	else
		tbl.model = "models/sky/seperate/male_radsuit.mdl"
	end

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

ITEM.upgradePath = "rad"
ITEM.armor = {
	chest = {level = ARMOR_IV},
	larm = {level = ARMOR_III},
	rarm = {level = ARMOR_III},
	lleg = {level = ARMOR_III},
	rleg = {level = ARMOR_III},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.08,
	--electric --less
	[DMG_SHOCK] = 0.4,
	--ext rad
	[DMG_RADIATION] = 0.03,
	--chem
	[DMG_ACID] = 0.032,
	--psy
	[DMG_SONIC] = 0.07,
	["psy"] = 0.07,
	--explosion
	[DMG_BLAST] = 0.96,
	--bullet fire wound
	[DMG_BULLET] = 0.58,
	--phys
	[DMG_SLASH] = 0.64,
	[DMG_CLUB] = 0.64,
	[DMG_CRUSH] = 0.64,

	spd = 0.5,
	nospr = true,
}