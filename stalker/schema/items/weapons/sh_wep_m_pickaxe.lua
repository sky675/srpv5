ITEM.name = "Pickaxe" --tier 1 melee
ITEM.desc = "A large metal pickaxe."
ITEM.price = 3300
ITEM.model = "models/weapons/tfa_nmrih/w_me_pickaxe.mdl"
ITEM.width = 2
ITEM.height = 4
ITEM.weight = 3
ITEM.flag = "1"
ITEM.category = "Weapons - Melees"
ITEM.class = "sky_m_nmrih_pickaxe"
ITEM.weaponCategory = "melee"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(111.2872543335, 91.594146728516, 72.385032653809),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0.47858771681786, 0),
	fov = 6.4948849186345,
}

ITEM.destroyval = {
	["comp_scrap_metal"] = 3,
}