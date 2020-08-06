ITEM.name = "Prepared Boar Chops"
ITEM.desc = "A small portion of grilled and seasoned boar meat. Would not recommend eating."
ITEM.price = 1034
ITEM.model = "models/kek1ch/meat_boar.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.19
ITEM.hungerAmt = 29
ITEM.radGive = 29
ITEM.radGiveTime = 7

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
