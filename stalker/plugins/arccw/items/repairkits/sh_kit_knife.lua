ITEM.name = "Sharpening Stones"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on melee weapons.
Requires basic repair level 1.
It can only be used on weapons above 25 percent durability.
It will repair the weapon by 60 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_sharpening_stones.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.28
ITEM.price = 23080
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(70.851371765137, 59.317394256592, 43.088958740234),
	ang = Angle(25, 220, 0),
	entAng = Angle(43.452472686768, 6.2533888816833, -7.4613456726074),
	fov = 4.713075440527,
}
ITEM.useSound = "interface/inv_repair_kit.ogg"

ITEM.minDurability = 25
ITEM.baseRepair = 60
ITEM.fixBroken = false
ITEM.repairType = {["knife"] = true,}
ITEM.traitreq = {trait = "crafting_repair", val = 1}
ITEM.duraInc = 0.9