ITEM.name = "Surgical Mask"
ITEM.desc = "A white surgical mask."
ITEM.icon = Material("sky/itemicons/surgicalmask.png")
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "mask"
ITEM.price = 300
ITEM.flag = "0"

ITEM.equipSound = "interface/inv_items_cloth_2.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_2.ogg"

ITEM.bodyGroups = {
    ["masks"] = 4
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