ITEM.name = "Small Glucose Shot"
ITEM.desc = "A shot of glucose."
ITEM.price = 2760
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_glucose_s.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.013
ITEM.hungerAmt = 18
ITEM.thirstAmt = -5
ITEM.healthPerc = 0.04

ITEM.useSound = "interface/inv_stim_3p2.ogg"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
