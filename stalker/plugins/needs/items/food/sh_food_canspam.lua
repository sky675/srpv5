ITEM.name = "Can of Spam"
ITEM.desc = "A can of Spam."
ITEM.price = 480
ITEM.model = "models/warz/consumables/can_spam.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.75
ITEM.hungerAmt = 20
ITEM.thirstAmt = 0

ITEM.useSound = "interface/inv_eat_can_open.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
