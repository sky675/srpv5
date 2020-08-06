ITEM.name = "Universal Gun Spray Lubricant"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on any gun.
Doesn't require any trait level to use.
It can only be used on weapons above 80 percent durability.
It will repair the weapon by 8 percent durability.]]
ITEM.model = "models/items/repairpacks/gun_oil.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.price = 1830
ITEM.flag = "U"

ITEM.minDurability = 80
ITEM.baseRepair = 8
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}