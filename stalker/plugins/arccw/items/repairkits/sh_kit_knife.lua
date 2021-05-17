ITEM.name = "Sharpening Stones"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on melee weapons.
Requires basic repair level 1.
It can only be used on weapons above 25 percent durability.
It will repair the weapon by 60 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_sharpening_stones.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 2
ITEM.price = 23080
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(204.65017700195, 172.36546325684, 128.6594543457),
	ang = Angle(25, 220, 0),
	entAng = Angle(-3.8283953666687, -32.74779510498, 3.7216703891754),
	fov = 4.7822222222222,
}
ITEM.useSound = "interface/inv_repair_kit.ogg"

ITEM.minDurability = 25
ITEM.baseRepair = 60
ITEM.fixBroken = false
ITEM.repairType = {["knife"] = true,}
ITEM.traitreq = {trait = "crafting_repair", val = 1}
ITEM.duraInc = 0.9