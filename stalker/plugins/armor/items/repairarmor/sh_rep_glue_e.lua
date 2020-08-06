ITEM.name = "Extreme Glue"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs all of a suit.
Requires basic repair level 2.
It can only be used above 50 percent durability.
It will repair it by 16 percent durability.]]
ITEM.model = "models/items/repairpacks/glue_e.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.194
ITEM.price = 3896
ITEM.flag = "U"

ITEM.minDurability = 70
ITEM.baseRepair = 12
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2