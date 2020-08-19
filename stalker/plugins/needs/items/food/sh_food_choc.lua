ITEM.name = "Chocolate Bar"
ITEM.desc = "temp"
ITEM.price = 600
ITEM.model = "models/kek1ch/dev_chocolate.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.19
ITEM.hungerAmt = 13
ITEM.thirstAmt = -2

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
