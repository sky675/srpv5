ITEM.name = "Ukrainian Combat Ration"
ITEM.desc = "Various food items and cooking equipment."
ITEM.price = 7300
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_ration_ukr.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 0.3
ITEM.hungerAmt = 93
ITEM.thirstAmt = -20
ITEM.uses = 6


ITEM.useSound = "interface/inv_eat_ration1.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
