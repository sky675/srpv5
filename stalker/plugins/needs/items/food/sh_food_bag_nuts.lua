ITEM.name = "Mixed Nuts Bag"
ITEM.desc = "Assorted kinds of nuts. High nutrition value."
ITEM.price = 1283
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_nuts.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.11
ITEM.hungerAmt = 30
ITEM.thirstAmt = -12

ITEM.useSound = "interface/inv_eat_paperwrap.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
