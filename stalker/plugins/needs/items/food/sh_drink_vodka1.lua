ITEM.name = "Cossack's Vodka"
ITEM.desc = "An imported glass of vodka."
ITEM.price = 946
ITEM.model = "models/kali/miscstuff/stalker/food/cossacks vodka.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.45
ITEM.uses = 3
ITEM.radGive = -8
ITEM.radGiveTime = 10
ITEM.hungerAmt = 2
ITEM.thirstAmt = 9
ITEM.alcrem = 3

ITEM.useSound = "interface/inv_drink_flask.ogg"

local function onUse(item)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
