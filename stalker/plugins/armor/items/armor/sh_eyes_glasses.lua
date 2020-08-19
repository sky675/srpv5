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
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(70.662010192871, 57.713195800781, 44.37474822998),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0.47858771681786, 0),
	fov = 5.6258075811277,
}

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