ITEM.name = "Heavy Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
Requires basic repair level 2.
It can only be used above 10 percent durability.
It will repair it by 80 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_sewing_kit_h.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.586
ITEM.price = 15420
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(71.227592468262, 59.748641967773, 43.49048614502),
	ang = Angle(25, 220, 0),
	entAng = Angle(18.377687454224, 72.700469970703, 9.0886669158936),
	fov = 4.6923908306325,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 0.1
ITEM.baseRepair = 0.8
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}