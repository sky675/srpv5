ITEM.name = "Universal Weapon Cleaning Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on all weapons.
Requires basic repair level 2.
It can only be used on weapons above 60 percent durability.
It will repair the weapon by 20 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_cleaning_kit_u.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.8
ITEM.price = 11139
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(204.65017700195, 171.98754882813, 124.9169921875),
	ang = Angle(25, 220, 0),
	entAng = Angle(-3.1173117160797, -41.176486968994, -32.534511566162),
	fov = 3.3584447999441,
}
ITEM.useSound = "interface/inv_repair_brushes.ogg"

ITEM.minDurability = 60
ITEM.baseRepair = 20
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}
ITEM.duraInc = 0.94