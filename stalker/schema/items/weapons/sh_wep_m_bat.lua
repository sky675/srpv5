ITEM.name = "Baseball Bat" --tier 1 melee
ITEM.desc = "A metal baseball bat."
ITEM.price = 1600
ITEM.model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl"
ITEM.width = 1
ITEM.height = 3
ITEM.weight = 0.9
ITEM.flag = "1"
ITEM.category = "Weapons - Melees"
ITEM.class = "sky_m_nmrih_bat"
ITEM.weaponCategory = "melee"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(111.2872543335, 93.47900390625, 73.354957580566),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, -127.68507385254, 0),
	fov = 3.526571361449,
}

ITEM.destroyval = {
	["comp_scrap_metal"] = 4,
}