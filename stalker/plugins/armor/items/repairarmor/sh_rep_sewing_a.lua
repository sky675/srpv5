ITEM.name = "Advanced Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires basic repair level 2.
It can only be used above 75 percent durability.
It will repair it by 14 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_sewing_kit_a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.437
ITEM.price = 8660
ITEM.flag = "m"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(71.227592468262, 59.833045959473, 43.228233337402),
	ang = Angle(25, 220, 0),
	entAng = Angle(52.985145568848, 48.422061920166, -1.301815032959),
	fov = 4.2738840131467,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 75
ITEM.baseRepair = 14
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2