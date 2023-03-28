ITEM.name = "Flesh Meat"
ITEM.desc = "A popular zone meat. Would not recommend eating."
ITEM.price = 504
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_raw_flesh.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.16
ITEM.hungerAmt = 24
ITEM.radGive = 39
ITEM.radGiveTime = 8

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
