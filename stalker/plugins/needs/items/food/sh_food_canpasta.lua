ITEM.name = "Can of Pasta"
ITEM.desc = "A can of spaghetti."
ITEM.price = 700
ITEM.model = "models/warz/consumables/can_pasta.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.05
ITEM.hungerAmt = 25
ITEM.thirstAmt = 0

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
