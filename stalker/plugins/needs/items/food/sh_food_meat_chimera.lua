ITEM.name = "Chunk of Chimera Meat"
ITEM.desc = "A heavy chunk of chimera meat. Would not recommend eating."
ITEM.price = 1408
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_meat_chimera.mdl"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.26
ITEM.hungerAmt = 55
ITEM.radGive = 30
ITEM.radGiveTime = 5

ITEM.useSound = "interface/inv_eat_mutant_food.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
