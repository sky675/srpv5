ITEM.name = "Medium and Large Rifle Cleaning Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on 7.62, .338, and 9x39 caliber weapons.
Requires basic repair level 2.
It can only be used on weapons above 70 percent durability.
It will repair the weapon by 15 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_cleaning_kit_r7s.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.3
ITEM.price = 4104
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(96.304977416992, 80.663162231445, 58.331302642822),
	ang = Angle(25, 220, 0),
	entAng = Angle(54.487522125244, 51.90559387207, 0),
	fov = 4.6041574006771,
}
ITEM.useSound = "interface/inv_repair_brushes.ogg"

ITEM.minDurability = 70
ITEM.baseRepair = 15
ITEM.fixBroken = false
ITEM.repairType = {["ws"]=true,}
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}
ITEM.duraInc = 0.94