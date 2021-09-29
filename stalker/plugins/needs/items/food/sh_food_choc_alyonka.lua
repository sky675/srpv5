ITEM.name = "Alyonka"
ITEM.desc = "A russian chocolate bar."
ITEM.price = 600
ITEM.model = "models/illusion/eftcontainers/alyonka.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.19
ITEM.hungerAmt = 26
ITEM.thirstAmt = -4

ITEM.useSound = "interface/inv_eat_paperwrap.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
