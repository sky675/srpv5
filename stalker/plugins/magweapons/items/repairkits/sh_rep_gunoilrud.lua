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
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(97.889465332031, 82.138999938965, 60.378582000732),
	ang = Angle(25, 220, 0),
	entAng = Angle(-1.4595099687576, -27.862623214722, -51.32400894165),
	fov = 2.1296318261501,
}
ITEM.useSound = "interface/inv_repair_spray_oil.ogg"

ITEM.minDurability = 85
ITEM.baseRepair = 10
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
ITEM.traitreq = {trait = "crafting_repair", val = 1}