ITEM.name = "Basic Glue"
ITEM.desc = [[Drag onto damaged suit to repair it.
Doesn't require a trait to use.
It can only be used above 80 percent durability.
It will repair it by 15 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_glue_b.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.124
ITEM.price = 1308
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(57.027606964111, 49.508075714111, 36.860408782959),
	ang = Angle(25, 220, 0),
	entAng = Angle(-38.055839538574, 24.899236679077, -26.211006164551),
	fov = 3.6579924078075,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 0.8
ITEM.baseRepair = 0.15
ITEM.partToRepair = "all" --suit, head
--ITEM.traitreq = {trait = "crafting_repair", val = 1}