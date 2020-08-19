ITEM.name = "SSP-99 Suit"
ITEM.desc = "A suit specifically designed for scientific expeditions into the Zone."
ITEM.model = "models/sky/seperate/male_eco.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 15.4
ITEM.addWeight = 15
ITEM.width = 2
ITEM.height = 3
ITEM.outfitCategory = "armor;head;mask;eyes" --idk for now
ITEM.price = 143500
ITEM.flag = "4"


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
	return "models/sky/dropped/eco.mdl"
end

function ITEM:onGetReplacement()
	local fem = self.player:isFemale()
	if(fem) then
		return "models/sky/seperate/female_eco.mdl"
	else
		return "models/sky/seperate/male_eco.mdl"
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


ITEM.gsresetsubmat = true --this is annoying
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
--should keep them?
ITEM.getBodygroupsKeep = function(item, ply)
	return {["head"] = 0}
end
ITEM.getBodyGroups = function(item, ply)
	--always hide head
	local mx = ply:GetBodygroupCount(ply:FindBodygroupByName("head"))-1
	return {["arms"] = ply:isFemale() and 3 or 4,["hands"] = 3,["head"] = mx}
end
]]
ITEM.upgradePath = "eco"
ITEM.armor = {
	chest = {level = ARMOR_II},
	larm = {level = ARMOR_NONE},
	rarm = {level = ARMOR_NONE},
	lleg = {level = ARMOR_NONE},
	rleg = {level = ARMOR_NONE},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.65,
	--electric --less
	[DMG_SHOCK] = 0.9,
	--ext rad
	[DMG_RADIATION] = 0.035,
	--chem
	[DMG_ACID] = 0.135,
	--psy
	[DMG_SONIC] = 0.135,
	["psy"] = 0.135,
	--explosion
	[DMG_BLAST] = 0.05,
	--bullet fire wound
	[DMG_BULLET] = 0.14,
	--phys
	[DMG_SLASH] = 0.16,
	[DMG_CLUB] = 0.16,
	[DMG_CRUSH] = 0.16,

	spd = 0.92,
}