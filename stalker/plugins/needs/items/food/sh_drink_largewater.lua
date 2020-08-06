ITEM.name = "Large Water Bottle"
ITEM.desc = "A large water bottle."
ITEM.price = 1600
ITEM.model = "models/warz/consumables/water_l.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 2.2
ITEM.hungerAmt = 0
ITEM.thirstAmt = 60

ITEM.regenStam = {
	--amount, seconds
	20, 60
}

local function onUse(item)
	--item.player:restoreStamina(20)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
