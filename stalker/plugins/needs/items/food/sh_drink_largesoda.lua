ITEM.name = "Large Soda Bottle"
ITEM.desc = "A 2 liter bottle of soda."
ITEM.price = 1200
ITEM.model = "models/props_junk/garbage_plasticbottle003a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 4.4
ITEM.hungerAmt = 0
ITEM.thirstAmt = 25

ITEM.regenStam = {
	--amount, seconds
	30, 60
}

local function onUse(item)
	--item.player:restoreStamina(30)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
