ITEM.name = "Bloodsucker Meat"
ITEM.desc = "A piece of a bloodsucker. Would not recommend eating."
ITEM.price = 917
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_raw_boar.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.17
ITEM.hungerAmt = 30
ITEM.radGive = 33
ITEM.radGiveTime = 8

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
