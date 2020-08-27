ITEM.name = "Black Bandana Mask"
ITEM.desc = "A plain black bandana."
ITEM.model = "models/sky/dropped/facewrap.mdl"
ITEM.category = "Clothing"
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "mask"
ITEM.price = 300
ITEM.flag = "0"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.8751373291, 155.62265014648, 113.1254196167),
	ang = Angle(25, 220, 0),
	entAng = Angle(11.853380203247, 0.23231868445873, -12.186507225037),
	fov = 1.8945359089173,
	
	drawHook = function(ent, w, h)
		ent:SetSkin(1)
	end,
}

ITEM.bodyGroups = {
    ["masks"] = 1
}

ITEM.destroyval = {
	["comp_scrap_cloth"] = 1,
}

ITEM:postHook("Equip", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "facewrap1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat, "models/sky/headgear/facewrap2")
		local sub = item.player:getChar():getData("submat", {})
		sub["facewrap1"] = "models/sky/headgear/facewrap2"
		item.player:getChar():setData("submat", sub)
	end
end)
ITEM:postHook("EquipUn", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "facewrap1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat)
		local sub = item.player:getChar():getData("submat", {})
		sub["facewrap1"] = nil
		item.player:getChar():setData("submat", sub)
	end
end)
ITEM:postHook("deathun", function(item, result, data)
	local mats = item.player:GetMaterials()
	local mat
	for k,v in ipairs(mats) do
		if(string.find(v, "facewrap1")) then
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
		if(string.find(v, "facewrap1")) then
			mat = k-1
		end
	end
	if(mat) then
		item.player:SetSubMaterial(mat)
		local sub = item.player:getChar():getData("submat", {})
		sub["facewrap1"] = nil
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