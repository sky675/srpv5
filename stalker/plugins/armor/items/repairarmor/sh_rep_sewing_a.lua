ITEM.name = "Advanced Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires basic repair level 2.
It can only be used above 75 percent durability.
It will repair it by 14 percent durability.]]
ITEM.model = "models/items/repairpacks/sewing_kit_a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.437
ITEM.price = 8660
ITEM.flag = "m"

ITEM.minDurability = 75
ITEM.baseRepair = 14
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2