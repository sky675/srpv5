ITEM.name = "Military Berill-5M Armored Suit"
ITEM.desc = "Military issued Berill-5M."
ITEM.model = "models/sky/seperate/male_berill.mdl"
ITEM.category = "Clothing"
ITEM.skin = 5
ITEM.weight = 12
ITEM.addWeight = 16
ITEM.width = 2
ITEM.height = 3
ITEM.outfitCategory = "armor"
ITEM.price = 40300
ITEM.flag = "M"

--the materials to be replaced on the model
local matreplace = {	
	["beri_lone"] = "models/sky/stalker/beri_mili",
	["cs1_lone"] = "models/sky/stalker/cs1_dawn",
	["cs2_lone"] = "models/sky/stalker/cs2_blak",
	["exo_lone"] = "models/sky/stalker/exo_wood",
	["io7a_lone"] = "models/sky/stalker/io7a_military",
	["seva_lone"] = "models/sky/stalker/seva_midn",
	["skat_lone"] = "models/sky/stalker/skat_mili",
	["sunrise_lone"] = "models/sky/stalker/psz9d_acu1",
	["sunrise_null"] = "models/sky/stalker/psz9d_acu1",

}

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(80.053802490234, 0, 49.822090148926),
	ang = Angle(0, 180, 0),
	entAng = Angle(0, 0, 0),
	fov = 14.763357201488,
	
	drawHook = function(ent, w, h)
		local repl = matreplace
		local mats = ent:GetMaterials()
		for k2,v2 in pairs(repl) do
			local mat
			for k,v in pairs(mats) do
				if(string.find(v, k2)) then
					mat = k-1
				end
			end
			if(mat) then
				ent:SetSubMaterial(mat, v2)
			end
		end
	end,
}
ITEM.onGetDropModel = function(item, ent)
	return "models/sky/dropped/berill.mdl"
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
		tbl.model = "models/sky/seperate/female_berill.mdl"
	else
		tbl.model = "models/sky/seperate/male_berill.mdl"
	end

	--moved like this, easier this way
	tbl.submat = matreplace
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

ITEM.upgradePath = "berill"
ITEM.armor = {
	chest = {level = ARMOR_III},
	larm = {level = ARMOR_IIA},
	rarm = {level = ARMOR_IIA},
	lleg = {level = ARMOR_IIA},
	rleg = {level = ARMOR_IIA},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.07,
	--electric
	[DMG_SHOCK] = 0.34,
	--ext rad
	[DMG_RADIATION] = 0.005,
	--chem
	[DMG_ACID] = 0.02,
	--psy
	[DMG_SONIC] = 0,
	["psy"] = 0,
	--explosion
	[DMG_BLAST] = 0.5,
	--bullet fire wound
	[DMG_BULLET] = 0.31,
	--phys
	[DMG_SLASH] = 0.75,
	[DMG_CLUB] = 0.75,
	[DMG_CRUSH] = 0.75,

	spd = 0.75,
}