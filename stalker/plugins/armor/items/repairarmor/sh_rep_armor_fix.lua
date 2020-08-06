ITEM.name = "Heavy Duty Armor Repair Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit repairs the body of a suit.
Requires armor repair.
It can only be used below 41 percent durability.
It will repair it by 41 percent durability.]]
ITEM.model = "models/items/repairpacks/instrument.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 5
ITEM.price = 19360
ITEM.flag = "m"

ITEM.minDurability = -1
ITEM.maxDurability = 41
ITEM.baseRepair = 41
ITEM.partToRepair = "all" --suit, head
ITEM.traitreq = {trait = "crafting_repaira", val = 1}