ITEM.name = "Military Stimpack"
ITEM.model = "models/kek1ch/stim2.mdl"--stalker/item/medical/medkit1.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.healAmount = 50
ITEM.healSeconds = 15
ITEM.hungerAmt = -14
ITEM.thirstAmt = -4
ITEM.useTime = 0.75
--ITEM.bleedStop = 1
ITEM.price = 5000
ITEM.desc = "A standard-issue soldier equipment. Heals 50 in 15 seconds."
ITEM.flag = "6"
ITEM.permit = "med"

local function onUse(item)
	item.player:EmitSound("interface/inv_stim_3p2.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)