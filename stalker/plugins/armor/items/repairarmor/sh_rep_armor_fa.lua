ITEM.name = "Emergency Outfit Repair Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs all of a suit.
Requires basic repair level 2.
It can only be used above 85 percent durability.
It will repair it by 12 percent durability.]]
ITEM.model = "models/kek1ch/armor_repair_fa.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.346
ITEM.price = 1872
ITEM.flag = "U"

ITEM.minDurability = 85
ITEM.baseRepair = 12
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}