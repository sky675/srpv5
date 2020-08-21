ITEM.name = "Painkillers"
ITEM.model = "models/warz/consumables/painkillers.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.46412658691, 154.32897949219, 111.84635925293),
	ang = Angle(25, 220, 0),
	entAng = Angle(-41.595664978027, -31.060558319092, -9.2851839065552),
	fov = 0.97207285757747,
}

ITEM.uses = 4
ITEM.weight = 0.01
ITEM.healAmount = 40
ITEM.healSeconds = 100
ITEM.price = 3800
ITEM.desc = "A bottle of painkillers. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds."
ITEM.flag = "6"

local function onUse(item)
	item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)