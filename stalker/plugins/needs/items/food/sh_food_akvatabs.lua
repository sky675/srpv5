ITEM.name = "Akvatabs"
ITEM.desc = "A bottle of pills meant for disinfecting water."
ITEM.price = 2760
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_item_akvatab.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.002
ITEM.hungerAmt = 15
ITEM.thirstAmt = -5
ITEM.radGive = -30
ITEM.radGiveTime = 10
ITEM.uses = 3

ITEM.useSound = "player/items/pain_pills/pills_deploy_2.wav"

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
