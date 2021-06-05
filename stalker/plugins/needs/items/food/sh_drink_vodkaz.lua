ITEM.name = "Metal Bottle"
ITEM.desc = "Contains what appears to be Zone-produced vodka."
ITEM.price = 1264
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_drink_water.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.31
ITEM.uses = 3
ITEM.radGive = -7
ITEM.radGiveTime = 10
ITEM.hungerAmt = 4
ITEM.thirstAmt = 7
ITEM.alcrem = 3

ITEM.useSound = "interface/inv_drink_flask.ogg"

local function onUse(item)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
