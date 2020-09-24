ITEM.name = "Coconut Water" --the nectar of the gods!"
ITEM.desc = "A container of coconut water. 'The nectar of the gods!'"
ITEM.price = 2200
ITEM.model = "models/warz/consumables/coconut_water.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.25
ITEM.hungerAmt = 0
ITEM.thirstAmt = 30

ITEM.useSound = "interface/inv_drink_can.ogg"

local function onUse(item)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
