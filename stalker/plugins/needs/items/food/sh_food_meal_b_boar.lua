ITEM.name = "Prepared Boar Chops w/ Water"
ITEM.desc = "A small portion of grilled and seasoned boar meat. Added water decreases detrimental effects of mutant meat, but still would not recommend eating."
ITEM.price = 1734
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_meat_boar.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.19
ITEM.hungerAmt = 58
ITEM.radGive = 15
ITEM.radGiveTime = 7

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
