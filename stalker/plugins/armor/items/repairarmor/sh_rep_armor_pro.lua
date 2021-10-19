ITEM.name = "Field Outfit Repair Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
Requires armor repair.
It can only be used above -10 percent durability.
It will repair it by 70 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_armor_repair_pro.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 3
ITEM.price = 18000
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(182.25831604004, 152.93586730957, 116.01523590088),
	ang = Angle(25, 220, 0),
	entAng = Angle(-5.4023675918579, 14.22802066803, 2.9498870372772),
	fov = 6.2375251253585,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = -0.1
ITEM.baseRepair = 0.7
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}