ITEM.name = "Chocolate Bar"
ITEM.desc = "A bar of russian chocolate."
ITEM.price = 1200
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_chocolate.mdl"--"models/warz/consumables/bar_chocolate.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.12
ITEM.hungerAmt = 9
ITEM.thirstAmt = 0

ITEM.useSound = "interface/inv_eat_paperwrap.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
