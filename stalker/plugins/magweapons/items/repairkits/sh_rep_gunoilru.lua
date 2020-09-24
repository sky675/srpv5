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
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(97.889465332031, 82.138999938965, 63.832237243652),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0, 0),
	fov = 4.0174140001047,
}
ITEM.useSound = "interface/inv_repair_spray_oil.ogg"

ITEM.minDurability = 85
ITEM.baseRepair = 5
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}