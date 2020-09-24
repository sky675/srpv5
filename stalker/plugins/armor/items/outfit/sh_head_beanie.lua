ITEM.name = "Blue Beanie"
ITEM.desc = "A blue beanie. May have clipping with some masks."
ITEM.model = "models/sky/dropped/beanie.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "head"
ITEM.price = 580
ITEM.flag = "0"
ITEM.permit = "cloth"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.8751373291, 154.96575927734, 113.36277770996),
	ang = Angle(25, 220, 0),
	entAng = Angle(13.300696372986, 0.23231868445873, -9.5186910629272),
	fov = 2.4224293883033,
}

ITEM.equipSound = "interface/inv_items_cloth_2.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_2.ogg"

ITEM.destroyval = {
	["comp_scrap_cloth"] = 2,
}

function ITEM:getBodyGroups(ply)
	local bg = {["beanie"] = 1}
	if(!ply:isFemale()) then
		bg = {["beanies"] = 1}
	end
	if(ply:GetBodygroupCount(1) == 3 and !ply:GetModel():find("neo")) then --if theres 2 heads and a blank
		bg["head"] = 1 --get the 2nd head, otherwise its fine, the heads wont clip
	end 
	local hair = ply:FindBodygroupByName("hair")
	if(hair != -1 and ply:GetBodygroupCount(hair) == 3) then --hide hair too
		bg["hair"] = 2
	elseif(hair != -1) then
		bg["hair"] = 1
	end
	return bg
end

function ITEM:canWear(ply)
	local model = ply:GetModel()
	if(model:find("sky/stalker") or nut.newchar.isBM(model)) then
		return true
	else
		return false, "Your model cannot wear this item!"
	end
end