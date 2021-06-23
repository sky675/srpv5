ITEM.name = "SEVA Suit"
ITEM.desc = "A scientific combat outfit created for the zone."
ITEM.model = "models/sky/seperate/male_seva.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 13.4
ITEM.addWeight = 18
ITEM.width = 2
ITEM.height = 3
ITEM.outfitCategory = "armor;head;mask;eyes"
ITEM.price = 75400--70400
ITEM.flag = "4"
ITEM.size = "seva" --helm, light, medium, heavy, exo, mask, vest, sci, seva
ITEM.artifactCnt = 1

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
	return "models/sky/dropped/seva.mdl"
end

function ITEM:onGetReplacement()
	local fem = self.player:isFemale()
	if(fem) then
		return "models/sky/seperate/female_seva.mdl"
	else
		return "models/sky/seperate/male_seva.mdl"
	end
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
--[[
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
	local addonscheck = {"addon_mp_gearvest", "addon_mp_heavyarmor"}
	for k,v in pairs(inv:getItems()) do
		if(string.find(v.uniqueID, "helm_") and v:getData("equip")) then
			item = v
			mask = true
			break
		end
		
		for k2,v2 in pairs(addonscheck) do
			if(string.find(v.uniqueID, v2) and v:getData("equip")) then
				item = v
				break
			end
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
]]
--[[
--todo need a way to change forms, set rank to something at some point?
function ITEM:getCustomGS()
	local tbl = {
		type = "seperate",
		bg = 0,
	}

	if(self.player:isFemale()) then
		tbl.model = "models/sky/seperate/female_eco.mdl"
	else
		tbl.model = "models/sky/seperate/male_eco.mdl"
	end

	--submat
	
	return tbl
end
ITEM.getBodyGroups = function(item, ply)
	return {["arms"] = ply:isFemale() and 3 or 4,["hands"] = 3}
end
]]
ITEM.getBodygroupsKeep = function(item, ply)
	return {keep = true, ["arms"] = ply:isFemale() and 3 or 4,["hands"] = 3}
end

ITEM.overlaytype = "sci"

ITEM.upgradePath = "seva"
ITEM.armor = {
	chest = {level = ARMOR_IIIA},
	larm = {level = ARMOR_IIA},
	rarm = {level = ARMOR_IIA},
	lleg = {level = ARMOR_IIA},
	rleg = {level = ARMOR_IIA},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.121,
	--electric --less
	[DMG_SHOCK] = 0.425,
	--ext rad
	[DMG_RADIATION] = 0.58,
	--chem
	[DMG_ACID] = 0.44,
	--psy
	[DMG_SONIC] = 0.48,
	["psy"] = 0.48,
	--explosion
	[DMG_BLAST] = 0.32,
	--bullet fire wound
	[DMG_BULLET] = 0.233,
	--phys
	[DMG_SLASH] = 0.163,
	[DMG_CLUB] = 0.163,
	[DMG_CRUSH] = 0.163,

	spd = 0.95,
	nodrn = true,
}