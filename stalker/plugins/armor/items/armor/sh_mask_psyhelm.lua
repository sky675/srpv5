ITEM.name = "Psy-Helmet"
ITEM.desc = "Prototype developed by scientists to protect people from psy-emissions."
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_item_psi_helmet.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.7
ITEM.outfitCategory = "head"
ITEM.price = 17500
ITEM.flag = "E"
--[[ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.8751373291, 154.96575927734, 114.09674835205),
	ang = Angle(25, 220, 0),
	entAng = Angle(11.853380203247, 0.23231868445873, -12.186507225037),
	fov = 2.7732601405786,
}]]
ITEM.size = "nonelol" --helm, light, medium, heavy, exo, mask, vest, sci, seva

--interface/inv_items_cloth_2.ogg masks
--interface/inv_items_cloth_3.ogg helms works i guess?
ITEM.equipSound = "interface/inv_items_cloth_2.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_2.ogg"
--[[
local modelsgoodfor1 = {
	["models/sky/heads/neo.mdl"] = true,

}
]]

function ITEM:canWear(ply)
	return true
	--[[local model = ply:GetModel()
	if(model:find("sky/stalker") or nut.newchar.isBM(model)) then
		return true
	else
		return false, "Your model cannot wear this item!"
	end]]
end

ITEM.armor = {
	head = {level = ARMOR_NONE},
}
ITEM.resists = {
	--psy
	[DMG_SONIC] = 1,
	["psy"] = 1,
}