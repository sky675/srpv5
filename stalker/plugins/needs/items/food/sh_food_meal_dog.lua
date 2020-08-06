ITEM.name = "Dog Chops"
ITEM.desc = "A small meal of grilled dog meat mixed with various ingredients. Would not recommend eating."
ITEM.price = 644
ITEM.model = "models/kek1ch/meat_dog.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.14
ITEM.hungerAmt = 15
ITEM.radGive = 15
ITEM.radGiveTime = 5

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
