--todo clean versions
ITEM.name = "Bloodsucker Goulash w/ Water"
ITEM.desc = "A small prepared meal made out of bloodsucker meat with spices and other ingredients. Added water decreases detrimental effects of mutant meat, but still would not recommend eating."
ITEM.price = 1922
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_meat_bloodsucker.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.17
ITEM.hungerAmt = 60
ITEM.radGive = 15
ITEM.radGiveTime = 7

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
