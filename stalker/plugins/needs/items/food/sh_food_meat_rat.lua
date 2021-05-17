ITEM.name = "Rat Meat"
ITEM.desc = "A portion of a rodent. Would not recommend eating."
ITEM.price = 166
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_raw_tushkano.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.04
ITEM.hungerAmt = 9
ITEM.radGive = 13
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
