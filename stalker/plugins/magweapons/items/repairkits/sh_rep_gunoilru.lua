ITEM.name = "Gun Oil"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on any gun.
Doesn't require any trait level to use.
It can only be used on weapons above 85 percent durability.
It will repair the weapon by 5 percent durability.]]
ITEM.model = "models/items/repairpacks/gun_oil_ru.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.price = 1300
ITEM.flag = "U"

ITEM.minDurability = 85
ITEM.baseRepair = 5
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}