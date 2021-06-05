ITEM.name = "Raisins Bag"
ITEM.desc = "Small pack of raisins."
ITEM.price = 520
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_raisins.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.05
ITEM.hungerAmt = 15
ITEM.thirstAmt = -5

ITEM.useSound = "interface/inv_eat_paperwrap.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
