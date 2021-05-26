ITEM.name = "M406 Round"
ITEM.model = "models/spec45as/stalker/ammo/ammo_m209.mdl"
ITEM.ammo = "skym203" // type of the ammo
ITEM.maxQuantity = 1 // amount of the ammo
ITEM.desc = "A single round for the M203."
ITEM.price = 7664
ITEM.category = "Ammunition"
ITEM.flag = "2"
ITEM.weight = 0.2
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-0.63249033689499, 11.107911109924, -0.73422282934189),
	ang = Angle(0, 270, 0),
	entAng = Angle(-32.809741973877, -38.580421447754, -2.2379274368286),
	fov = 45.325249134121,
}


function ITEM:getDesc()
    local desc = self.desc
    if(self:getQuantity() > 1) then
        desc = "%s rounds for the M203."
    end

	return Format(desc, self:getQuantity())
end

function ITEM:onGetDropModel(ent)
    if(self:getQuantity() > 1) then
        return "models/Items/BoxMRounds.mdl"
    end
    return self.model
end
