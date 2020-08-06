ITEM.name = "Gun Oil And Cleaning Solvent"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on any gun.
Requires basic repair level 1 to use.
It can only be used on weapons above 85 percent durability.
It will repair the weapon by 10 percent durability.]]
ITEM.model = "models/items/repairpacks/gun_oil_ru_d.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.08
ITEM.price = 1675
ITEM.flag = "U"

ITEM.minDurability = 85
ITEM.baseRepair = 10
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
ITEM.traitreq = {trait = "crafting_repair", val = 1}