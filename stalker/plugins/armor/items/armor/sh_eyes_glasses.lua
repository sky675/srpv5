ITEM.name = "Glasses"
ITEM.desc = "A pair of reading glasses."
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

ITEM.bodyGroups = {
    ["glasses"] = 1
}

ITEM.upgradePath = "eyes"

function ITEM:canWear(ply)
	local model = ply:GetModel()
	if(nut.newchar.isBM(model)) then
		return true
	else
		return false, "Your model cannot wear this item!"
	end
end