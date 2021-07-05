ITEM.name = "GPS"
ITEM.desc = "A non-functional GPS. Can be disassembled for tech parts."
ITEM.model = "models/spec45as/stalker/items/datchik3.mdl"
ITEM.category = "Junk"
ITEM.weight = 0.1
ITEM.price = 1450
ITEM.flag = "m"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(112.64691925049, 94.579803466797, 68.949363708496),
	ang = Angle(24.992626190186, -140, 0),
	entAng = Angle(23.628705978394, 3.48384141922, -13.81507396698),
	fov = 3.8327993602864,
}

ITEM.permit = "elec"
ITEM.isStackable = false
ITEM.destroyval = {
	["comp_tech1"] = 2,
	["comp_wire1"] = 2,
}