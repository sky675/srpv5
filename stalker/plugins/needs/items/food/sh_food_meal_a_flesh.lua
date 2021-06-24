ITEM.name = "Flesh Bacon w/ Vodka"
ITEM.desc = "Slices of fat and greasy bacon made from fleshes. Added vodka removes detrimental effects of mutant meat."
ITEM.price = 3150
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_meat_flesh.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.18
ITEM.hungerAmt = 26
ITEM.radGive = -6
ITEM.radGiveTime = 7

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
