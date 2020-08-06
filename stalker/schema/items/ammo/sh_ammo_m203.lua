ITEM.name = "M406 Round"
ITEM.model = "models/Items/AR2_Grenade.mdl"
ITEM.ammo = "skym203" // type of the ammo
ITEM.maxQuantity = 1 // amount of the ammo
ITEM.desc = "A single round for the M203."
ITEM.price = 7664
ITEM.category = "Ammunition"
ITEM.flag = "s"
ITEM.weight = 0.2

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
