ITEM.name = "Sausage"
ITEM.desc = "An imported package of sausage."
ITEM.price = 657
ITEM.model = "models/kali/miscstuff/stalker/food/diet sausage.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.11
ITEM.hungerAmt = 17

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
