ITEM.name = "Purified Water Flask"
ITEM.desc = "A water flask."
ITEM.price = 1000
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_drink_flask.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1
ITEM.radGive = -2
ITEM.radGiveTime = 10
ITEM.hungerAmt = 0
ITEM.thirstAmt = 20
ITEM.uses = 3

ITEM.useSound = "interface/inv_drink_flask.ogg"

ITEM.regenStam = {
	--amount, seconds
	15, 30
}

local function onUse(item)
--	item.player:restoreStamina(15)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
