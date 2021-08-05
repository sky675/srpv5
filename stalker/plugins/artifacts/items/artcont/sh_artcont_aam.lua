ITEM.name = "Artifact Application Module"
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_aam.mdl"
ITEM.desc = "A container that filters out a significant amount of radiation from artifacts so its effects can be safely utilized. It negates up to 6 rads per min."
--ITEM.category = "Miscellaneous"
ITEM.flag = "E"
ITEM.price = 31485
ITEM.weight = 3.06
ITEM.width = 1
ITEM.height = 1
ITEM.isSafe = false
ITEM.contSlots = 1
ITEM.radRemove = 6
--for stuff like improved containers: radRemove removes that amount of rad given 
--by each art in the item (will not heal radiation, just reduce it to 0)
--aac 4
--aam 6
ITEM.equipSound = "interface/inv_aam_close.ogg"
ITEM.unequipSound = "interface/inv_aam_open.ogg"