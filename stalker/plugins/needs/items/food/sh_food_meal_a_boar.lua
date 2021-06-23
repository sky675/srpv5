ITEM.name = "Prepared Boar Chops w/ Vodka"
ITEM.desc = "A small portion of grilled and seasoned boar meat. Added vodka removes detrimental effects of mutant meat."
ITEM.price = 3534
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_meat_boar.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.19
ITEM.hungerAmt = 29
ITEM.radGive = -6
ITEM.radGiveTime = 7
ITEM.alcrem = 1
ITEM.regenStam = {
	--amount, seconds
	25, 60
}

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
