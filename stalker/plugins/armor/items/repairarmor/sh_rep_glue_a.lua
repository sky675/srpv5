ITEM.name = "Advanced Glue"
ITEM.desc = [[Drag onto damaged suit to repair it.
Requires basic repair level 1.
It can only be used above 70 percent durability.
It will repair it by 25 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_glue_a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.167
ITEM.price = 2468
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(57.027606964111, 49.450592041016, 37.191619873047),
	ang = Angle(25, 220, 0),
	entAng = Angle(-22.930431365967, 10.221611976624, -25.554883956909),
	fov = 4.2263585472408,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 0.7
ITEM.baseRepair = 0.2
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 1}