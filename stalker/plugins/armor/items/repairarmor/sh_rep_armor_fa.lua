ITEM.name = "Emergency Outfit Repair Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs all of a suit.
Requires basic repair level 2.
It can only be used above 85 percent durability.
It will repair it by 12 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_armor_repair_fa.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.346
ITEM.price = 1872
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(89.711265563965, 76.908874511719, 55.562099456787),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0, 0),
	fov = 4.3428753948902,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 85
ITEM.baseRepair = 12
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}