ITEM.name = "Bottle of Homemade Tea"
ITEM.desc = "A bottle of warm tea."
ITEM.price = 900
ITEM.model = "models/items/tea_bottle.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.85--1.03 0.37
ITEM.hungerAmt = 0
ITEM.thirstAmt = 25

ITEM.useSound = "interface/inv_drink_flask.ogg"

ITEM.regenStam = {
	--amount, seconds
	20, 30
}

local function onUse(item)
--	item.player:restoreStamina(20)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
