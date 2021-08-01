ITEM.name = "Improvised Application Module"
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_iam.mdl"
ITEM.desc = "A container that filters out a small amount of radiation from artifacts so its effects can be safely utilized. It negates up to 2 rads per min."
--ITEM.category = "Miscellaneous"
ITEM.flag = "E"
ITEM.price = 11385
ITEM.weight = 2.4
ITEM.width = 1
ITEM.height = 1
ITEM.isSafe = false
ITEM.contSlots = 1
ITEM.radRemove = 2
--for stuff like improved containers: radRemove removes that amount of rad given 
--by each art in the item (will not heal radiation, just reduce it to 0)
--aac 4
--aam 6
ITEM.equipSound = "interface/inv_iam_close.ogg"
ITEM.unequipSound = "interface/inv_iam_open.ogg"