ITEM.name = "Bottle of Whiskey"
ITEM.desc = "A brown bottle of whiskey."
ITEM.price = 900
ITEM.model = "models/props_junk/garbage_glassbottle002a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.5
ITEM.hungerAmt = 0
ITEM.thirstAmt = 10
ITEM.alcrem = 3

ITEM.useSound = "interface/inv_drink_flask.ogg"

local function onUse(item)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
