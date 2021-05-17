ITEM.name = "Smallbore Rifle Repair Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on 5.45 and 5.56 caliber weapons.
Requires weapons repair trait.
It can only be used on weapons above 25 percent durability.
It will repair the weapon by 40 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_toolkit_nato.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 2
ITEM.price = 20420
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(204.65017700195, 172.36546325684, 127.97688293457),
	ang = Angle(25, 220, 0),
	entAng = Angle(-3.8283953666687, -32.74779510498, 3.7216703891754),
	fov = 4.7822222222222,
}
ITEM.useSound = "interface/inv_repair_kit.ogg"

ITEM.minDurability = 25
ITEM.baseRepair = 40
ITEM.fixBroken = false
ITEM.repairType = {["n"]=true,}
ITEM.traitreq = {trait = "crafting_repairw", val = 1}
ITEM.duraInc = 0.9