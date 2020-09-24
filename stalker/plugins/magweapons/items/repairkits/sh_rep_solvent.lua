ITEM.name = "Gun Cleaning Solvent"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on any gun.
Doesn't require any trait level to use.
It can only be used on weapons above 82 percent durability.
It will repair the weapon by 8 percent durability.]]
ITEM.model = "models/items/repairpacks/solvent.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.3
ITEM.price = 1754
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(97.889465332031, 82.138999938965, 62.225917816162),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0, 0),
	fov = 2.7469389957807,
}
ITEM.useSound = "interface/inv_repair_spray_oil.ogg"

ITEM.minDurability = 82
ITEM.baseRepair = 8
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}