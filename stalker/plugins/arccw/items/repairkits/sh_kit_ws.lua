ITEM.name = "Medium and Large Rifle Repair Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on 7.62, .338, and 9x39 caliber weapons.
Requires weapons repair level 1.
It can only be used on weapons above 25 percent durability.
It will repair the weapon by 40 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_toolkit_wp.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 2
ITEM.price = 23080
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(164.84902954102, 138.14036560059, 69.755973815918),
	ang = Angle(17.270301818848, 220, 0),
	entAng = Angle(-1.1426960229874, 33.925521850586, 0.38565218448639),
	fov = 5.0066941391729,
}
ITEM.useSound = "interface/inv_repair_kit.ogg"

ITEM.minDurability = 25
ITEM.baseRepair = 40
ITEM.fixBroken = false
ITEM.repairType = {["ws"] = true,}
ITEM.traitreq = {trait = "crafting_repairw", val = 1}
ITEM.duraInc = 0.9