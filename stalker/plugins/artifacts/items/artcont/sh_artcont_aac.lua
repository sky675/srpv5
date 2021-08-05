ITEM.name = "Artifact Application Container"
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_aac.mdl"
ITEM.desc = "A container that filters out a moderate amount of radiation from artifacts so its effects can be safely utilized. It negates up to 4 rads per min."
--ITEM.category = "Miscellaneous"
ITEM.flag = "E"
ITEM.price = 19410
ITEM.weight = 2.73
ITEM.width = 1
ITEM.height = 1
ITEM.isSafe = false
ITEM.contSlots = 1
ITEM.radRemove = 4
--for stuff like improved containers: radRemove removes that amount of rad given 
--by each art in the item (will not heal radiation, just reduce it to 0)
--aac 4
--aam 6
ITEM.equipSound = "interface/inv_aac_close.ogg"
ITEM.unequipSound = "interface/inv_aac_open.ogg"