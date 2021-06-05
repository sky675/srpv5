ITEM.name = "Stolichnaya Vodka"
ITEM.desc = "An imported and popular bottle of vodka."
ITEM.price = 2663
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_drink_vodka.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.37
ITEM.uses = 3
ITEM.radGive = -11
ITEM.radGiveTime = 10
ITEM.hungerAmt = 3
ITEM.thirstAmt = 8
ITEM.alcrem = 3

ITEM.useSound = "interface/inv_drink_flask.ogg"

local function onUse(item)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
