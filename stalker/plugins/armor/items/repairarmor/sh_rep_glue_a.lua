ITEM.name = "Advanced Glue"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs all of a suit.
Requires basic repair level 1.
It can only be used above 70 percent durability.
It will repair it by 10 percent durability.]]
ITEM.model = "models/items/repairpacks/glue_a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.167
ITEM.price = 2468
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(72.270065307617, 60.64176940918, 47.239334106445),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, -38.588069915771, 0),
	fov = 4.2775859523032,
}

ITEM.minDurability = 80
ITEM.baseRepair = 10
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 1}