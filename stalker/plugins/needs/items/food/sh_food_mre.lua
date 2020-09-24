ITEM.name = "MRE"
ITEM.desc = "A MRE."
ITEM.price = 3200
ITEM.model = "models/warz/consumables/bag_mre.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 0.69
ITEM.hungerAmt = 65
ITEM.thirstAmt = 65

ITEM.useSound = "interface/inv_eat_ration1.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
