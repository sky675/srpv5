ITEM.name = "The Masculine Meal"--Grilled Chimera"
ITEM.desc = "A portion of grilled chimera meat, with mushrooms and spices. Would not recommend eating."
ITEM.price = 2203
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_chimera_food.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.25
ITEM.hungerAmt = 80
ITEM.radGive = 30
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
