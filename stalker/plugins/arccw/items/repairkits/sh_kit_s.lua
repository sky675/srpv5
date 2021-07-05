ITEM.name = "Shotgun Repair Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on shotguns.
Requires weapons repair level 1.
It can only be used on weapons above 25 percent durability.
It will repair the weapon by 40 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_toolkit_s.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 2.2
ITEM.price = 20420
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(164.61325073242, 138.17222595215, 68.875579833984),
	ang = Angle(17.270301818848, 220, 0),
	entAng = Angle(4.9325723648071, 16.459260940552, 0.38565218448639),
	fov = 5.0066941391729,
}
ITEM.useSound = "interface/inv_repair_kit.ogg"

ITEM.minDurability = 25
ITEM.baseRepair = 40
ITEM.fixBroken = false
ITEM.repairType = {["shotgun"] = true,}
ITEM.traitreq = {trait = "crafting_repairw", val = 1}
ITEM.duraInc = 0.9