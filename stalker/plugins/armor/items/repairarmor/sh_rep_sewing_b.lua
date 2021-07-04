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
	pos = Vector(71.227592468262, 59.833045959473, 43.119640350342),
	ang = Angle(25, 220, 0),
	entAng = Angle(48.563144683838, 64.255409240723, 17.233497619629),
	fov = 4.2738840131467,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 85
ITEM.baseRepair = 12
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 1}