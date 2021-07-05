ITEM.name = "Heavy Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires armor repair.
It can only be used above 65 percent durability.
It will repair it by 20 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_sewing_kit_h.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.586
ITEM.price = 13420
ITEM.flag = "m"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(71.227592468262, 59.748641967773, 43.49048614502),
	ang = Angle(25, 220, 0),
	entAng = Angle(18.377687454224, 72.700469970703, 9.0886669158936),
	fov = 4.6923908306325,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 65
ITEM.baseRepair = 20
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repaira", val = 1}