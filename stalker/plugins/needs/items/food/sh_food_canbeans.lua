ITEM.name = "Baked beans"
ITEM.desc = "A can of baked beans from the West."
ITEM.price = 895
ITEM.model = "models/kek1ch/dev_beans.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.34
ITEM.hungerAmt = 29
ITEM.thirstAmt = -5

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
