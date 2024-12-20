ITEM.name = "CS-2 Suit"--cs2/light
ITEM.desc = "Clear Sky's medium set of armor."
ITEM.model = "models/sky/seperate/male_cs2.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 8
ITEM.addWeight = 12
ITEM.width = 2
ITEM.height = 3
ITEM.outfitCategory = "armor"
ITEM.price = 60250--40250--38250
ITEM.flag = "m"
ITEM.fakeFaction = FACTION_CLEARSKY
ITEM.size = "light" --helm, light, medium, heavy, mask, vest

--interface/inv_items_cloth_2.ogg super light (masks, addons)
--interface/inv_items_cloth_3.ogg light (spd >= .7)
--interface/inv_items_cloth_1.ogg med (rest, would like something more metal but eh)
ITEM.equipSound = "interface/inv_items_cloth_3.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_3.ogg"
--the materials to be replaced on the model
local matreplace = {	
	--["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_duty",
	["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_csky",
	["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_csky",
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
	return "models/sky/dropped/cs1.mdl" --:(
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
		tbl.model = "models/sky/seperate/female_cs2.mdl"
	else
		tbl.model = "models/sky/seperate/male_cs2.mdl"
	end

	--submat
	--moved like this, easier this way
	tbl.submat = matreplace
	if(self:getData("equip")) then --equip is true when its equipping, and not when its unequipping
		self.player:getChar():setData("oldgsub", self.player:getChar():getData("gsub", {})["t"])
	elseif(self.player:getChar():getData("oldgsub")) then
		tbl.submat = self.player:getChar():getData("oldgsub")
		self.player:getChar():setData("oldgsub")
	end
	
	return tbl
end
--should keep them?
ITEM.getBodygroupsKeep = function(item, ply)
	return {}
end
ITEM.getBodyGroups = function(item, ply)
	return {["arms"] = ply:isFemale() and 3 or 4,["hands"] = 3}
end

ITEM.upgradePath = "cs2"
ITEM.armor = {
	chest = {level = ARMOR_IIIA},
	larm = {level = ARMOR_IIA},
	rarm = {level = ARMOR_IIA},
	lleg = {level = ARMOR_NONE},
	rleg = {level = ARMOR_NONE},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.087,
	--electric --less
	[DMG_SHOCK] = 0.225,
	--ext rad
	[DMG_RADIATION] = 0.081,
	--chem
	[DMG_ACID] = 0.156,
	--psy
	[DMG_SONIC] = 0,
	["psy"] = 0,
	--explosion
	[DMG_BLAST] = 0.1,
	--bullet fire wound
	[DMG_BULLET] = 0.166,
	--phys
	[DMG_SLASH] = 0.09,
	[DMG_CLUB] = 0.09,
	[DMG_CRUSH] = 0.09,

	spd = 0.95,
}