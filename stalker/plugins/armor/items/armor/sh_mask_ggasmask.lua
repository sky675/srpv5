ITEM.name = "Green Gas Mask"
ITEM.desc = "A rugged green gas mask."
ITEM.model = "models/sky/dropped/gasmask.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "mask;eyes"
ITEM.price = 400
ITEM.flag = "0"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.8751373291, 154.96575927734, 114.09674835205),
	ang = Angle(25, 220, 0),
	entAng = Angle(11.853380203247, 0.23231868445873, -12.186507225037),
	fov = 2.7732601405786,
}
ITEM.size = "mask" --helm, light, medium, heavy, exo, mask, vest, sci, seva

--interface/inv_items_cloth_2.ogg masks
--interface/inv_items_cloth_3.ogg helms works i guess?
ITEM.equipSound = "interface/inv_items_cloth_2.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_2.ogg"
--[[
local modelsgoodfor1 = {
	["models/sky/heads/neo.mdl"] = true,

}
]]
ITEM.overlaytype = "gas"
local immune = {
	
}

function ITEM:getBodyGroups(ply)
	local bg = {["masks"] = 2}

	local hair = ply:FindBodygroupByName("hair")
	if(hair != -1 and ply:GetBodygroupCount(hair) == 3) then --hide hair too
		--if(modelsgoodfor1[ply:GetModel()]) then 
			if(!string.find(ply:GetModel(), "neo")) then
				bg["hair"] = 1
			end
		--[[else
			bg["hair"] = 2
		end]]
	elseif(hair != -1) then
		bg["hair"] = 1
	end

	return bg
end

function ITEM:canWear(ply)
	local model = ply:GetModel()
	if(model:find("sky/stalker") or nut.newchar.isBM(model)) then
		return true
	else
		return false, "Your model cannot wear this item!"
	end
end

ITEM.armor = {
	head = {level = ARMOR_NONE},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.004,
	--electric --less
	[DMG_SHOCK] = 0.015,
	--ext rad
	[DMG_RADIATION] = 0.199,
	--chem
	[DMG_ACID] = 0.148,
	--psy
	[DMG_SONIC] = 0.005,
	["psy"] = 0.005,
	--explosion
	[DMG_BLAST] = 0.22,
	--phys
	[DMG_SLASH] = 0.014,
	[DMG_CLUB] = 0.014,
	[DMG_CRUSH] = 0.014,
	--bullet fire wound
	[DMG_BULLET] = 0.012,

	spd = 0.99,
}