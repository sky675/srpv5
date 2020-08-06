ITEM.name = "Field Outfit Repair Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs all of a suit.
Requires armor repair.
It can only be used above 40 percent durability.
It will repair it by 35 percent durability.]]
ITEM.model = "models/items/repairpacks/armor_repair_pro.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 3
ITEM.price = 15000
ITEM.flag = "m"

ITEM.minDurability = 40
ITEM.baseRepair = 35
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repaira", val = 1}