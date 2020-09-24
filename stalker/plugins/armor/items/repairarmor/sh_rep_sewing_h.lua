ITEM.name = "Heavy Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires armor repair.
It can only be used above 65 percent durability.
It will repair it by 20 percent durability.]]
ITEM.model = "models/items/repairpacks/sewing_kit_h.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.586
ITEM.price = 13420
ITEM.flag = "m"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(81.18147277832, 68.162734985352, 49.130565643311),
	ang = Angle(25, 220, 0),
	entAng = Angle(72.425811767578, 26.893789291382, -2.6663281917572),
	fov = 4.934352531675,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 65
ITEM.baseRepair = 20
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repaira", val = 1}