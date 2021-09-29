ITEM.name = "Grilled Snork Hand w/ Vodka"
ITEM.desc = "A grilled hand from a snork. Eating would be technically cannibalism. Added vodka removes detrimental effects of mutant meat."
ITEM.price = 1366
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_snork_food.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.06
ITEM.hungerAmt = 36
ITEM.radGive = -3
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
