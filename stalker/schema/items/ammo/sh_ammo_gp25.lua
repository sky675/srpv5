ITEM.name = "VOG-25 Round"
ITEM.model = "models/kek1ch/ammo_vog_25.mdl"
ITEM.ammo = "skygp25" // type of the ammo
ITEM.maxQuantity = 1 // amount of the ammo
ITEM.desc = "A single GP-25 round."
ITEM.price = 7580
ITEM.category = "Ammunition"
ITEM.flag = "s"
ITEM.weight = 0.26
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(54.21325302124, 45.465267181396, 32.98412322998),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0, 0),
	fov = 3.316211319198,
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
