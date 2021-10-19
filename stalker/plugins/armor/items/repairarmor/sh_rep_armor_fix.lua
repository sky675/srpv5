ITEM.name = "Heavy Duty Armor Repair Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
Requires an armor workbench.
Requires armor repair.
It can be used at any point.
It will repair it by 80 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_instrument_1.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.weight = 5
ITEM.price = 27360
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(180.70408630371, 151.62870788574, 114.16149902344),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0, 0),
	fov = 4.6940760293172,
}
ITEM.useSound = "interface/inv_repair_kit_use_fast.ogg"

ITEM.reqwb = true
ITEM.minDurability = -1
ITEM.baseRepair = 0.8
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}