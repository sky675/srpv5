ITEM.name = "Basic Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires basic repair level 1.
It can only be used above 85 percent durability.
It will repair it by 12 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_sewing_kit_b.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.288
ITEM.price = 4360
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(81.18147277832, 68.162734985352, 49.411827087402),
	ang = Angle(25, 220, 0),
	entAng = Angle(72.425811767578, 30.819278717041, -2.0949611663818),
	fov = 4.3050503581505,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 85
ITEM.baseRepair = 12
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 1}