ITEM.name = "Boar Chop"
ITEM.desc = "A very popular meat in the zone. Would not recommend eating."
ITEM.price = 669
ITEM.model = "models/kek1ch/raw_boar.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.19
ITEM.hungerAmt = 27
ITEM.radGive = 38
ITEM.radGiveTime = 8

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
