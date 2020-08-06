ITEM.name = "Medium and Large Rifle Cleaning Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on 7.62, .338, and 9x39 caliber weapons.
Requires basic repair level 2.
It can only be used on weapons above 70 percent durability.
It will repair the weapon by 15 percent durability.]]
ITEM.model = "models/items/repairpacks/cleaning_kit_r7.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.3
ITEM.price = 4104
ITEM.flag = "U"

ITEM.minDurability = 70
ITEM.baseRepair = 15
ITEM.fixBroken = false
ITEM.repairType = {["ws"]=true,}
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}
ITEM.duraInc = 0.94