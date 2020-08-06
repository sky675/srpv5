ITEM.name = "Can of Soup"
ITEM.desc = "A can of tomato soup."
ITEM.price = 540
ITEM.model = "models/warz/consumables/can_soup.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.7
ITEM.hungerAmt = 21
ITEM.thirstAmt = 5

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
