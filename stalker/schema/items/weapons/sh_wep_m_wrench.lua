ITEM.name = "Pipe Wrench" --tier 1 melee
ITEM.desc = "A metal red wrench."
ITEM.price = 1100
ITEM.model = "models/weapons/tfa_nmrih/w_me_wrench.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.6
ITEM.flag = "1"
ITEM.category = "Weapons - Melees"
ITEM.class = "sky_m_nmrih_wrench"
ITEM.weaponCategory = "melee"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(111.2872543335, 93.447105407715, 72.871734619141),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0.47858771681786, 0),
	fov = 5.2163399309532,
}

ITEM.destroyval = {
	["comp_scrap_metal"] = 2,
}