ITEM.name = "Gun Oil"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on any gun.
Doesn't require any trait level to use.
It can only be used on weapons above 85 percent durability.
It will repair the weapon by 5 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_gun_oil_ru.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.price = 1300
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(78.149833679199, 68.044982910156, 51.067600250244),
	ang = Angle(25, 220, 0),
	entAng = Angle(-32.390926361084, 18.134223937988, -25.945289611816),
	fov = 3.7698091953355,
}
ITEM.useSound = "interface/inv_repair_spray_oil.ogg"

ITEM.minDurability = 85
ITEM.baseRepair = 5
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,["ws"]=true,["pistol"]=true,["shotgun"]=true,}
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}