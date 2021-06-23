ITEM.name = "CS-3 Suit" --cs1/light novice
ITEM.desc = "A light suit used by Clear Sky. Helmets cannot be worn while wearing this. May have clipping issues with some headgear."
ITEM.model = "models/sky/seperate/male_cs3.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 5.48
ITEM.addWeight = 5
ITEM.width = 2
ITEM.height = 3
ITEM.outfitCategory = "armor"
ITEM.price = 32340
ITEM.flag = "m"
ITEM.size = "light" --helm, light, medium, heavy, exo, mask, vest, sci, seva

--interface/inv_items_cloth_2.ogg super light (masks, addons)
--interface/inv_items_cloth_3.ogg light (spd >= .7)
--interface/inv_items_cloth_1.ogg med (rest, would like something more metal but eh)
ITEM.equipSound = "interface/inv_items_cloth_2.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_2.ogg"
local matreplace = {	
	--["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_duty",
	["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_csky",
	["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_csky",
	["models/sky/stalker/cs3_lone"] = "models/sky/stalker/cs3_csky",
	["models/sky/stalker/exo_lone"] = "models/sky/stalker/exo_cs",
	--["models/sky/stalker/io7a_lone"] = "models/sky/stalker/io7a_duty",
	["models/sky/stalker/seva_lone"] = "models/sky/stalker/seva_csky",
	["models/sky/stalker/skat_lone"] = "models/sky/stalker/skat_csky",
	["models/sky/stalker/sunrise_lone"] = "models/sky/stalker/sunrise_csky",
	["models/sky/stalker/sunrise_null"] = "models/sky/stalker/sunrise_csky",
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
	return "models/sky/dropped/cs1.mdl"
end

--ITEM.upgradePath = "eyes"


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
		tbl.model = "models/sky/seperate/female_cs3.mdl"
	else
		tbl.model = "models/sky/seperate/male_cs3.mdl"
	end
	
	--moved like this, easier this way
	tbl.submat = matreplace
	if(self:getData("equip")) then --equip is true when its equipping, and not when its unequipping
		self.player:getChar():setData("oldgsub", self.player:getChar():getData("gsub", {})["t"])
	elseif(self.player:getChar():getData("oldgsub")) then
		tbl.submat = self.player:getChar():getData("oldgsub")
		self.player:getChar():setData("oldgsub")
	end
	--[[tbl.submat = {	
		["sunrise_lone"] = "",
		["sunrise_null"] = ""
	}]]
	--submat
	
	return tbl
end
--should keep them?
ITEM.getBodygroupsKeep = function(item, ply)
	local bg = {["head"] = 0, ["hair"] = 0, ["keep"] = true}
	bg["arms"] = ply:isFemale() and 3 or 4
	bg["hands"] = 3
	return bg
end
ITEM.getBodyGroups = function(item, ply)
	--if i dont copy it OVERWRITES the original table entry!!!
	local bg = table.Copy(ANORAKBODYGROUPS[ply:GetModel()]) or {}
	bg["arms"] = ply:isFemale() and 3 or 4
	bg["hands"] = 3
	return bg
end

ITEM.upgradePath = "sunrise"
ITEM.armor = {
	chest = {level = ARMOR_II},
	larm = {level = ARMOR_NONE},
	rarm = {level = ARMOR_NONE},
	lleg = {level = ARMOR_NONE},
	rleg = {level = ARMOR_NONE},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.126,
	--electric --less
	[DMG_SHOCK] = 0.24,
	--ext rad
	[DMG_RADIATION] = 0.045,
	--chem
	[DMG_ACID] = 0.148,
	--psy
	[DMG_SONIC] = 0,
	["psy"] = 0,
	--explosion
	[DMG_BLAST] = 0.24,
	--phys
	[DMG_SLASH] = 0.14,
	[DMG_CLUB] = 0.14,
	[DMG_CRUSH] = 0.14,
	--bullet fire wound
	[DMG_BULLET] = 0.208,

	spd = 0.97,
}