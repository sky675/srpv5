ITEM.name = "Heavy Duty Armor Repair Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs the body of a suit.
Requires armor repair.
It can only be used below 41 percent durability.
It will repair it by 41 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_instrument_1.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.weight = 5
ITEM.price = 19360
ITEM.flag = "m"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(180.70408630371, 151.62870788574, 114.16149902344),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0, 0),
	fov = 4.6940760293172,
}
ITEM.useSound = "interface/inv_repair_kit_use_fast.ogg"

ITEM.minDurability = -1
ITEM.maxDurability = 41
ITEM.baseRepair = 41
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repaira", val = 1}