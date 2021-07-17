ITEM.name = "Black Gas Mask"
ITEM.desc = "A rugged black gas mask."
ITEM.model = "models/sky/dropped/gasmask.mdl"
ITEM.category = "Clothing"
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.8
ITEM.outfitCategory = "mask;eyes"
ITEM.price = 5500
ITEM.flag = "0"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.8751373291, 154.96575927734, 114.09674835205),
	ang = Angle(25, 220, 0),
	entAng = Angle(11.853380203247, 0.23231868445873, -12.186507225037),
	fov = 2.7732601405786,
	
	drawHook = function(ent, w, h)
		ent:SetSkin(1)
	end,
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

ITEM:postHook("Equip", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "gasmask1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat, "models/sky/headgear/gasmask2")
		local sub = item.player:getChar():getData("submat", {})
		sub["gasmask1"] = "models/sky/headgear/gasmask2"
		item.player:getChar():setData("submat", sub)
	end
end)
ITEM:postHook("EquipUn", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "gasmask1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat)
		local sub = item.player:getChar():getData("submat", {})
		sub["gasmask1"] = nil
		item.player:getChar():setData("submat", sub)
	end
end)
ITEM:postHook("deathun", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "gasmask1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat)
	end
end)
ITEM:postHook("drop", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "gasmask1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat)
		local sub = item.player:getChar():getData("submat", {})
		sub["gasmask1"] = nil
		item.player:getChar():setData("submat", sub)
	end
end)

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