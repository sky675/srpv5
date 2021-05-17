ITEM.name = "Pistol Repair Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on 9x19, .45 ACP, and .50 AE caliber weapons.
Requires weapons repair level 1.
It can only be used on weapons above 25 percent durability.
It will repair the weapon by 40 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_toolkit_p.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 2.5
ITEM.price = 15660
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(204.65017700195, 171.98754882813, 125.76376342773),
	ang = Angle(25, 220, 0),
	entAng = Angle(-4.2422332763672, -34.203453063965, -29.306127548218),
	fov = 4.5640734434771,
}
ITEM.useSound = "interface/inv_repair_kit.ogg"

ITEM.minDurability = 25
ITEM.baseRepair = 40
ITEM.fixBroken = false
ITEM.repairType = {["pistol"] = true,}
ITEM.traitreq = {trait = "crafting_repairw", val = 1}
ITEM.duraInc = 0.9