ITEM.name = "Stale bread loaf"
ITEM.desc = "A stale loaf of bread from Russia."
ITEM.price = 500
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_bred.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.19
ITEM.hungerAmt = 9
ITEM.thirstAmt = -2

ITEM.useSound = "interface/inv_eat_paperwrap.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
