ITEM.name = "Improvised Stimpack"
ITEM.model = "models/kek1ch/stim1.mdl"--stalker/item/medical/medkit1.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.healAmount = 35
ITEM.healSeconds = 10
ITEM.hungerAmt = -9
ITEM.thirstAmt = -4
ITEM.useTime = 0.75
--ITEM.bleedStop = 1
ITEM.price = 3000
ITEM.desc = "An inexpensive common stimpack. Has many side effects. Heals 35 in 10 seconds."
ITEM.flag = "0"
ITEM.permit = "med"

local function onUse(item)
	item.player:EmitSound("interface/inv_stim_3p2.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)