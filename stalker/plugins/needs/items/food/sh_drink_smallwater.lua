ITEM.name = "Small Water Bottle"
ITEM.desc = "A small water bottle."
ITEM.price = 1200
ITEM.model = "models/warz/consumables/water_s.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1
ITEM.hungerAmt = 0
ITEM.thirstAmt = 30

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
