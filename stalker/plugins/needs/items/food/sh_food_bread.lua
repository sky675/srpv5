ITEM.name = "Bread loaf"
ITEM.desc = "A load of bread from outside the Zone."
ITEM.price = 600
ITEM.model = "models/kali/miscstuff/stalker/food/bread.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.19
ITEM.hungerAmt = 18
ITEM.thirstAmt = -2

ITEM.useSound = "interface/inv_eat_paperwrap.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
