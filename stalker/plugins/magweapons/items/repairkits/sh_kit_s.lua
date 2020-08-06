ITEM.name = "Shotgun Repair Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on shotguns.
Requires weapons repair level 1.
It can only be used on weapons above 25 percent durability.
It will repair the weapon by 40 percent durability.]]
ITEM.model = "models/items/repairpacks/toolkit_s.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 2.2
ITEM.price = 20420
ITEM.flag = "U"

ITEM.minDurability = 25
ITEM.baseRepair = 40
ITEM.fixBroken = false
ITEM.repairType = {["shotgun"] = true,}
ITEM.traitreq = {trait = "crafting_repairw", val = 1}
ITEM.duraInc = 0.9