ITEM.name = "VOG-25 Round"
ITEM.model = "models/spec45as/stalker/ammo/ammo_vog_25.mdl"
ITEM.ammo = "skygp25" // type of the ammo
ITEM.maxQuantity = 1 // amount of the ammo
ITEM.desc = "A single GP-25 round."
ITEM.price = 7580
ITEM.category = "Ammunition"
ITEM.flag = "2"
ITEM.weight = 0.26
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-0.63249033689499, 11.107911109924, -0.42022541165352),
	ang = Angle(0, 270, 0),
	entAng = Angle(-32.809741973877, -38.580421447754, -2.2379274368286),
	fov = 45.325249134121,
}


function ITEM:getDesc()
    local desc = self.desc
    if(self:getQuantity() > 1) then
        desc = "%s rounds for the GP25."
    end

	return Format(desc, self:getQuantity())
end

function ITEM:onGetDropModel(ent)
    if(self:getQuantity() > 1) then
        return "models/Items/BoxMRounds.mdl"
    end
    return self.model
end
