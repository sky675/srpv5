ITEM.name = "Scientific Stimpack"
ITEM.model = "models/kek1ch/stim3.mdl"--stalker/item/medical/medkit1.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.healAmount = 50
ITEM.healSeconds = 15
ITEM.radGive = -30
ITEM.radGiveTime = 15
ITEM.hungerAmt = -9
ITEM.thirstAmt = -4
ITEM.useTime = 0.75
--ITEM.bleedStop = 1
ITEM.price = 6000
ITEM.desc = "A state-of-the-art stimpack. Heals 50 in 15 seconds and reduces radiation."
ITEM.flag = "E"
ITEM.permit = "med"

local function onUse(item)
	item.player:EmitSound("interface/inv_stim_3p2.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)