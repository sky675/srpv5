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

ITEM.minDurability = 80
ITEM.baseRepair = 10
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 1}