ITEM.name = "Beef Tushonka"
ITEM.desc = "A common canned and stewed meat."
ITEM.price = 576
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_tushonka.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.34
ITEM.hungerAmt = 85
ITEM.thirstAmt = -20

ITEM.useSound = "interface/inv_eat_can_open.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
