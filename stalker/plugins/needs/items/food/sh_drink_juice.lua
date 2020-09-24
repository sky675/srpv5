ITEM.name = "Juice Box"
ITEM.desc = "A small box of grape juice."
ITEM.price = 800
ITEM.model = "models/warz/consumables/juice.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.44
ITEM.hungerAmt = 0
ITEM.thirstAmt = 12

ITEM.useSound = "interface/inv_drink_can.ogg"

local function onUse(item)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
