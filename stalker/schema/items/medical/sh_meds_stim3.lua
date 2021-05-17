ITEM.name = "Scientific Stimpack"
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_stim3.mdl"--stalker/item/medical/medkit1.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(101.9693069458, 86.370506286621, 61.702293395996),
	ang = Angle(25, 220, 0),
	entAng = Angle(-1.9984607696533, -81.233589172363, -31.571329116821),
	fov = 3.6381696588477,
}

ITEM.healAmount = 50
ITEM.healSeconds = 15
ITEM.radGive = -30
ITEM.radGiveTime = 15
ITEM.hungerAmt = -9
ITEM.thirstAmt = -4
ITEM.useTime = 0.75
--ITEM.bleedStop = 1
ITEM.price = 6000
ITEM.desc = "A state-of-the-art stimpack. Heals 50 in 15 seconds and reduces radiation."
ITEM.flag = "E"
ITEM.permit = "med"

local function onUse(item)
	item.player:EmitSound("interface/inv_stim_3p2.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)