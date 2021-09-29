ITEM.name = "Milk Jug"
ITEM.desc = "A gallon of milk."
ITEM.price = 900
ITEM.model = "models/props_junk/garbage_milkcarton001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 8.6
ITEM.hungerAmt = 0
ITEM.thirstAmt = 35
ITEM.radGive = 20
ITEM.radGiveTime = 10

ITEM.useSound = "interface/inv_drink_flask.ogg"

local function onUse(item)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
