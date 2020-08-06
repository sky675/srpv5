ITEM.name = "Respirator"
ITEM.desc = "A half-face respirator. Non-functional."
ITEM.icon = Material("sky/itemicons/respirator.png")
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "mask"
ITEM.price = 500
ITEM.flag = "0"

ITEM.bodyGroups = {
    ["masks"] = 3
}

ITEM.destroyval = {
	["comp_scrap_metal"] = 2,
}

function ITEM:canWear(ply)
	local model = ply:GetModel()
	if(model:find("sky/stalker") or nut.newchar.isBM(model)) then
		return true
	else
		return false, "Your model cannot wear this item!"
	end
end