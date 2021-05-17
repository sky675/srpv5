ITEM.name = "Antiseptic Bandage"
ITEM.model = "models/wick/wrbstalker/cop/newmodels/items/wick_bandage.mdl"--stalker/item/medical/bandage.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.06
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.46412658691, 155.33419799805, 111.9109954834),
	ang = Angle(25, 220, 0),
	entAng = Angle(-32.146266937256, -82.531181335449, -35.254489898682),
	fov = 2.045895475431,
}

ITEM.healAmount = 25
ITEM.healSeconds = 20
ITEM.bleedStop = 9
ITEM.price = 5200
ITEM.desc = "A higher quality roll of bandages. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds. Also applies "..ITEM.bleedStop.." bleed reduction."
ITEM.flag = "6"
ITEM.noBusiness = true --crafting only

local function onUse(item)
	item.player:EmitSound("interface/inv_bandage.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)