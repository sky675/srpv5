ITEM.name = "M406 Round"
ITEM.model = "models/kek1ch/ammo_m209.mdl"
ITEM.ammo = "skym203" // type of the ammo
ITEM.maxQuantity = 1 // amount of the ammo
ITEM.desc = "A single round for the M203."
ITEM.price = 7664
ITEM.category = "Ammunition"
ITEM.flag = "s"
ITEM.weight = 0.2
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(52.118522644043, 43.849998474121, 31.733812332153),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0, 0),
	fov = 3.2125706423358,
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
