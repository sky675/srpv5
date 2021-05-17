ITEM.name = "Shotgun Cleaning Kit"
ITEM.desc = [[Drag onto damaged weapon to repair it.
This kit can only be used on shotguns.
Requires basic repair level 2.
It can only be used on weapons above 70 percent durability.
It will repair the weapon by 15 percent durability.]]
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_cleaning_kit_s.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.33
ITEM.price = 2954
ITEM.flag = "U"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(204.65017700195, 171.98754882813, 124.9169921875),
	ang = Angle(25, 220, 0),
	entAng = Angle(-52.291625976563, -133.71549987793, -23.419097900391),
	fov = 2.1547533846205,
}
ITEM.useSound = "interface/inv_repair_brushes.ogg"

ITEM.minDurability = 70
ITEM.baseRepair = 15
ITEM.fixBroken = false
ITEM.repairType = {["shotgun"]=true,}
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2
--ITEM.traitreq = {trait = "crafting_repairw", val = 2}
ITEM.duraInc = 0.94