ITEM.name = "Black Gas Mask"
ITEM.desc = "A rugged black gas mask. Unfortunately, it's non-functional."
ITEM.model = "models/sky/dropped/gasmask.mdl"
ITEM.category = "Clothing"
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "mask;eyes"
ITEM.price = 400
ITEM.flag = "0"

--[[
local modelsgoodfor1 = {
	["models/sky/heads/neo.mdl"] = true,

}
]]

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
	for k,v in pairs(mats) do
		if(string.find(v, "gasmask1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat, "models/sky/headgear/gasmask2")
		local sub = item.player:getChar():getData("submat", {})
		sub["gasmask1"] = "models/sky/headgear/gasmask2"
		item.player:getChar():setData("submat")
	end
end)
ITEM:postHook("EquipUn", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in pairs(mats) do
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
	for k,v in pairs(mats) do
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
	for k,v in pairs(mats) do
		if(string.find(v, "gasmask1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat)
		local sub = item.player:getChar():getData("submat", {})
		sub["gasmask1"] = nil
		item.player:getChar():setData("submat")
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
