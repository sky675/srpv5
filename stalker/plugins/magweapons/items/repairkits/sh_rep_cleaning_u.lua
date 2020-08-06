ITEM.name = "Universal Weapon Cleaning Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on all weapons.
Requires basic repair level 2.
It can only be used on weapons above 60 percent durability.
It will repair the weapon by 20 percent durability.]]
ITEM.model = "models/items/repairpacks/cleaning_kit_u.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.8
ITEM.price = 11139
ITEM.flag = "U"

ITEM.minDurability = 60
ITEM.baseRepair = 20
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}
ITEM.duraInc = 0.94