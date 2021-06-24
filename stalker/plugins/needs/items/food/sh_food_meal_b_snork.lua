ITEM.name = "Grilled Snork Hand w/ Water"
ITEM.desc = "A grilled hand from a snork. Eating would be technically cannibalism. Added water decreases detrimental effects of mutant meat, but still would not recommend eating."
ITEM.price = 1366
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_snork_food.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.06
ITEM.hungerAmt = 18
ITEM.radGive = 6
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
