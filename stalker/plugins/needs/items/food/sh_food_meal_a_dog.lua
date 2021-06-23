ITEM.name = "Dog Chops w/ Vodka"
ITEM.desc = "A small meal of grilled dog meat mixed with various ingredients. Added vodka removes detrimental effects of mutant meat."
ITEM.price = 844
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_meat_dog.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.14
ITEM.hungerAmt = 15
ITEM.radGive = -3
ITEM.radGiveTime = 7
ITEM.alcrem = 1
ITEM.regenStam = {
	--amount, seconds
	15, 60
}

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
