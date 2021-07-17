ITEM.name = "SSh-40 Helmet"
ITEM.desc = "A World War II-era helmet used by the Soviet Union. May clip with some headgear."
ITEM.model = "models/sky/dropped/helm_rus_ww2.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.3
ITEM.outfitCategory = "head"
ITEM.price = 6000
ITEM.flag = "0"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.8751373291, 154.96575927734, 114.09674835205),
	ang = Angle(25, 220, 0),
	entAng = Angle(11.853380203247, 0.23231868445873, -12.186507225037),
	fov = 2.7732601405786,
}
ITEM.size = "helm" --helm, light, medium, heavy, exo, mask, vest, sci, seva

--interface/inv_items_cloth_2.ogg masks
--interface/inv_items_cloth_3.ogg helms works i guess?
ITEM.equipSound = "interface/inv_items_cloth_2.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_2.ogg"
--[[
local modelsgoodfor1 = {
	["models/sky/heads/neo.mdl"] = true,

}
]]

local validBgs = {
	["models/sky/heads/female_02.mdl"] = {
		["head"] = 2,
	},
	["models/sky/heads/female_03.mdl"] = {
		["head"] = 2,
	},
	["models/sky/heads/female_08.mdl"] = {
		["head"] = 1,
		["hair"] = 1
	},
	["models/sky/heads/female_10.mdl"] = {
		--["head"] = 2,
	},
	["models/sky/heads/female_18.mdl"] = {
		["head"] = 1,
		["hair"] = 1
	},
	["models/sky/heads/quiet.mdl"] = {
		--["head"] = 2,
	},
}

function ITEM:getBodyGroups(ply)
	local bg = {["beanie"] = 6}
	if(!ply:isFemale()) then
		bg = {["beanies"] = 6}
	end
	--if(ply:GetBodygroupCount(1) == 3 and !ply:GetModel():find("neo")) then --if theres 2 heads and a blank
	--	bg["head"] = 1 --get the 2nd head, otherwise its fine, the heads wont clip
	--end 
	local val = validBgs[ply:GetModel()]
	if(val) then
		for k,v in pairs(val) do
			bg[k] = v
		end
	else
		local hair = ply:FindBodygroupByName("hair")
		if(hair != -1 and ply:GetBodygroupCount(hair) == 3) then --hide hair too
			bg["hair"] = 2
		elseif(hair != -1) then
			bg["hair"] = 1
		end
	end
	return bg
end

function ITEM:canWear(ply)
	local model = ply:GetModel()
	if(model:find("sky/stalker") or nut.newchar.isBM(model)) then
		if(model:find("cs3")) then return false, "Helmets can not be worn with the CS3!" end
		return true
	else
		return false, "Your model cannot wear this item!"
	end
end

ITEM.armor = {
	head = {level = ARMOR_II},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0,
	--electric --less
	[DMG_SHOCK] = 0,
	--ext rad
	[DMG_RADIATION] = 0,
	--chem
	[DMG_ACID] = 0,
	--psy
	[DMG_SONIC] = 0,
	["psy"] = 0,
	--explosion
	[DMG_BLAST] = 0.1,
	--phys
	[DMG_SLASH] = 0.01,
	[DMG_CLUB] = 0.01,
	[DMG_CRUSH] = 0.01,
	--bullet fire wound
	[DMG_BULLET] = 0.01,

	spd = 0.99,
}