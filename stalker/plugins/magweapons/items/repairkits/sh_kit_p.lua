ITEM.name = "Pistol Repair Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on 9x19, .45 ACP, and .50 AE caliber weapons.
Requires weapons repair level 1.
It can only be used on weapons above 25 percent durability.
It will repair the weapon by 40 percent durability.]]
ITEM.model = "models/items/repairpacks/toolkit_p.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 2.5
ITEM.price = 15660
ITEM.flag = "U"

ITEM.minDurability = 25
ITEM.baseRepair = 40
ITEM.fixBroken = false
ITEM.repairType = {["pistol"] = true,}
ITEM.traitreq = {trait = "crafting_repairw", val = 1}
ITEM.duraInc = 0.9