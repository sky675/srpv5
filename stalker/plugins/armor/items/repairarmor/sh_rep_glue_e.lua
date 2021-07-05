ITEM.name = "Extreme Glue"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs all of a suit.
Requires basic repair level 2.
It can only be used above 50 percent durability.
It will repair it by 16 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_glue_e.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.194
ITEM.price = 3896
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(57.027606964111, 49.508075714111, 36.860408782959),
	ang = Angle(25, 220, 0),
	entAng = Angle(-38.055839538574, 24.899236679077, -26.211006164551),
	fov = 3.6579924078075,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 70
ITEM.baseRepair = 12
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2