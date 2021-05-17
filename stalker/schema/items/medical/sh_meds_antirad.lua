ITEM.name = "Anti-Rad"
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_antibio_chlor_old.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.05
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.46412658691, 154.84878540039, 112.38569641113),
	ang = Angle(25, 220, 0),
	entAng = Angle(36.626045227051, -1.1396334171295, -22.274087905884),
	fov = 1.214615594208,
}

ITEM.useTime = 0.7
ITEM.price = 1860
ITEM.desc = "Common anti-radiation drugs."
ITEM.flag = "0"
ITEM.hungerAmt = -10
ITEM.thirstAmt = -5
ITEM.radGive = -35
ITEM.radGiveTime = 10


local function onUse(item)
    --new sound needed
    item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
    item.player:TakeDamage(2)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)