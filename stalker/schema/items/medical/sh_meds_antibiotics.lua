ITEM.name = "Potassium Iodide"
ITEM.model = "models/wick/wrbstalker/cop/newmodels/items/wick_vicasol.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.05
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.46412658691, 154.32897949219, 111.84635925293),
	ang = Angle(25, 220, 0),
	entAng = Angle(-41.595664978027, -31.060558319092, -9.2851839065552),
	fov = 0.97207285757747,
}

ITEM.uses = 3
ITEM.useTime = 1.25
ITEM.price = 3080
ITEM.desc = "A bottle of a pharmacological compound, used to cheaply counteract radiation. Can have numerous harmful side effects."
ITEM.flag = "u"
ITEM.hungerAmt = -10
ITEM.thirstAmt = -6
ITEM.radGive = -25
ITEM.radGiveTime = 10


local function onUse(item)
    item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
    item.player:TakeDamage(2)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)