ITEM.name = "Pseudodog Meat"
ITEM.desc = "A cheaper alternative to boar meat. Would not recommend eating."
ITEM.price = 529
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_raw_dog.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.16
ITEM.hungerAmt = 15
ITEM.radGive = 20
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
