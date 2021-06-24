ITEM.name = "Pseudodog Chops w/ Water"
ITEM.desc = "A small meal of grilled dog meat mixed with various ingredients. Added water decreases detrimental effects of mutant meat, but still would not recommend eating."
ITEM.price = 1202
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_meat_pseudodog.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.09
ITEM.hungerAmt = 22
ITEM.radGive = 8
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
