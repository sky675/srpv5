ITEM.name = "Pistol Cleaning Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on pistols.
Requires basic repair level 2.
It can only be used on weapons above 70 percent durability.
It will repair the weapon by 15 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_cleaning_kit_p.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.32
ITEM.price = 2654
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(95.850151062012, 80.826019287109, 58.331302642822),
	ang = Angle(25, 220, 0),
	entAng = Angle(41.953712463379, -10.049181938171, -25.725311279297),
	fov = 4.3681559887924,
}
ITEM.useSound = "interface/inv_repair_brushes.ogg"

ITEM.minDurability = 70
ITEM.baseRepair = 15
ITEM.fixBroken = false
ITEM.repairType = {["pistol"]=true,}
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}
ITEM.duraInc = 0.94