--todo clean versions
ITEM.name = "Bloodsucker Goulash"
ITEM.desc = "A small prepared meal made out of bloodsucker meat with spices and other ingredients. Would not recommend eating."
ITEM.price = 1422
ITEM.model = "models/kek1ch/meat_bloodsucker.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.17
ITEM.hungerAmt = 30
ITEM.radGive = 25
ITEM.radGiveTime = 7

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
