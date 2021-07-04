ITEM.name = "Data Reader"
ITEM.desc = "An old scientific instrument for reading some kind of data. Can be disassembled for tech parts."
ITEM.model = "models/spec45as/stalker/items/datchik2.mdl"
ITEM.category = "Junk"
ITEM.weight = 0.1
ITEM.price = 1100
ITEM.flag = "m"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(113.20232391357, 94.507278442383, 68.949363708496),
	ang = Angle(24.992626190186, -140, 0),
	entAng = Angle(23.628705978394, 3.48384141922, -13.81507396698),
	fov = 3.3879610946996,
}

ITEM.permit = "elec"
ITEM.isStackable = false
ITEM.destroyval = {
	["comp_tech1"] = 2,
	["comp_wire1"] = 1,
}