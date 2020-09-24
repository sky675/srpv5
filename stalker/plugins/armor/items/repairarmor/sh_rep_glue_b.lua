ITEM.name = "Basic Glue"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs all of a suit.
Doesn't require a trait to use.
It can only be used above 85 percent durability.
It will repair it by 5 percent durability.]]
ITEM.model = "models/items/repairpacks/glue_b.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.124
ITEM.price = 1308
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(72.270065307617, 60.64176940918, 46.766204833984),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, -38.588069915771, 0),
	fov = 3.6503481827001,
}
ITEM.useSound = "interface/inv_repair_sewing_kit_fast.ogg"

ITEM.minDurability = 90
ITEM.baseRepair = 5
ITEM.partToRepair = "all" --suit, head
--ITEM.traitreq = {trait = "crafting_repair", val = 1}