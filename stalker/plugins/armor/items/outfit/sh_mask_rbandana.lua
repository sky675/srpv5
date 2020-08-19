ITEM.name = "Red Bandana Mask"
ITEM.desc = "A red paisley bandana."
ITEM.model = "models/sky/dropped/facewrap.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
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
}

ITEM.bodyGroups = {
    ["masks"] = 1
}

ITEM.destroyval = {
	["comp_scrap_cloth"] = 1,
}

function ITEM:canWear(ply)
	local model = ply:GetModel()
	if(model:find("sky/stalker") or nut.newchar.isBM(model)) then
		return true
	else
		return false, "Your model cannot wear this item!"
	end
end