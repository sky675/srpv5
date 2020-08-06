ITEM.name = "Flesh Bacon"
ITEM.desc = "Slices of fat and greasy bacon made from fleshes. Would not recommend eating."
ITEM.price = 950
ITEM.model = "models/kek1ch/raw_flesh.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.16
ITEM.hungerAmt = 26
ITEM.radGive = 32
ITEM.radGiveTime = 8

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
