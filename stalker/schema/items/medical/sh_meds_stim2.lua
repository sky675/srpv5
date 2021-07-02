ITEM.name = "Army Stimpack"
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_stim2.mdl"--stalker/item/medical/medkit1.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(98.327667236328, 82.409118652344, 59.549179077148),
	ang = Angle(25, 220, 0),
	entAng = Angle(-16.444862365723, -92.06111907959, -19.979295730591),
	fov = 3.5632159819995,
}

ITEM.healAmount = 50
ITEM.healSeconds = 15
ITEM.hungerAmt = -14
ITEM.thirstAmt = -4
ITEM.useTime = 0.75
--ITEM.bleedStop = 1
ITEM.price = 5000
ITEM.desc = "A standard-issue soldier equipment. Heals 50 in 15 seconds."
ITEM.flag = "u"
ITEM.permit = "med"

local function onUse(item)
	item.player:EmitSound("interface/inv_stim_3p2.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)