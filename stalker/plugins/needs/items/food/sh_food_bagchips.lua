ITEM.name = "Bag of Chips"
ITEM.desc = "A bag of chips."
ITEM.price = 680
ITEM.model = "models/warz/consumables/bag_chips.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.5
ITEM.hungerAmt = 15
ITEM.thirstAmt = 0

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
