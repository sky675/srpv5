ITEM.name = "Basic Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires basic repair level 1.
It can only be used above 85 percent durability.
It will repair it by 12 percent durability.]]
ITEM.model = "models/items/repairpacks/sewing_kit_b.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.288
ITEM.price = 4360
ITEM.flag = "U"

ITEM.minDurability = 85
ITEM.baseRepair = 12
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 1}