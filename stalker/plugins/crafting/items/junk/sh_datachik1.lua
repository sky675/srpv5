ITEM.name = "Data Recorder"
ITEM.desc = "An old scientific instrument for recording some kind of data. Can be disassembled for tech parts."
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_datchik1.mdl"
ITEM.category = "Junk"
ITEM.weight = 0.1
ITEM.price = 900
ITEM.flag = "m"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(112.62933349609, 94.507278442383, 68.949363708496),
	ang = Angle(24.992626190186, -140, 0),
	entAng = Angle(23.628705978394, 3.48384141922, -13.81507396698),
	fov = 4.4326044453384,
}

ITEM.permit = "elec"

ITEM.isStackable = false
ITEM.destroyval = {
	["comp_tech1"] = 2,
	["comp_wire1"] = 1,
}