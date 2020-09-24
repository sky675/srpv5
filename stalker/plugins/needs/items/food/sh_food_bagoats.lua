ITEM.name = "Bag of Oats"
ITEM.desc = "A bag of oats."
ITEM.price = 620
ITEM.model = "models/warz/consumables/bag_oat.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.6
ITEM.hungerAmt = 15
ITEM.thirstAmt = 0

ITEM.useSound = "interface/inv_eat_paperwrap.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
