ITEM.name = "Ukrainian Beer"
ITEM.desc = "A foggy green bottle of alcohol."
ITEM.price = 1349
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_beer.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.71
ITEM.hungerAmt = 4
ITEM.thirstAmt = 10
ITEM.alcrem = 2

ITEM.useSound = "interface/inv_drink_flask.ogg"
--ITEM.playsound = "npc/barnacle/barnacle_gulp1.wav"

local function onUse(item)
	 
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
