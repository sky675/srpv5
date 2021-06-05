ITEM.name = "Water Bottle" --what are bottles that come like this commercially called?"
ITEM.desc = "A commercial water bottle."
ITEM.price = 1200
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_mineral_water.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.75
ITEM.radGive = -4
ITEM.radGiveTime = 10
ITEM.hungerAmt = 0
ITEM.thirstAmt = 30
ITEM.uses = 3

ITEM.useSound = "interface/inv_drink_flask.ogg"

ITEM.regenStam = {
	--amount, seconds
	15, 30
}

local function onUse(item)
	--item.player:restoreStamina(15)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
