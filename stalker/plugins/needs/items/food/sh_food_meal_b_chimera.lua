ITEM.name = "The Masculine Meal w/ Water"--Grilled Chimera"
ITEM.desc = "A portion of grilled chimera meat, with mushrooms and spices. Added water decreases detrimental effects of mutant meat, but still would not recommend eating."
ITEM.price = 3103
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_chimera_food.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.25
ITEM.hungerAmt = 95
ITEM.radGive = 17
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
