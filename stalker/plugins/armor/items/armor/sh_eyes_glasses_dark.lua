ITEM.name = "Dark Glasses"
ITEM.desc = "A pair of glasses with darkened lenses."
ITEM.model = "models/sky/dropped/glasses.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 1
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "eyes"
ITEM.price = 650
ITEM.flag = "0"
ITEM.permit = "cloth"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(70.662010192871, 57.713195800781, 44.37474822998),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0.47858771681786, 0),
	fov = 5.6258075811277,
}
ITEM.size = "nonelol" --helm, light, medium, heavy, exo, mask, vest, sci, seva

ITEM.bodyGroups = {
    ["glasses"] = 1
}

ITEM.upgradePath = "eyes"

ITEM:postHook("Equip", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "glass2")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat, "models/sky/headgear/glass_dark")
		local sub = item.player:getChar():getData("submat", {})
		sub["glass2"] = "models/sky/headgear/glass_dark"
		item.player:getChar():setData("submat", sub)
	end
end)
ITEM:postHook("EquipUn", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "glass2")) then
			mat = k-1
		end
	end
	if(mat) then
		if(item.player:isFemale()) then
			item.player:SetSubMaterial(mat)
		else
			item.player:SetSubMaterial(mat)
		end
		local sub = item.player:getChar():getData("submat", {})
		sub["glass2"] = nil
		item.player:getChar():setData("submat", sub)
	end
end)
ITEM:postHook("deathun", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "glass2")) then
			mat = k-1
		end
	end
	if(mat) then
		if(item.player:isFemale()) then
			item.player:SetSubMaterial(mat)
		else
			item.player:SetSubMaterial(mat)
		end
	end
end)
ITEM:postHook("drop", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "glass2")) then
			mat = k-1
		end
	end
	if(mat) then
		if(item.player:isFemale()) then
			item.player:SetSubMaterial(mat)
		else
			item.player:SetSubMaterial(mat)
		end
		local sub = item.player:getChar():getData("submat", {})
		sub["glass2"] = nil
		item.player:getChar():setData("submat", sub)
	end
end)

function ITEM:canWear(ply)
	local model = ply:GetModel()
	if(nut.newchar.isBM(model)) then
		return true
	else
		return false, "Your model cannot wear this item!"
	end
end