ITEM.name = "Granola Bar"
ITEM.desc = "A granola bar."
ITEM.price = 550
ITEM.model = "models/warz/consumables/bar_granola.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.22
ITEM.hungerAmt = 10
ITEM.thirstAmt = 0

ITEM.useSound = "interface/inv_eat_paperwrap.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
