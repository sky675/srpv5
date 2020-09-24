ITEM.name = "Grilled Snork Hand"
ITEM.desc = "A grilled hand from a snork. Eating would be technically cannibalism. Would not recommend eating."
ITEM.price = 866
ITEM.model = "models/kek1ch/snork_food.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.06
ITEM.hungerAmt = 10
ITEM.radGive = 12
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
