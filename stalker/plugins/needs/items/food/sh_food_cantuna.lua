ITEM.name = "Can of Tuna"
ITEM.desc = "A can of tuna."
ITEM.price = 590
ITEM.model = "models/kali/miscstuff/stalker/food/tourist's breakfast.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.17
ITEM.hungerAmt = 42
ITEM.thirstAmt = -5

ITEM.useSound = "interface/inv_eat_can_open.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
