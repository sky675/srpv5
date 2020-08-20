ITEM.name = "Basic Medkit"
ITEM.model = "models/sky/items/medkit1.mdl"--stalker/item/medical/medkit1.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.25
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.46412658691, 154.82537841797, 113.36277008057),
	ang = Angle(25, 220, 0),
	entAng = Angle(10.982773780823, -5.8737111091614, -4.1379284858704),
	fov = 2.5245093576938,
}

ITEM.uses = 2
ITEM.useTime = 3
ITEM.healAmount = 35
ITEM.healSeconds = 30
ITEM.radGive = -20
ITEM.radGiveTime = 30
ITEM.healLeg = true
--ITEM.bleedStop = 1
ITEM.price = 2500
ITEM.desc = "All-purpose medkit. Created with the shell of a AI-2. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds and removes radiation."
ITEM.flag = "0"
ITEM.permit = "med"

local function onUse(item)
	item.player:EmitSound("interface/inv_medkit_short.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)